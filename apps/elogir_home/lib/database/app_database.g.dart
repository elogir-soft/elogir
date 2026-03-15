// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, SettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _use24HourFormatMeta = const VerificationMeta(
    'use24HourFormat',
  );
  @override
  late final GeneratedColumn<bool> use24HourFormat = GeneratedColumn<bool>(
    'use24_hour_format',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use24_hour_format" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, themeMode, use24HourFormat];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('use24_hour_format')) {
      context.handle(
        _use24HourFormatMeta,
        use24HourFormat.isAcceptableOrUnknown(
          data['use24_hour_format']!,
          _use24HourFormatMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      use24HourFormat: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use24_hour_format'],
      )!,
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }
}

class SettingsTableData extends DataClass
    implements Insertable<SettingsTableData> {
  final int id;

  /// One of 'system', 'light', 'dark'.
  final String themeMode;
  final bool use24HourFormat;
  const SettingsTableData({
    required this.id,
    required this.themeMode,
    required this.use24HourFormat,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['theme_mode'] = Variable<String>(themeMode);
    map['use24_hour_format'] = Variable<bool>(use24HourFormat);
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      use24HourFormat: Value(use24HourFormat),
    );
  }

  factory SettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsTableData(
      id: serializer.fromJson<int>(json['id']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      use24HourFormat: serializer.fromJson<bool>(json['use24HourFormat']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<String>(themeMode),
      'use24HourFormat': serializer.toJson<bool>(use24HourFormat),
    };
  }

  SettingsTableData copyWith({
    int? id,
    String? themeMode,
    bool? use24HourFormat,
  }) => SettingsTableData(
    id: id ?? this.id,
    themeMode: themeMode ?? this.themeMode,
    use24HourFormat: use24HourFormat ?? this.use24HourFormat,
  );
  SettingsTableData copyWithCompanion(SettingsTableCompanion data) {
    return SettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      use24HourFormat: data.use24HourFormat.present
          ? data.use24HourFormat.value
          : this.use24HourFormat,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableData(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('use24HourFormat: $use24HourFormat')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, themeMode, use24HourFormat);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsTableData &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.use24HourFormat == this.use24HourFormat);
}

class SettingsTableCompanion extends UpdateCompanion<SettingsTableData> {
  final Value<int> id;
  final Value<String> themeMode;
  final Value<bool> use24HourFormat;
  const SettingsTableCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.use24HourFormat = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.use24HourFormat = const Value.absent(),
  });
  static Insertable<SettingsTableData> custom({
    Expression<int>? id,
    Expression<String>? themeMode,
    Expression<bool>? use24HourFormat,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (use24HourFormat != null) 'use24_hour_format': use24HourFormat,
    });
  }

  SettingsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? themeMode,
    Value<bool>? use24HourFormat,
  }) {
    return SettingsTableCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      use24HourFormat: use24HourFormat ?? this.use24HourFormat,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (use24HourFormat.present) {
      map['use24_hour_format'] = Variable<bool>(use24HourFormat.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('use24HourFormat: $use24HourFormat')
          ..write(')'))
        .toString();
  }
}

