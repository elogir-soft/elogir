// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Alarm {

 String get id; int get hour; int get minute; DateTime get createdAt; DateTime get updatedAt; String get label; bool get isEnabled; List<int> get repeatDays; String get soundId; int get snoozeDurationMinutes; DateTime? get snoozedUntil;
/// Create a copy of Alarm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlarmCopyWith<Alarm> get copyWith => _$AlarmCopyWithImpl<Alarm>(this as Alarm, _$identity);

  /// Serializes this Alarm to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Alarm&&(identical(other.id, id) || other.id == id)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.label, label) || other.label == label)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&const DeepCollectionEquality().equals(other.repeatDays, repeatDays)&&(identical(other.soundId, soundId) || other.soundId == soundId)&&(identical(other.snoozeDurationMinutes, snoozeDurationMinutes) || other.snoozeDurationMinutes == snoozeDurationMinutes)&&(identical(other.snoozedUntil, snoozedUntil) || other.snoozedUntil == snoozedUntil));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,hour,minute,createdAt,updatedAt,label,isEnabled,const DeepCollectionEquality().hash(repeatDays),soundId,snoozeDurationMinutes,snoozedUntil);

@override
String toString() {
  return 'Alarm(id: $id, hour: $hour, minute: $minute, createdAt: $createdAt, updatedAt: $updatedAt, label: $label, isEnabled: $isEnabled, repeatDays: $repeatDays, soundId: $soundId, snoozeDurationMinutes: $snoozeDurationMinutes, snoozedUntil: $snoozedUntil)';
}


}

/// @nodoc
abstract mixin class $AlarmCopyWith<$Res>  {
  factory $AlarmCopyWith(Alarm value, $Res Function(Alarm) _then) = _$AlarmCopyWithImpl;
@useResult
$Res call({
 String id, int hour, int minute, DateTime createdAt, DateTime updatedAt, String label, bool isEnabled, List<int> repeatDays, String soundId, int snoozeDurationMinutes, DateTime? snoozedUntil
});




}
/// @nodoc
class _$AlarmCopyWithImpl<$Res>
    implements $AlarmCopyWith<$Res> {
  _$AlarmCopyWithImpl(this._self, this._then);

  final Alarm _self;
  final $Res Function(Alarm) _then;

/// Create a copy of Alarm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? hour = null,Object? minute = null,Object? createdAt = null,Object? updatedAt = null,Object? label = null,Object? isEnabled = null,Object? repeatDays = null,Object? soundId = null,Object? snoozeDurationMinutes = null,Object? snoozedUntil = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,repeatDays: null == repeatDays ? _self.repeatDays : repeatDays // ignore: cast_nullable_to_non_nullable
as List<int>,soundId: null == soundId ? _self.soundId : soundId // ignore: cast_nullable_to_non_nullable
as String,snoozeDurationMinutes: null == snoozeDurationMinutes ? _self.snoozeDurationMinutes : snoozeDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,snoozedUntil: freezed == snoozedUntil ? _self.snoozedUntil : snoozedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Alarm].
extension AlarmPatterns on Alarm {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Alarm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Alarm() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Alarm value)  $default,){
final _that = this;
switch (_that) {
case _Alarm():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Alarm value)?  $default,){
final _that = this;
switch (_that) {
case _Alarm() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int hour,  int minute,  DateTime createdAt,  DateTime updatedAt,  String label,  bool isEnabled,  List<int> repeatDays,  String soundId,  int snoozeDurationMinutes,  DateTime? snoozedUntil)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Alarm() when $default != null:
return $default(_that.id,_that.hour,_that.minute,_that.createdAt,_that.updatedAt,_that.label,_that.isEnabled,_that.repeatDays,_that.soundId,_that.snoozeDurationMinutes,_that.snoozedUntil);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int hour,  int minute,  DateTime createdAt,  DateTime updatedAt,  String label,  bool isEnabled,  List<int> repeatDays,  String soundId,  int snoozeDurationMinutes,  DateTime? snoozedUntil)  $default,) {final _that = this;
switch (_that) {
case _Alarm():
return $default(_that.id,_that.hour,_that.minute,_that.createdAt,_that.updatedAt,_that.label,_that.isEnabled,_that.repeatDays,_that.soundId,_that.snoozeDurationMinutes,_that.snoozedUntil);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int hour,  int minute,  DateTime createdAt,  DateTime updatedAt,  String label,  bool isEnabled,  List<int> repeatDays,  String soundId,  int snoozeDurationMinutes,  DateTime? snoozedUntil)?  $default,) {final _that = this;
switch (_that) {
case _Alarm() when $default != null:
return $default(_that.id,_that.hour,_that.minute,_that.createdAt,_that.updatedAt,_that.label,_that.isEnabled,_that.repeatDays,_that.soundId,_that.snoozeDurationMinutes,_that.snoozedUntil);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Alarm extends Alarm {
  const _Alarm({required this.id, required this.hour, required this.minute, required this.createdAt, required this.updatedAt, this.label = '', this.isEnabled = true, final  List<int> repeatDays = const [], this.soundId = 'marimba', this.snoozeDurationMinutes = 5, this.snoozedUntil}): _repeatDays = repeatDays,super._();
  factory _Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);

@override final  String id;
@override final  int hour;
@override final  int minute;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  String label;
@override@JsonKey() final  bool isEnabled;
 final  List<int> _repeatDays;
@override@JsonKey() List<int> get repeatDays {
  if (_repeatDays is EqualUnmodifiableListView) return _repeatDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_repeatDays);
}

@override@JsonKey() final  String soundId;
@override@JsonKey() final  int snoozeDurationMinutes;
@override final  DateTime? snoozedUntil;

/// Create a copy of Alarm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlarmCopyWith<_Alarm> get copyWith => __$AlarmCopyWithImpl<_Alarm>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlarmToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Alarm&&(identical(other.id, id) || other.id == id)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.label, label) || other.label == label)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&const DeepCollectionEquality().equals(other._repeatDays, _repeatDays)&&(identical(other.soundId, soundId) || other.soundId == soundId)&&(identical(other.snoozeDurationMinutes, snoozeDurationMinutes) || other.snoozeDurationMinutes == snoozeDurationMinutes)&&(identical(other.snoozedUntil, snoozedUntil) || other.snoozedUntil == snoozedUntil));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,hour,minute,createdAt,updatedAt,label,isEnabled,const DeepCollectionEquality().hash(_repeatDays),soundId,snoozeDurationMinutes,snoozedUntil);

@override
String toString() {
  return 'Alarm(id: $id, hour: $hour, minute: $minute, createdAt: $createdAt, updatedAt: $updatedAt, label: $label, isEnabled: $isEnabled, repeatDays: $repeatDays, soundId: $soundId, snoozeDurationMinutes: $snoozeDurationMinutes, snoozedUntil: $snoozedUntil)';
}


}

