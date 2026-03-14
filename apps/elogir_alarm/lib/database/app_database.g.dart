// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AlarmTableTable extends AlarmTable
    with TableInfo<$AlarmTableTable, AlarmTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hourMeta = const VerificationMeta('hour');
  @override
  late final GeneratedColumn<int> hour = GeneratedColumn<int>(
    'hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minuteMeta = const VerificationMeta('minute');
  @override
  late final GeneratedColumn<int> minute = GeneratedColumn<int>(
    'minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
  static const VerificationMeta _repeatDaysMeta = const VerificationMeta(
    'repeatDays',
  );
  @override
  late final GeneratedColumn<String> repeatDays = GeneratedColumn<String>(
    'repeat_days',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _soundIdMeta = const VerificationMeta(
    'soundId',
  );
  @override
  late final GeneratedColumn<String> soundId = GeneratedColumn<String>(
    'sound_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('alarm'),
  );
  static const VerificationMeta _snoozeDurationMinutesMeta =
      const VerificationMeta('snoozeDurationMinutes');
  @override
  late final GeneratedColumn<int> snoozeDurationMinutes = GeneratedColumn<int>(
    'snooze_duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
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
    hour,
    minute,
    label,
    isEnabled,
    repeatDays,
    soundId,
    snoozeDurationMinutes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarm_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AlarmTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('hour')) {
      context.handle(
        _hourMeta,
        hour.isAcceptableOrUnknown(data['hour']!, _hourMeta),
      );
    } else if (isInserting) {
      context.missing(_hourMeta);
    }
    if (data.containsKey('minute')) {
      context.handle(
        _minuteMeta,
        minute.isAcceptableOrUnknown(data['minute']!, _minuteMeta),
      );
    } else if (isInserting) {
      context.missing(_minuteMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('repeat_days')) {
      context.handle(
        _repeatDaysMeta,
        repeatDays.isAcceptableOrUnknown(data['repeat_days']!, _repeatDaysMeta),
      );
    }
    if (data.containsKey('sound_id')) {
      context.handle(
        _soundIdMeta,
        soundId.isAcceptableOrUnknown(data['sound_id']!, _soundIdMeta),
      );
    }
    if (data.containsKey('snooze_duration_minutes')) {
      context.handle(
        _snoozeDurationMinutesMeta,
        snoozeDurationMinutes.isAcceptableOrUnknown(
          data['snooze_duration_minutes']!,
          _snoozeDurationMinutesMeta,
        ),
      );
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
  AlarmTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlarmTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      hour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hour'],
      )!,
      minute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minute'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      repeatDays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repeat_days'],
      )!,
      soundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sound_id'],
      )!,
      snoozeDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snooze_duration_minutes'],
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
  $AlarmTableTable createAlias(String alias) {
    return $AlarmTableTable(attachedDatabase, alias);
  }
}

class AlarmTableData extends DataClass implements Insertable<AlarmTableData> {
  final String id;
  final int hour;
  final int minute;
  final String label;
  final bool isEnabled;

  /// Comma-separated day indices: 0=Mon, 1=Tue, ..., 6=Sun.
  final String repeatDays;