class $AutomationTableTable extends AutomationTable
    with TableInfo<$AutomationTableTable, AutomationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AutomationTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _triggerMeta = const VerificationMeta(
    'trigger',
  );
  @override
  late final GeneratedColumn<String> trigger = GeneratedColumn<String>(
    'trigger',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionsMeta = const VerificationMeta(
    'actions',
  );
  @override
  late final GeneratedColumn<String> actions = GeneratedColumn<String>(
    'actions',
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    isEnabled,
    trigger,
    actions,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'automation_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AutomationTableData> instance, {
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
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('trigger')) {
      context.handle(
        _triggerMeta,
        trigger.isAcceptableOrUnknown(data['trigger']!, _triggerMeta),
      );
    } else if (isInserting) {
      context.missing(_triggerMeta);
    }
    if (data.containsKey('actions')) {
      context.handle(
        _actionsMeta,
        actions.isAcceptableOrUnknown(data['actions']!, _actionsMeta),
      );
    } else if (isInserting) {
      context.missing(_actionsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AutomationTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AutomationTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      trigger: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger'],
      )!,
      actions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actions'],
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
  $AutomationTableTable createAlias(String alias) {
    return $AutomationTableTable(attachedDatabase, alias);
  }
}

class AutomationTableData extends DataClass
    implements Insertable<AutomationTableData> {
  final String id;
  final String name;
  final bool isEnabled;

  /// JSON-encoded automation trigger.
  final String trigger;

  /// JSON-encoded [List<AutomationAction>].
  final String actions;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AutomationTableData({
    required this.id,
    required this.name,
    required this.isEnabled,
    required this.trigger,
    required this.actions,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['trigger'] = Variable<String>(trigger);
    map['actions'] = Variable<String>(actions);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AutomationTableCompanion toCompanion(bool nullToAbsent) {
    return AutomationTableCompanion(
      id: Value(id),
      name: Value(name),
      isEnabled: Value(isEnabled),
      trigger: Value(trigger),
      actions: Value(actions),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AutomationTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AutomationTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      trigger: serializer.fromJson<String>(json['trigger']),
      actions: serializer.fromJson<String>(json['actions']),
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
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'trigger': serializer.toJson<String>(trigger),
      'actions': serializer.toJson<String>(actions),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AutomationTableData copyWith({
    String? id,
    String? name,
    bool? isEnabled,
    String? trigger,
    String? actions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AutomationTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    isEnabled: isEnabled ?? this.isEnabled,
    trigger: trigger ?? this.trigger,
    actions: actions ?? this.actions,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AutomationTableData copyWithCompanion(AutomationTableCompanion data) {
    return AutomationTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      trigger: data.trigger.present ? data.trigger.value : this.trigger,
      actions: data.actions.present ? data.actions.value : this.actions,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AutomationTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('trigger: $trigger, ')
          ..write('actions: $actions, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, isEnabled, trigger, actions, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AutomationTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.isEnabled == this.isEnabled &&
          other.trigger == this.trigger &&
          other.actions == this.actions &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AutomationTableCompanion extends UpdateCompanion<AutomationTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> isEnabled;
  final Value<String> trigger;
  final Value<String> actions;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AutomationTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.trigger = const Value.absent(),
    this.actions = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AutomationTableCompanion.insert({
    required String id,
    required String name,
    this.isEnabled = const Value.absent(),
    required String trigger,
    required String actions,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       trigger = Value(trigger),
       actions = Value(actions),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AutomationTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<bool>? isEnabled,
    Expression<String>? trigger,
    Expression<String>? actions,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (trigger != null) 'trigger': trigger,
      if (actions != null) 'actions': actions,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AutomationTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<bool>? isEnabled,
    Value<String>? trigger,
    Value<String>? actions,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AutomationTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isEnabled: isEnabled ?? this.isEnabled,
      trigger: trigger ?? this.trigger,
      actions: actions ?? this.actions,
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
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (trigger.present) {
      map['trigger'] = Variable<String>(trigger.value);
    }
    if (actions.present) {
      map['actions'] = Variable<String>(actions.value);
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
    return (StringBuffer('AutomationTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('trigger: $trigger, ')
          ..write('actions: $actions, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  late final $AutomationTableTable automationTable = $AutomationTableTable(
    this,
  );
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  late final AutomationDao automationDao = AutomationDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    settingsTable,
    automationTable,
  ];
}

typedef $$SettingsTableTableCreateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<int> id,
      Value<String> themeMode,
      Value<bool> use24HourFormat,
    });
typedef $$SettingsTableTableUpdateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<int> id,
      Value<String> themeMode,
      Value<bool> use24HourFormat,
    });

class $$SettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get use24HourFormat => $composableBuilder(
    column: $table.use24HourFormat,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get use24HourFormat => $composableBuilder(
    column: $table.use24HourFormat,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<bool> get use24HourFormat => $composableBuilder(
    column: $table.use24HourFormat,
    builder: (column) => column,
  );
}

class $$SettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTableTable,
          SettingsTableData,
          $$SettingsTableTableFilterComposer,
          $$SettingsTableTableOrderingComposer,
          $$SettingsTableTableAnnotationComposer,
          $$SettingsTableTableCreateCompanionBuilder,
          $$SettingsTableTableUpdateCompanionBuilder,
          (
            SettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $SettingsTableTable,
              SettingsTableData
            >,
          ),
          SettingsTableData,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableTableManager(_$AppDatabase db, $SettingsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> use24HourFormat = const Value.absent(),
              }) => SettingsTableCompanion(
                id: id,
                themeMode: themeMode,
                use24HourFormat: use24HourFormat,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> use24HourFormat = const Value.absent(),
              }) => SettingsTableCompanion.insert(
                id: id,
                themeMode: themeMode,
                use24HourFormat: use24HourFormat,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTableTable,
      SettingsTableData,
      $$SettingsTableTableFilterComposer,
      $$SettingsTableTableOrderingComposer,
      $$SettingsTableTableAnnotationComposer,
      $$SettingsTableTableCreateCompanionBuilder,
      $$SettingsTableTableUpdateCompanionBuilder,
      (
        SettingsTableData,
        BaseReferences<_$AppDatabase, $SettingsTableTable, SettingsTableData>,
      ),
      SettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$AutomationTableTableCreateCompanionBuilder =
    AutomationTableCompanion Function({
      required String id,
      required String name,
      Value<bool> isEnabled,
      required String trigger,
      required String actions,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AutomationTableTableUpdateCompanionBuilder =
    AutomationTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<bool> isEnabled,
      Value<String> trigger,
      Value<String> actions,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AutomationTableTableFilterComposer
    extends Composer<_$AppDatabase, $AutomationTableTable> {
  $$AutomationTableTableFilterComposer({
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

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actions => $composableBuilder(
    column: $table.actions,
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

class $$AutomationTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AutomationTableTable> {
  $$AutomationTableTableOrderingComposer({
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

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actions => $composableBuilder(
    column: $table.actions,
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

class $$AutomationTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AutomationTableTable> {
  $$AutomationTableTableAnnotationComposer({
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

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get trigger =>
      $composableBuilder(column: $table.trigger, builder: (column) => column);

  GeneratedColumn<String> get actions =>
      $composableBuilder(column: $table.actions, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AutomationTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AutomationTableTable,
          AutomationTableData,
          $$AutomationTableTableFilterComposer,
          $$AutomationTableTableOrderingComposer,
          $$AutomationTableTableAnnotationComposer,
          $$AutomationTableTableCreateCompanionBuilder,
          $$AutomationTableTableUpdateCompanionBuilder,
          (
            AutomationTableData,
            BaseReferences<
              _$AppDatabase,
              $AutomationTableTable,
              AutomationTableData
            >,
          ),
          AutomationTableData,
          PrefetchHooks Function()
        > {
  $$AutomationTableTableTableManager(
    _$AppDatabase db,
    $AutomationTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AutomationTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AutomationTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AutomationTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String> trigger = const Value.absent(),
                Value<String> actions = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AutomationTableCompanion(
                id: id,
                name: name,
                isEnabled: isEnabled,
                trigger: trigger,
                actions: actions,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<bool> isEnabled = const Value.absent(),
                required String trigger,
                required String actions,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AutomationTableCompanion.insert(
                id: id,
                name: name,
                isEnabled: isEnabled,
                trigger: trigger,
                actions: actions,
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

typedef $$AutomationTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AutomationTableTable,
      AutomationTableData,
      $$AutomationTableTableFilterComposer,
      $$AutomationTableTableOrderingComposer,
      $$AutomationTableTableAnnotationComposer,
      $$AutomationTableTableCreateCompanionBuilder,
      $$AutomationTableTableUpdateCompanionBuilder,
      (
        AutomationTableData,
        BaseReferences<
          _$AppDatabase,
          $AutomationTableTable,
          AutomationTableData
        >,
      ),
      AutomationTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
  $$AutomationTableTableTableManager get automationTable =>
      $$AutomationTableTableTableManager(_db, _db.automationTable);
}
