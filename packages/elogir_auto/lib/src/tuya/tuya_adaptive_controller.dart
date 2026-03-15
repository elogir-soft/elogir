import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../controllers/cover_controller.dart';
import '../controllers/device_controller.dart';
import '../controllers/light_controller.dart';
import '../controllers/switch_controller.dart';
import '../models/cover_state.dart';
import '../models/light_state.dart';
import '../models/switch_state.dart';

/// Wraps an optional LAN controller and optional cloud controller.
/// Tries LAN first, falls back to cloud.
abstract class TuyaAdaptiveController<T> implements DeviceController<T> {
  TuyaAdaptiveController({
    this.lanController,
    this.cloudController,
  }) : _subject = BehaviorSubject<T>();

  final DeviceController<T>? lanController;
  final DeviceController<T>? cloudController;
  final BehaviorSubject<T> _subject;

  DeviceController<T>? _active;
  StreamSubscription<T>? _subscription;

  @override
  Stream<T> get stateStream => _subject.stream;

  @override
  T? get currentState => _subject.valueOrNull;

  @override
  Future<void> connect() async {
    if (lanController != null) {
      try {
        await lanController!.connect().timeout(const Duration(seconds: 5));
        _setActive(lanController!);
        return;
      } on Object {
        // LAN failed — try cloud.
      }
    }

    if (cloudController != null) {
      await cloudController!.connect();
      _setActive(cloudController!);
      return;
    }

    throw StateError('No controller available — neither LAN nor cloud.');
  }

  @override
  Future<void> disconnect() async {
    await _subscription?.cancel();
    _subscription = null;
    await _active?.disconnect();
    _active = null;
  }

  @override
  Future<T> refresh() async {
    if (_active == null) throw StateError('Not connected.');
    return _active!.refresh();
  }

  Future<void> dispose() async {
    await disconnect();
    await _subject.close();
  }

  void _setActive(DeviceController<T> controller) {
    _active = controller;
    _subscription?.cancel();
    _subscription = controller.stateStream.listen(_subject.add);

    // Seed immediately — BehaviorSubject stream replay fires via microtask,
    // so currentState would be null until the next event-loop turn without this.
    final current = controller.currentState;
    if (current != null) {
      _subject.add(current);
    }
  }
}

/// Adaptive switch controller that delegates switch methods to the active
/// underlying controller.
class TuyaAdaptiveSwitchController extends TuyaAdaptiveController<SwitchState>
    implements SwitchController {
  TuyaAdaptiveSwitchController({
    super.lanController,
    super.cloudController,
  });

  SwitchController get _activeSwitchController =>
      _active! as SwitchController;

  @override
  Future<void> turnOn({int channel = 1}) =>
      _activeSwitchController.turnOn(channel: channel);

  @override
  Future<void> turnOff({int channel = 1}) =>
      _activeSwitchController.turnOff(channel: channel);

  @override
  Future<void> toggle({int channel = 1}) =>
      _activeSwitchController.toggle(channel: channel);
}

/// Adaptive light controller that delegates light methods to the active
/// underlying controller.
class TuyaAdaptiveLightController extends TuyaAdaptiveController<LightState>
    implements LightController {
  TuyaAdaptiveLightController({
    super.lanController,
    super.cloudController,
  });

  LightController get _activeLightController =>
      _active! as LightController;

  @override
  Future<void> turnOn() => _activeLightController.turnOn();

  @override
  Future<void> turnOff() => _activeLightController.turnOff();

  @override
  Future<void> setBrightness(int percentage) =>
      _activeLightController.setBrightness(percentage);

  @override
  Future<void> setColor(int r, int g, int b) =>
      _activeLightController.setColor(r, g, b);

  @override
  Future<void> setColorTemperature(int percentage) =>
      _activeLightController.setColorTemperature(percentage);

  @override
  Future<void> setMode(LightMode mode) =>
      _activeLightController.setMode(mode);
}

/// Adaptive cover controller that delegates cover methods to the active
/// underlying controller.
class TuyaAdaptiveCoverController extends TuyaAdaptiveController<CoverState>
    implements CoverController {
  TuyaAdaptiveCoverController({
    super.lanController,
    super.cloudController,
  });

  CoverController get _activeCoverController =>
      _active! as CoverController;

  @override
  Future<void> open({int channel = 1}) =>
      _activeCoverController.open(channel: channel);

  @override
  Future<void> close({int channel = 1}) =>
      _activeCoverController.close(channel: channel);

  @override
  Future<void> stop({int channel = 1}) =>
      _activeCoverController.stop(channel: channel);
}
