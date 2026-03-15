import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/device_dao.dart';
import 'tables/device_entries.dart';

part 'auto_database.g.dart';

@DriftDatabase(tables: [DeviceEntries], daos: [DeviceDao])
class AutoDatabase extends _$AutoDatabase {
  AutoDatabase() : super(_openConnection());

  /// Constructor for testing with an in-memory database.
  AutoDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'elogir_auto.db'));

    return NativeDatabase.createInBackground(file);
  });
}
