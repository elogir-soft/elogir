import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../controllers/device_controller.dart';
import '../models/smart_device.dart';
import 'tuya_cloud_service.dart';

abstract class TuyaCloudDeviceController<T> implements DeviceController<T> {
  TuyaCloudDeviceController(this.device, this._cloudService)
      : _subject = BehaviorSubject<T>();

  final SmartDevice device;
  final TuyaCloudService _cloudService;
  final BehaviorSubject<T> _subject;

  @override
  Stream<T> get stateStream => _subject.stream;

  @override
  T? get currentState => _subject.valueOrNull;

  String get _tuyaDeviceId =>
      (device.connection as TuyaConnection).deviceId;

  @override
  Future<void> connect() async {
    await refresh();
  }

  @override
  Future<void> disconnect() async {
    // Cloud is stateless HTTP — nothing to disconnect.
  }

  @override
  Future<T> refresh() async {
    final response = await _cloudService.getStatus(_tuyaDeviceId);
    if (response == null || response['success'] != true) {
      throw Exception(
        'Cloud getStatus failed: ${response?['msg'] ?? 'no response'}',
      );
    }
    final result = response['result'] as List<dynamic>? ?? [];
    final codes = <String, dynamic>{};
    for (final item in result) {
      if (item is Map<String, dynamic>) {
        final code = item['code'] as String?;
        if (code != null) {
          codes[code] = item['value'];
        }
      }
    }
    debugPrint('Cloud status for $_tuyaDeviceId: $codes');
    final state = parseCloudStatus(codes);
    _subject.add(state);
    return state;
  }

  /// Sends a command to the cloud and emits [expectedState] immediately.
  ///
  /// The cloud has a propagation delay — refreshing right after a command
  /// returns stale data. Instead, we emit the expected state so the UI
  /// updates instantly, then schedule a delayed refresh to confirm.
  @protected
  Future<void> sendCloudCommand(
    List<Map<String, dynamic>> commands, {
    T? expectedState,
  }) async {
    final response = await _cloudService.sendCommand(
      _tuyaDeviceId,
      {'commands': commands},
    );
    if (response == null || response['success'] != true) {
      throw Exception(
        'Cloud sendCommand failed: ${response?['msg'] ?? 'no response'}',
      );
    }
    if (expectedState != null) {
      _subject.add(expectedState);
    }
    // Delayed refresh to pick up actual device state after propagation.
    Future<void>.delayed(const Duration(seconds: 3), () async {
      try {
        await refresh();
      } on Exception {
        // Ignore — the expected state is already emitted.
      }
    });
  }

  @protected
  T parseCloudStatus(Map<String, dynamic> codes);

  @protected
  void emitState(T state) => _subject.add(state);

  Future<void> dispose() async {
    await disconnect();
    await _subject.close();
  }
}