/// @nodoc
abstract mixin class _$AlarmCopyWith<$Res> implements $AlarmCopyWith<$Res> {
  factory _$AlarmCopyWith(_Alarm value, $Res Function(_Alarm) _then) = __$AlarmCopyWithImpl;
@override @useResult
$Res call({
 String id, int hour, int minute, DateTime createdAt, DateTime updatedAt, String label, bool isEnabled, List<int> repeatDays, String soundId, int snoozeDurationMinutes, DateTime? snoozedUntil
});




}
/// @nodoc
class __$AlarmCopyWithImpl<$Res>
    implements _$AlarmCopyWith<$Res> {
  __$AlarmCopyWithImpl(this._self, this._then);

  final _Alarm _self;
  final $Res Function(_Alarm) _then;

/// Create a copy of Alarm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? hour = null,Object? minute = null,Object? createdAt = null,Object? updatedAt = null,Object? label = null,Object? isEnabled = null,Object? repeatDays = null,Object? soundId = null,Object? snoozeDurationMinutes = null,Object? snoozedUntil = freezed,}) {
  return _then(_Alarm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,repeatDays: null == repeatDays ? _self._repeatDays : repeatDays // ignore: cast_nullable_to_non_nullable
as List<int>,soundId: null == soundId ? _self.soundId : soundId // ignore: cast_nullable_to_non_nullable
as String,snoozeDurationMinutes: null == snoozeDurationMinutes ? _self.snoozeDurationMinutes : snoozeDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,snoozedUntil: freezed == snoozedUntil ? _self.snoozedUntil : snoozedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
