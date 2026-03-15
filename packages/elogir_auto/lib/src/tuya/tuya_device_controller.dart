import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tinytuya/tinytuya.dart' as tuya;

import '../controllers/device_controller.dart';
import '../models/smart_device.dart';

abstract class TuyaDeviceController<T> implements DeviceController<T> {
  TuyaDeviceController(this.device)
      : _subject = BehaviorSubject<T>();

  final SmartDevice device;
  final BehaviorSubject<T> _subject;

  @protected
  tuya.Device? tuyaDevice;

  @override
  Stream<T> get stateStream => _subject.stream;

  @override
  T? get currentState => _subject.valueOrNull;

  TuyaConnection get _connection => device.connection as TuyaConnection;

  @override
  Future<void> connect() async {
    tuyaDevice = createTuyaDevice();
    await refresh();
  }

  @override
  Future<void> disconnect() async {
    await tuyaDevice?.close();
    tuyaDevice = null;
  }

  @override
  Future<T> refresh() async {
    final status = await tuyaDevice!.status();
    final dps = status['dps'] as Map<String, dynamic>?;
    final state = parseState(dps ?? {});
    _subject.add(state);
    return state;
  }

  @protected
  tuya.Device createTuyaDevice() {
    return tuya.Device(
      deviceId: _connection.deviceId,
      address: _connection.address,
      localKey: _connection.localKey,
      version: _connection.version,
      port: _connection.port,
      persist: true,
    );
  }

  @protected
  T parseState(Map<String, dynamic> dps);

  @protected
  void emitState(T state) => _subject.add(state);

  Future<void> dispose() async {
    await disconnect();
    await _subject.close();
  }
}