  /// System sound type: 'alarm', 'ringtone', 'notification'.
  final String soundId;
  final int snoozeDurationMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AlarmTableData({
    required this.id,
    required this.hour,
    required this.minute,
    required this.label,
    required this.isEnabled,
    required this.repeatDays,
    required this.soundId,
    required this.snoozeDurationMinutes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['hour'] = Variable<int>(hour);
    map['minute'] = Variable<int>(minute);
    map['label'] = Variable<String>(label);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['repeat_days'] = Variable<String>(repeatDays);
    map['sound_id'] = Variable<String>(soundId);
    map['snooze_duration_minutes'] = Variable<int>(snoozeDurationMinutes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AlarmTableCompanion toCompanion(bool nullToAbsent) {
    return AlarmTableCompanion(
      id: Value(id),
      hour: Value(hour),
      minute: Value(minute),
      label: Value(label),
      isEnabled: Value(isEnabled),
      repeatDays: Value(repeatDays),
      soundId: Value(soundId),
      snoozeDurationMinutes: Value(snoozeDurationMinutes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AlarmTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlarmTableData(
      id: serializer.fromJson<String>(json['id']),
      hour: serializer.fromJson<int>(json['hour']),
      minute: serializer.fromJson<int>(json['minute']),
      label: serializer.fromJson<String>(json['label']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      repeatDays: serializer.fromJson<String>(json['repeatDays']),
      soundId: serializer.fromJson<String>(json['soundId']),
      snoozeDurationMinutes: serializer.fromJson<int>(
        json['snoozeDurationMinutes'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'hour': serializer.toJson<int>(hour),
      'minute': serializer.toJson<int>(minute),
      'label': serializer.toJson<String>(label),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'repeatDays': serializer.toJson<String>(repeatDays),
      'soundId': serializer.toJson<String>(soundId),
      'snoozeDurationMinutes': serializer.toJson<int>(snoozeDurationMinutes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AlarmTableData copyWith({
    String? id,
    int? hour,
    int? minute,
    String? label,
    bool? isEnabled,
    String? repeatDays,
    String? soundId,
    int? snoozeDurationMinutes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AlarmTableData(
    id: id ?? this.id,
    hour: hour ?? this.hour,
    minute: minute ?? this.minute,
    label: label ?? this.label,
    isEnabled: isEnabled ?? this.isEnabled,
    repeatDays: repeatDays ?? this.repeatDays,
    soundId: soundId ?? this.soundId,
    snoozeDurationMinutes: snoozeDurationMinutes ?? this.snoozeDurationMinutes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AlarmTableData copyWithCompanion(AlarmTableCompanion data) {
    return AlarmTableData(
      id: data.id.present ? data.id.value : this.id,
      hour: data.hour.present ? data.hour.value : this.hour,
      minute: data.minute.present ? data.minute.value : this.minute,
      label: data.label.present ? data.label.value : this.label,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      repeatDays: data.repeatDays.present
          ? data.repeatDays.value
          : this.repeatDays,
      soundId: data.soundId.present ? data.soundId.value : this.soundId,
      snoozeDurationMinutes: data.snoozeDurationMinutes.present
          ? data.snoozeDurationMinutes.value
          : this.snoozeDurationMinutes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlarmTableData(')
          ..write('id: $id, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('label: $label, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('repeatDays: $repeatDays, ')
          ..write('soundId: $soundId, ')
          ..write('snoozeDurationMinutes: $snoozeDurationMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    hour,
    minute,
    label,
    isEnabled,
    repeatDays,
    soundId,
    snoozeDurationMinutes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmTableData &&
          other.id == this.id &&
          other.hour == this.hour &&
          other.minute == this.minute &&
          other.label == this.label &&
          other.isEnabled == this.isEnabled &&
          other.repeatDays == this.repeatDays &&
          other.soundId == this.soundId &&
          other.snoozeDurationMinutes == this.snoozeDurationMinutes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AlarmTableCompanion extends UpdateCompanion<AlarmTableData> {
  final Value<String> id;
  final Value<int> hour;
  final Value<int> minute;
  final Value<String> label;
  final Value<bool> isEnabled;
  final Value<String> repeatDays;
  final Value<String> soundId;
  final Value<int> snoozeDurationMinutes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AlarmTableCompanion({
    this.id = const Value.absent(),
    this.hour = const Value.absent(),
    this.minute = const Value.absent(),
    this.label = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.repeatDays = const Value.absent(),
    this.soundId = const Value.absent(),
    this.snoozeDurationMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlarmTableCompanion.insert({
    required String id,
    required int hour,
    required int minute,
    this.label = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.repeatDays = const Value.absent(),
    this.soundId = const Value.absent(),
    this.snoozeDurationMinutes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       hour = Value(hour),
       minute = Value(minute),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AlarmTableData> custom({
    Expression<String>? id,
    Expression<int>? hour,
    Expression<int>? minute,
    Expression<String>? label,
    Expression<bool>? isEnabled,
    Expression<String>? repeatDays,
    Expression<String>? soundId,
    Expression<int>? snoozeDurationMinutes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hour != null) 'hour': hour,
      if (minute != null) 'minute': minute,
      if (label != null) 'label': label,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (repeatDays != null) 'repeat_days': repeatDays,
      if (soundId != null) 'sound_id': soundId,
      if (snoozeDurationMinutes != null)
        'snooze_duration_minutes': snoozeDurationMinutes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlarmTableCompanion copyWith({
    Value<String>? id,
    Value<int>? hour,
    Value<int>? minute,
    Value<String>? label,
    Value<bool>? isEnabled,
    Value<String>? repeatDays,
    Value<String>? soundId,
    Value<int>? snoozeDurationMinutes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AlarmTableCompanion(
      id: id ?? this.id,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      label: label ?? this.label,
      isEnabled: isEnabled ?? this.isEnabled,
      repeatDays: repeatDays ?? this.repeatDays,
      soundId: soundId ?? this.soundId,
      snoozeDurationMinutes:
          snoozeDurationMinutes ?? this.snoozeDurationMinutes,
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
    if (hour.present) {
      map['hour'] = Variable<int>(hour.value);
    }
    if (minute.present) {
      map['minute'] = Variable<int>(minute.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (repeatDays.present) {
      map['repeat_days'] = Variable<String>(repeatDays.value);
    }
    if (soundId.present) {
      map['sound_id'] = Variable<String>(soundId.value);
    }
    if (snoozeDurationMinutes.present) {
      map['snooze_duration_minutes'] = Variable<int>(
        snoozeDurationMinutes.value,
      );
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
    return (StringBuffer('AlarmTableCompanion(')
          ..write('id: $id, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('label: $label, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('repeatDays: $repeatDays, ')
          ..write('soundId: $soundId, ')
          ..write('snoozeDurationMinutes: $snoozeDurationMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimerTableTable extends TimerTable
    with TableInfo<$TimerTableTable, TimerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remainingMsMeta = const VerificationMeta(
    'remainingMs',
  );
  @override
  late final GeneratedColumn<int> remainingMs = GeneratedColumn<int>(
    'remaining_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pausedAtMeta = const VerificationMeta(
    'pausedAt',
  );
  @override
  late final GeneratedColumn<DateTime> pausedAt = GeneratedColumn<DateTime>(
    'paused_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    label,
    durationMs,
    remainingMs,
    status,
    startedAt,
    pausedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timer_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimerTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('remaining_ms')) {
      context.handle(
        _remainingMsMeta,
        remainingMs.isAcceptableOrUnknown(
          data['remaining_ms']!,
          _remainingMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_remainingMsMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('paused_at')) {
      context.handle(
        _pausedAtMeta,
        pausedAt.isAcceptableOrUnknown(data['paused_at']!, _pausedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimerTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      )!,
      remainingMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remaining_ms'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      pausedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paused_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TimerTableTable createAlias(String alias) {
    return $TimerTableTable(attachedDatabase, alias);
  }
}

class TimerTableData extends DataClass implements Insertable<TimerTableData> {
  final String id;
  final String label;

  /// Total duration in milliseconds.
  final int durationMs;

  /// Remaining duration in milliseconds.
  final int remainingMs;

  /// Status: 'running', 'paused', 'completed', 'cancelled'.
  final String status;
  final DateTime? startedAt;
  final DateTime? pausedAt;
  final DateTime createdAt;
  const TimerTableData({
    required this.id,
    required this.label,
    required this.durationMs,
    required this.remainingMs,
    required this.status,
    this.startedAt,
    this.pausedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    map['duration_ms'] = Variable<int>(durationMs);
    map['remaining_ms'] = Variable<int>(remainingMs);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || pausedAt != null) {
      map['paused_at'] = Variable<DateTime>(pausedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TimerTableCompanion toCompanion(bool nullToAbsent) {
    return TimerTableCompanion(
      id: Value(id),
      label: Value(label),
      durationMs: Value(durationMs),
      remainingMs: Value(remainingMs),
      status: Value(status),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      pausedAt: pausedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(pausedAt),
      createdAt: Value(createdAt),
    );
  }

  factory TimerTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimerTableData(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
      remainingMs: serializer.fromJson<int>(json['remainingMs']),
      status: serializer.fromJson<String>(json['status']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      pausedAt: serializer.fromJson<DateTime?>(json['pausedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'durationMs': serializer.toJson<int>(durationMs),
      'remainingMs': serializer.toJson<int>(remainingMs),
      'status': serializer.toJson<String>(status),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'pausedAt': serializer.toJson<DateTime?>(pausedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TimerTableData copyWith({
    String? id,
    String? label,
    int? durationMs,
    int? remainingMs,
    String? status,
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> pausedAt = const Value.absent(),
    DateTime? createdAt,
  }) => TimerTableData(
    id: id ?? this.id,
    label: label ?? this.label,
    durationMs: durationMs ?? this.durationMs,
    remainingMs: remainingMs ?? this.remainingMs,
    status: status ?? this.status,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    pausedAt: pausedAt.present ? pausedAt.value : this.pausedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  TimerTableData copyWithCompanion(TimerTableCompanion data) {
    return TimerTableData(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      remainingMs: data.remainingMs.present
          ? data.remainingMs.value
          : this.remainingMs,
      status: data.status.present ? data.status.value : this.status,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      pausedAt: data.pausedAt.present ? data.pausedAt.value : this.pausedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimerTableData(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('durationMs: $durationMs, ')
          ..write('remainingMs: $remainingMs, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('pausedAt: $pausedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    label,
    durationMs,
    remainingMs,
    status,
    startedAt,
    pausedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimerTableData &&
          other.id == this.id &&
          other.label == this.label &&
          other.durationMs == this.durationMs &&
          other.remainingMs == this.remainingMs &&
          other.status == this.status &&
          other.startedAt == this.startedAt &&
          other.pausedAt == this.pausedAt &&
          other.createdAt == this.createdAt);
}

class TimerTableCompanion extends UpdateCompanion<TimerTableData> {
  final Value<String> id;
  final Value<String> label;
  final Value<int> durationMs;
  final Value<int> remainingMs;
  final Value<String> status;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> pausedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TimerTableCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.remainingMs = const Value.absent(),
    this.status = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.pausedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimerTableCompanion.insert({
    required String id,
    this.label = const Value.absent(),
    required int durationMs,
    required int remainingMs,
    required String status,
    this.startedAt = const Value.absent(),
    this.pausedAt = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       durationMs = Value(durationMs),
       remainingMs = Value(remainingMs),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<TimerTableData> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<int>? durationMs,
    Expression<int>? remainingMs,
    Expression<String>? status,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? pausedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (durationMs != null) 'duration_ms': durationMs,
      if (remainingMs != null) 'remaining_ms': remainingMs,
      if (status != null) 'status': status,
      if (startedAt != null) 'started_at': startedAt,
      if (pausedAt != null) 'paused_at': pausedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimerTableCompanion copyWith({
    Value<String>? id,
    Value<String>? label,
    Value<int>? durationMs,
    Value<int>? remainingMs,
    Value<String>? status,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? pausedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TimerTableCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      durationMs: durationMs ?? this.durationMs,
      remainingMs: remainingMs ?? this.remainingMs,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      pausedAt: pausedAt ?? this.pausedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (remainingMs.present) {
      map['remaining_ms'] = Variable<int>(remainingMs.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (pausedAt.present) {
      map['paused_at'] = Variable<DateTime>(pausedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimerTableCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('durationMs: $durationMs, ')
          ..write('remainingMs: $remainingMs, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('pausedAt: $pausedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AlarmTableTable alarmTable = $AlarmTableTable(this);
  late final $TimerTableTable timerTable = $TimerTableTable(this);
  late final AlarmDao alarmDao = AlarmDao(this as AppDatabase);
  late final TimerDao timerDao = TimerDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [alarmTable, timerTable];
}

typedef $$AlarmTableTableCreateCompanionBuilder =
    AlarmTableCompanion Function({
      required String id,
      required int hour,
      required int minute,
      Value<String> label,
      Value<bool> isEnabled,
      Value<String> repeatDays,
      Value<String> soundId,
      Value<int> snoozeDurationMinutes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AlarmTableTableUpdateCompanionBuilder =
    AlarmTableCompanion Function({
      Value<String> id,
      Value<int> hour,
      Value<int> minute,
      Value<String> label,
      Value<bool> isEnabled,
      Value<String> repeatDays,
      Value<String> soundId,
      Value<int> snoozeDurationMinutes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AlarmTableTableFilterComposer
    extends Composer<_$AppDatabase, $AlarmTableTable> {
  $$AlarmTableTableFilterComposer({
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

  ColumnFilters<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get repeatDays => $composableBuilder(
    column: $table.repeatDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get soundId => $composableBuilder(
    column: $table.soundId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get snoozeDurationMinutes => $composableBuilder(
    column: $table.snoozeDurationMinutes,
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

class $$AlarmTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AlarmTableTable> {
  $$AlarmTableTableOrderingComposer({
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

  ColumnOrderings<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repeatDays => $composableBuilder(
    column: $table.repeatDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get soundId => $composableBuilder(
    column: $table.soundId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get snoozeDurationMinutes => $composableBuilder(
    column: $table.snoozeDurationMinutes,
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

class $$AlarmTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlarmTableTable> {
  $$AlarmTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get hour =>
      $composableBuilder(column: $table.hour, builder: (column) => column);

  GeneratedColumn<int> get minute =>
      $composableBuilder(column: $table.minute, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get repeatDays => $composableBuilder(
    column: $table.repeatDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get soundId =>
      $composableBuilder(column: $table.soundId, builder: (column) => column);

  GeneratedColumn<int> get snoozeDurationMinutes => $composableBuilder(
    column: $table.snoozeDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AlarmTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AlarmTableTable,
          AlarmTableData,
          $$AlarmTableTableFilterComposer,
          $$AlarmTableTableOrderingComposer,
          $$AlarmTableTableAnnotationComposer,
          $$AlarmTableTableCreateCompanionBuilder,
          $$AlarmTableTableUpdateCompanionBuilder,
          (
            AlarmTableData,
            BaseReferences<_$AppDatabase, $AlarmTableTable, AlarmTableData>,
          ),
          AlarmTableData,
          PrefetchHooks Function()
        > {
  $$AlarmTableTableTableManager(_$AppDatabase db, $AlarmTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> hour = const Value.absent(),
                Value<int> minute = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String> repeatDays = const Value.absent(),
                Value<String> soundId = const Value.absent(),
                Value<int> snoozeDurationMinutes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AlarmTableCompanion(
                id: id,
                hour: hour,
                minute: minute,
                label: label,
                isEnabled: isEnabled,
                repeatDays: repeatDays,
                soundId: soundId,
                snoozeDurationMinutes: snoozeDurationMinutes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int hour,
                required int minute,
                Value<String> label = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String> repeatDays = const Value.absent(),
                Value<String> soundId = const Value.absent(),
                Value<int> snoozeDurationMinutes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AlarmTableCompanion.insert(
                id: id,
                hour: hour,
                minute: minute,
                label: label,
                isEnabled: isEnabled,
                repeatDays: repeatDays,
                soundId: soundId,
                snoozeDurationMinutes: snoozeDurationMinutes,
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

typedef $$AlarmTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AlarmTableTable,
      AlarmTableData,
      $$AlarmTableTableFilterComposer,
      $$AlarmTableTableOrderingComposer,
      $$AlarmTableTableAnnotationComposer,
      $$AlarmTableTableCreateCompanionBuilder,
      $$AlarmTableTableUpdateCompanionBuilder,
      (
        AlarmTableData,
        BaseReferences<_$AppDatabase, $AlarmTableTable, AlarmTableData>,
      ),
      AlarmTableData,
      PrefetchHooks Function()
    >;
typedef $$TimerTableTableCreateCompanionBuilder =
    TimerTableCompanion Function({
      required String id,
      Value<String> label,
      required int durationMs,
      required int remainingMs,
      required String status,
      Value<DateTime?> startedAt,
      Value<DateTime?> pausedAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$TimerTableTableUpdateCompanionBuilder =
    TimerTableCompanion Function({
      Value<String> id,
      Value<String> label,
      Value<int> durationMs,
      Value<int> remainingMs,
      Value<String> status,
      Value<DateTime?> startedAt,
      Value<DateTime?> pausedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$TimerTableTableFilterComposer
    extends Composer<_$AppDatabase, $TimerTableTable> {
  $$TimerTableTableFilterComposer({
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

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remainingMs => $composableBuilder(
    column: $table.remainingMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get pausedAt => $composableBuilder(
    column: $table.pausedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TimerTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TimerTableTable> {
  $$TimerTableTableOrderingComposer({
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

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remainingMs => $composableBuilder(
    column: $table.remainingMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get pausedAt => $composableBuilder(
    column: $table.pausedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimerTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimerTableTable> {
  $$TimerTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get remainingMs => $composableBuilder(
    column: $table.remainingMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get pausedAt =>
      $composableBuilder(column: $table.pausedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TimerTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimerTableTable,
          TimerTableData,
          $$TimerTableTableFilterComposer,
          $$TimerTableTableOrderingComposer,
          $$TimerTableTableAnnotationComposer,
          $$TimerTableTableCreateCompanionBuilder,
          $$TimerTableTableUpdateCompanionBuilder,
          (
            TimerTableData,
            BaseReferences<_$AppDatabase, $TimerTableTable, TimerTableData>,
          ),
          TimerTableData,
          PrefetchHooks Function()
        > {
  $$TimerTableTableTableManager(_$AppDatabase db, $TimerTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimerTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimerTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimerTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                Value<int> remainingMs = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> pausedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TimerTableCompanion(
                id: id,
                label: label,
                durationMs: durationMs,
                remainingMs: remainingMs,
                status: status,
                startedAt: startedAt,
                pausedAt: pausedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> label = const Value.absent(),
                required int durationMs,
                required int remainingMs,
                required String status,
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> pausedAt = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => TimerTableCompanion.insert(
                id: id,
                label: label,
                durationMs: durationMs,
                remainingMs: remainingMs,
                status: status,
                startedAt: startedAt,
                pausedAt: pausedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TimerTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimerTableTable,
      TimerTableData,
      $$TimerTableTableFilterComposer,
      $$TimerTableTableOrderingComposer,
      $$TimerTableTableAnnotationComposer,
      $$TimerTableTableCreateCompanionBuilder,
      $$TimerTableTableUpdateCompanionBuilder,
      (
        TimerTableData,
        BaseReferences<_$AppDatabase, $TimerTableTable, TimerTableData>,
      ),
      TimerTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AlarmTableTableTableManager get alarmTable =>
      $$AlarmTableTableTableManager(_db, _db.alarmTable);
  $$TimerTableTableTableManager get timerTable =>
      $$TimerTableTableTableManager(_db, _db.timerTable);
}
