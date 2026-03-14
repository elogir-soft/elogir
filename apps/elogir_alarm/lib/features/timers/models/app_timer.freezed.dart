// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_timer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppTimer {

 String get id; String get label; int get durationMs; int get remainingMs; TimerStatus get status; DateTime? get startedAt; DateTime? get pausedAt; DateTime get createdAt;
/// Create a copy of AppTimer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppTimerCopyWith<AppTimer> get copyWith => _$AppTimerCopyWithImpl<AppTimer>(this as AppTimer, _$identity);

  /// Serializes this AppTimer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppTimer&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.remainingMs, remainingMs) || other.remainingMs == remainingMs)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,durationMs,remainingMs,status,startedAt,pausedAt,createdAt);

@override
String toString() {
  return 'AppTimer(id: $id, label: $label, durationMs: $durationMs, remainingMs: $remainingMs, status: $status, startedAt: $startedAt, pausedAt: $pausedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AppTimerCopyWith<$Res>  {
  factory $AppTimerCopyWith(AppTimer value, $Res Function(AppTimer) _then) = _$AppTimerCopyWithImpl;
@useResult
$Res call({
 String id, String label, int durationMs, int remainingMs, TimerStatus status, DateTime? startedAt, DateTime? pausedAt, DateTime createdAt
});




}
/// @nodoc
class _$AppTimerCopyWithImpl<$Res>
    implements $AppTimerCopyWith<$Res> {
  _$AppTimerCopyWithImpl(this._self, this._then);

  final AppTimer _self;
  final $Res Function(AppTimer) _then;

/// Create a copy of AppTimer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? durationMs = null,Object? remainingMs = null,Object? status = null,Object? startedAt = freezed,Object? pausedAt = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,remainingMs: null == remainingMs ? _self.remainingMs : remainingMs // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TimerStatus,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AppTimer].
extension AppTimerPatterns on AppTimer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppTimer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppTimer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppTimer value)  $default,){
final _that = this;
switch (_that) {
case _AppTimer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppTimer value)?  $default,){
final _that = this;
switch (_that) {
case _AppTimer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  int durationMs,  int remainingMs,  TimerStatus status,  DateTime? startedAt,  DateTime? pausedAt,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppTimer() when $default != null:
return $default(_that.id,_that.label,_that.durationMs,_that.remainingMs,_that.status,_that.startedAt,_that.pausedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  int durationMs,  int remainingMs,  TimerStatus status,  DateTime? startedAt,  DateTime? pausedAt,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AppTimer():
return $default(_that.id,_that.label,_that.durationMs,_that.remainingMs,_that.status,_that.startedAt,_that.pausedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  int durationMs,  int remainingMs,  TimerStatus status,  DateTime? startedAt,  DateTime? pausedAt,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AppTimer() when $default != null:
return $default(_that.id,_that.label,_that.durationMs,_that.remainingMs,_that.status,_that.startedAt,_that.pausedAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppTimer extends AppTimer {
  const _AppTimer({required this.id, this.label = '', required this.durationMs, required this.remainingMs, required this.status, this.startedAt, this.pausedAt, required this.createdAt}): super._();
  factory _AppTimer.fromJson(Map<String, dynamic> json) => _$AppTimerFromJson(json);

@override final  String id;
@override@JsonKey() final  String label;
@override final  int durationMs;
@override final  int remainingMs;
@override final  TimerStatus status;
@override final  DateTime? startedAt;
@override final  DateTime? pausedAt;
@override final  DateTime createdAt;

/// Create a copy of AppTimer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppTimerCopyWith<_AppTimer> get copyWith => __$AppTimerCopyWithImpl<_AppTimer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppTimerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppTimer&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.remainingMs, remainingMs) || other.remainingMs == remainingMs)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,durationMs,remainingMs,status,startedAt,pausedAt,createdAt);

@override
String toString() {
  return 'AppTimer(id: $id, label: $label, durationMs: $durationMs, remainingMs: $remainingMs, status: $status, startedAt: $startedAt, pausedAt: $pausedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AppTimerCopyWith<$Res> implements $AppTimerCopyWith<$Res> {
  factory _$AppTimerCopyWith(_AppTimer value, $Res Function(_AppTimer) _then) = __$AppTimerCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, int durationMs, int remainingMs, TimerStatus status, DateTime? startedAt, DateTime? pausedAt, DateTime createdAt
});




}
/// @nodoc
class __$AppTimerCopyWithImpl<$Res>
    implements _$AppTimerCopyWith<$Res> {
  __$AppTimerCopyWithImpl(this._self, this._then);

  final _AppTimer _self;
  final $Res Function(_AppTimer) _then;

/// Create a copy of AppTimer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? durationMs = null,Object? remainingMs = null,Object? status = null,Object? startedAt = freezed,Object? pausedAt = freezed,Object? createdAt = null,}) {
  return _then(_AppTimer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,remainingMs: null == remainingMs ? _self.remainingMs : remainingMs // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TimerStatus,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
