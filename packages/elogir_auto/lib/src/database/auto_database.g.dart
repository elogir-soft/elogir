// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_database.dart';

// ignore_for_file: type=lint
class $DeviceEntriesTable extends DeviceEntries
    with TableInfo<$DeviceEntriesTable, DeviceEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _connectionJsonMeta = const VerificationMeta(
    'connectionJson',
  );
  @override
  late final GeneratedColumn<String> connectionJson = GeneratedColumn<String>(
    'connection_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    connectionJson,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeviceEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('connection_json')) {
      context.handle(
        _connectionJsonMeta,
        connectionJson.isAcceptableOrUnknown(
          data['connection_json']!,
          _connectionJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_connectionJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeviceEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      connectionJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connection_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DeviceEntriesTable createAlias(String alias) {
    return $DeviceEntriesTable(attachedDatabase, alias);
  }
}

class DeviceEntry extends DataClass implements Insertable<DeviceEntry> {
  final String id;
  final String name;
  final String type;
  final String connectionJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DeviceEntry({
    required this.id,
    required this.name,
    required this.type,
    required this.connectionJson,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['connection_json'] = Variable<String>(connectionJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DeviceEntriesCompanion toCompanion(bool nullToAbsent) {
    return DeviceEntriesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      connectionJson: Value(connectionJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DeviceEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      connectionJson: serializer.fromJson<String>(json['connectionJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'connectionJson': serializer.toJson<String>(connectionJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DeviceEntry copyWith({
    String? id,
    String? name,
    String? type,
    String? connectionJson,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DeviceEntry(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    connectionJson: connectionJson ?? this.connectionJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DeviceEntry copyWithCompanion(DeviceEntriesCompanion data) {
    return DeviceEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      connectionJson: data.connectionJson.present
          ? data.connectionJson.value
          : this.connectionJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('connectionJson: $connectionJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, connectionJson, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.connectionJson == this.connectionJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DeviceEntriesCompanion extends UpdateCompanion<DeviceEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> connectionJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DeviceEntriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.connectionJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeviceEntriesCompanion.insert({
    required String id,
    required String name,
    required String type,
    required String connectionJson,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       connectionJson = Value(connectionJson);
  static Insertable<DeviceEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? connectionJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (connectionJson != null) 'connection_json': connectionJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeviceEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<String>? connectionJson,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DeviceEntriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      connectionJson: connectionJson ?? this.connectionJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (connectionJson.present) {
      map['connection_json'] = Variable<String>(connectionJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceEntriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('connectionJson: $connectionJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AutoDatabase extends GeneratedDatabase {
  _$AutoDatabase(QueryExecutor e) : super(e);
  $AutoDatabaseManager get managers => $AutoDatabaseManager(this);
  late final $DeviceEntriesTable deviceEntries = $DeviceEntriesTable(this);
  late final DeviceDao deviceDao = DeviceDao(this as AutoDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [deviceEntries];
}

typedef $$DeviceEntriesTableCreateCompanionBuilder =
    DeviceEntriesCompanion Function({
      required String id,
      required String name,
      required String type,
      required String connectionJson,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$DeviceEntriesTableUpdateCompanionBuilder =
    DeviceEntriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<String> connectionJson,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$DeviceEntriesTableFilterComposer
    extends Composer<_$AutoDatabase, $DeviceEntriesTable> {
  $$DeviceEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectionJson => $composableBuilder(
    column: $table.connectionJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeviceEntriesTableOrderingComposer
    extends Composer<_$AutoDatabase, $DeviceEntriesTable> {
  $$DeviceEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectionJson => $composableBuilder(
    column: $table.connectionJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeviceEntriesTableAnnotationComposer
    extends Composer<_$AutoDatabase, $DeviceEntriesTable> {
  $$DeviceEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get connectionJson => $composableBuilder(
    column: $table.connectionJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DeviceEntriesTableTableManager
    extends
        RootTableManager<
          _$AutoDatabase,
          $DeviceEntriesTable,
          DeviceEntry,
          $$DeviceEntriesTableFilterComposer,
          $$DeviceEntriesTableOrderingComposer,
          $$DeviceEntriesTableAnnotationComposer,
          $$DeviceEntriesTableCreateCompanionBuilder,
          $$DeviceEntriesTableUpdateCompanionBuilder,
          (
            DeviceEntry,
            BaseReferences<_$AutoDatabase, $DeviceEntriesTable, DeviceEntry>,
          ),
          DeviceEntry,
          PrefetchHooks Function()
        > {
  $$DeviceEntriesTableTableManager(_$AutoDatabase db, $DeviceEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> connectionJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceEntriesCompanion(
                id: id,
                name: name,
                type: type,
                connectionJson: connectionJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                required String connectionJson,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceEntriesCompanion.insert(
                id: id,
                name: name,
                type: type,
                connectionJson: connectionJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeviceEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AutoDatabase,
      $DeviceEntriesTable,
      DeviceEntry,
      $$DeviceEntriesTableFilterComposer,
      $$DeviceEntriesTableOrderingComposer,
      $$DeviceEntriesTableAnnotationComposer,
      $$DeviceEntriesTableCreateCompanionBuilder,
      $$DeviceEntriesTableUpdateCompanionBuilder,
      (
        DeviceEntry,
        BaseReferences<_$AutoDatabase, $DeviceEntriesTable, DeviceEntry>,
      ),
      DeviceEntry,
      PrefetchHooks Function()
    >;

class $AutoDatabaseManager {
  final _$AutoDatabase _db;
  $AutoDatabaseManager(this._db);
  $$DeviceEntriesTableTableManager get deviceEntries =>
      $$DeviceEntriesTableTableManager(_db, _db.deviceEntries);
}
