import 'dart:convert';

import 'package:elogir_auto/elogir_auto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SmartDevice', () {
    test('serialization round-trip with Tuya connection', () {
      const device = SmartDevice(
        id: 'dev-1',
        name: 'Living Room Light',
        type: DeviceType.light,
        connection: DeviceConnection.tuya(
          deviceId: 'abc123',
          address: '192.168.1.100',
          localKey: 'key123',
          version: 3.4,
          port: 6668,
        ),
      );

      final json = device.toJson();
      final restored = SmartDevice.fromJson(json);

      expect(restored, equals(device));
      expect(restored.id, 'dev-1');
      expect(restored.name, 'Living Room Light');
      expect(restored.type, DeviceType.light);
      expect(restored.connection, isA<TuyaConnection>());

      final tuya = restored.connection as TuyaConnection;
      expect(tuya.deviceId, 'abc123');
      expect(tuya.address, '192.168.1.100');
      expect(tuya.localKey, 'key123');
      expect(tuya.version, 3.4);
      expect(tuya.port, 6668);
    });

    test('serialization round-trip through JSON string', () {
      const device = SmartDevice(
        id: 'dev-2',
        name: 'Kitchen Switch',
        type: DeviceType.switchDevice,
        connection: DeviceConnection.tuya(
          deviceId: 'def456',
          address: '192.168.1.101',
          localKey: 'key456',
        ),
      );

      final jsonString = jsonEncode(device.toJson());
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      final restored = SmartDevice.fromJson(decoded);

      expect(restored, equals(device));
    });

    test('default values for Tuya connection', () {
      const connection = DeviceConnection.tuya(
        deviceId: 'id',
        address: '192.168.1.1',
        localKey: 'key',
      );

      final tuya = connection as TuyaConnection;
      expect(tuya.version, 3.3);
      expect(tuya.port, 6668);
    });

    test('copyWith preserves unchanged fields', () {
      const device = SmartDevice(
        id: 'dev-1',
        name: 'Old Name',
        type: DeviceType.cover,
        connection: DeviceConnection.tuya(
          deviceId: 'abc',
          address: '192.168.1.1',
          localKey: 'key',
        ),
      );

      final updated = device.copyWith(name: 'New Name');

      expect(updated.name, 'New Name');
      expect(updated.id, device.id);
      expect(updated.type, device.type);
      expect(updated.connection, device.connection);
    });
  });

  group('DeviceConnection', () {
    test('Tuya connection round-trips through JSON', () {
      const connection = DeviceConnection.tuya(
        deviceId: 'abc',
        address: '192.168.1.1',
        localKey: 'key',
      );

      final json = connection.toJson();
      final restored = DeviceConnection.fromJson(json);
      expect(restored, isA<TuyaConnection>());
      expect(restored, equals(connection));
    });
  });

  group('LightState', () {
    test('serialization round-trip', () {
      const state = LightState(
        isOn: true,
        brightness: 75,
        r: 128,
        g: 64,
        b: 200,
        colorTemp: 30,
        mode: LightMode.colour,
      );

      final json = state.toJson();
      final restored = LightState.fromJson(json);

      expect(restored, equals(state));
    });

    test('defaults', () {
      const state = LightState();
      expect(state.isOn, false);
      expect(state.brightness, 100);
      expect(state.r, 255);
      expect(state.g, 255);
      expect(state.b, 255);
      expect(state.colorTemp, 50);
      expect(state.mode, LightMode.white);
    });
  });

  group('SwitchState', () {
    test('serialization round-trip', () {
      const state = SwitchState(channels: {1: true, 2: false, 3: true});

      final json = state.toJson();
      final restored = SwitchState.fromJson(json);

      expect(restored, equals(state));
    });
  });

  group('CoverState', () {
    test('serialization round-trip', () {
      const state = CoverState(
        position: 50,
        isMoving: true,
        direction: CoverDirection.opening,
      );

      final json = state.toJson();
      final restored = CoverState.fromJson(json);

      expect(restored, equals(state));
    });
  });

  group('ScanResult', () {
    test('serialization round-trip', () {
      const result = ScanResult(
        ip: '192.168.1.100',
        deviceId: 'abc123',
        version: '3.3',
        productKey: 'prod-key',
      );

      final json = result.toJson();
      final restored = ScanResult.fromJson(json);

      expect(restored, equals(result));
    });
  });

  group('TuyaCredentials', () {
    test('serialization round-trip', () {
      const creds = TuyaCredentials(
        apiKey: 'my-key',
        apiSecret: 'my-secret',
        region: 'us',
      );

      final json = creds.toJson();
      final restored = TuyaCredentials.fromJson(json);

      expect(restored, equals(creds));
    });
  });
}
