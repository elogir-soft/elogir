import 'dart:async';

import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/devices/providers/device_repository_provider.dart';
import 'package:elogir_home/shared/providers/elogir_auto_provider.dart';
import 'package:elogir_home/shared/providers/talker_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_controller_provider.g.dart';

/// Bridges elogir_auto's rxdart-based [DeviceController] into Riverpod.
///
/// Connects/disconnects the controller on lifecycle, subscribes to its
/// state stream, and forwards state updates into Riverpod async state.
@riverpod
class DeviceControllerNotifier extends _$DeviceControllerNotifier {
  DeviceController<dynamic>? _controller;
  StreamSubscription<dynamic>? _subscription;

  /// Access the underlying controller for imperative calls
  /// (e.g. `turnOn()`, `setBrightness()`).
  DeviceController<dynamic>? get controller => _controller;

  @override
  Future<dynamic> build(String deviceId) async {
    final repo = ref.watch(deviceRepositoryProvider);
    final elogirAuto = ref.watch(elogirAutoProvider);
    final talker = ref.watch(talkerProvider);

    final device = await repo.getById(deviceId);
    if (device == null) {
      throw StateError('Device $deviceId not found');
    }

    talker.info('Connecting to ${device.name} (${device.id})');

    _controller = elogirAuto.controllerFor(device);

    try {
      await _controller!.connect();
      talker.info(
        'Connected to ${device.name} — '
        'state: ${_controller!.currentState}',
      );
    } on Exception catch (e, s) {
      talker.handle(e, s, 'Failed to connect to ${device.name}');
      rethrow;
    }

    _subscription = _controller!.stateStream.listen(
      (deviceState) {
        talker.debug('State update for ${device.name}: $deviceState');
        state = AsyncData<dynamic>(deviceState);
      },
      onError: (Object error, StackTrace stack) {
        talker.handle(error, stack, 'Stream error for ${device.name}');
        state = AsyncError<dynamic>(error, stack);
      },
    );

    ref.onDispose(() async {
      talker.info('Disconnecting from ${device.name}');
      await _subscription?.cancel();
      await _controller?.disconnect();
    });

    return _controller!.currentState;
  }

  /// Refresh the device state from the hardware.
  Future<void> refreshState() async {
    if (_controller == null) return;
    final talker = ref.read(talkerProvider);
    state = const AsyncLoading<dynamic>();
    try {
      final newState = await _controller!.refresh();
      talker.info('Refreshed state: $newState');
      state = AsyncData<dynamic>(newState);
    } on Exception catch (e, s) {
      talker.handle(e, s, 'Failed to refresh device state');
      state = AsyncError<dynamic>(e, s);
    }
  }
}
