import 'package:drift/native.dart';
import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/devices/repositories/device_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AutoDatabase db;
  late DeviceRepository repository;

  setUp(() {
    db = AutoDatabase.forTesting(NativeDatabase.memory());
    repository = DeviceRepository(db.deviceDao);
  });

  tearDown(() => db.close());

  group('DeviceRepository', () {
    final testDevice = SmartDevice(
      id: 'test-1',
      name: 'Living Room Light',
      type: DeviceType.light,
      connection: const DeviceConnection.tuya(
        deviceId: 'tuya-123',
        address: '192.168.1.100',
        localKey: 'abc123',
      ),
    );

    test('save and getAll returns device', () async {
      await repository.save(testDevice);
      final devices = await repository.getAll();

      expect(devices, hasLength(1));
      expect(devices.first.id, testDevice.id);
      expect(devices.first.name, testDevice.name);
      expect(devices.first.type, DeviceType.light);
    });

    test('getById returns correct device', () async {
      await repository.save(testDevice);
      final device = await repository.getById('test-1');

      expect(device, isNotNull);
      expect(device!.name, 'Living Room Light');
    });

    test('getById returns null for missing device', () async {
      final device = await repository.getById('nonexistent');

      expect(device, isNull);
    });

    test('delete removes device', () async {
      await repository.save(testDevice);
      await repository.delete('test-1');
      final devices = await repository.getAll();

      expect(devices, isEmpty);
    });

    test('watchAll emits updates', () async {
      final stream = repository.watchAll();

      await repository.save(testDevice);

      await expectLater(
        stream,
        emits(hasLength(1)),
      );
    });

    test('save updates existing device', () async {
      await repository.save(testDevice);
      final updated = SmartDevice(
        id: 'test-1',
        name: 'Updated Light',
        type: DeviceType.light,
        connection: testDevice.connection,
      );
      await repository.save(updated);

      final device = await repository.getById('test-1');
      expect(device!.name, 'Updated Light');
    });
  });
}
