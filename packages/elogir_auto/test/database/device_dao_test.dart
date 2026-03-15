import 'package:drift/native.dart';
import 'package:elogir_auto/elogir_auto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AutoDatabase db;
  late DeviceDao dao;

  setUp(() {
    db = AutoDatabase.forTesting(NativeDatabase.memory());
    dao = db.deviceDao;
  });

  tearDown(() async {
    await db.close();
  });

  SmartDevice makeDevice({
    String id = 'dev-1',
    String name = 'Test Device',
    DeviceType type = DeviceType.light,
  }) {
    return SmartDevice(
      id: id,
      name: name,
      type: type,
      connection: const DeviceConnection.tuya(
        deviceId: 'tuya-123',
        address: '192.168.1.100',
        localKey: 'localkey',
      ),
    );
  }

  group('DeviceDao', () {
    test('getAll returns empty list initially', () async {
      final devices = await dao.getAll();
      expect(devices, isEmpty);
    });

    test('upsert and getById', () async {
      final device = makeDevice();
      await dao.upsert(device);

      final retrieved = await dao.getById('dev-1');
      expect(retrieved, isNotNull);
      expect(retrieved!.id, 'dev-1');
      expect(retrieved.name, 'Test Device');
      expect(retrieved.type, DeviceType.light);
      expect(retrieved.connection, isA<TuyaConnection>());

      final tuya = retrieved.connection as TuyaConnection;
      expect(tuya.deviceId, 'tuya-123');
      expect(tuya.address, '192.168.1.100');
      expect(tuya.localKey, 'localkey');
    });

    test('upsert updates existing device', () async {
      await dao.upsert(makeDevice(name: 'Original'));
      await dao.upsert(makeDevice(name: 'Updated'));

      final devices = await dao.getAll();
      expect(devices, hasLength(1));
      expect(devices.first.name, 'Updated');
    });

    test('getAll returns all devices', () async {
      await dao.upsert(makeDevice(id: 'a', name: 'Device A'));
      await dao.upsert(
        makeDevice(
          id: 'b',
          name: 'Device B',
          type: DeviceType.switchDevice,
        ),
      );
      await dao.upsert(
        makeDevice(id: 'c', name: 'Device C', type: DeviceType.cover),
      );

      final devices = await dao.getAll();
      expect(devices, hasLength(3));
    });

    test('deleteById removes the device', () async {
      await dao.upsert(makeDevice());
      await dao.deleteById('dev-1');

      final retrieved = await dao.getById('dev-1');
      expect(retrieved, isNull);
    });

    test('getById returns null for non-existent id', () async {
      final result = await dao.getById('non-existent');
      expect(result, isNull);
    });

    test('watchAll emits updates', () async {
      final stream = dao.watchAll();

      // Initial empty list
      await expectLater(stream, emits(isEmpty));

      // After insert
      await dao.upsert(makeDevice(id: 'dev-1'));
      await expectLater(stream, emits(hasLength(1)));

      // After second insert
      await dao.upsert(makeDevice(id: 'dev-2', name: 'Second'));
      await expectLater(stream, emits(hasLength(2)));

      // After delete
      await dao.deleteById('dev-1');
      await expectLater(stream, emits(hasLength(1)));
    });

    test('preserves DeviceConnection JSON through round-trip', () async {
      const device = SmartDevice(
        id: 'dev-rt',
        name: 'Round Trip',
        type: DeviceType.light,
        connection: DeviceConnection.tuya(
          deviceId: 'tuya-rt',
          address: '10.0.0.1',
          localKey: 'secret',
          version: 3.4,
          port: 7777,
        ),
      );

      await dao.upsert(device);
      final retrieved = await dao.getById('dev-rt');
      expect(retrieved, isNotNull);

      final tuya = retrieved!.connection as TuyaConnection;
      expect(tuya.version, 3.4);
      expect(tuya.port, 7777);
    });
  });
}
