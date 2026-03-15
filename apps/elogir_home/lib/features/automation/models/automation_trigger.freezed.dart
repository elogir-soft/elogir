// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'automation_trigger.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
AutomationTrigger _$AutomationTriggerFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'recurring':
          return RecurringTrigger.fromJson(
            json
          );
                case 'oneTime':
          return OneTimeTrigger.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'AutomationTrigger',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$AutomationTrigger {



  /// Serializes this AutomationTrigger to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutomationTrigger);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AutomationTrigger()';
}


}

/// @nodoc
class $AutomationTriggerCopyWith<$Res>  {
$AutomationTriggerCopyWith(AutomationTrigger _, $Res Function(AutomationTrigger) __);
}


/// Adds pattern-matching-related methods to [AutomationTrigger].
extension AutomationTriggerPatterns on AutomationTrigger {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecurringTrigger value)?  recurring,TResult Function( OneTimeTrigger value)?  oneTime,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecurringTrigger() when recurring != null:
return recurring(_that);case OneTimeTrigger() when oneTime != null:
return oneTime(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecurringTrigger value)  recurring,required TResult Function( OneTimeTrigger value)  oneTime,}){
final _that = this;
switch (_that) {
case RecurringTrigger():
return recurring(_that);case OneTimeTrigger():
return oneTime(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecurringTrigger value)?  recurring,TResult? Function( OneTimeTrigger value)?  oneTime,}){
final _that = this;
switch (_that) {
case RecurringTrigger() when recurring != null:
return recurring(_that);case OneTimeTrigger() when oneTime != null:
return oneTime(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int hour,  int minute,  List<int> repeatDays)?  recurring,TResult Function( DateTime scheduledAt)?  oneTime,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecurringTrigger() when recurring != null:
return recurring(_that.hour,_that.minute,_that.repeatDays);case OneTimeTrigger() when oneTime != null:
return oneTime(_that.scheduledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int hour,  int minute,  List<int> repeatDays)  recurring,required TResult Function( DateTime scheduledAt)  oneTime,}) {final _that = this;
switch (_that) {
case RecurringTrigger():
return recurring(_that.hour,_that.minute,_that.repeatDays);case OneTimeTrigger():
return oneTime(_that.scheduledAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int hour,  int minute,  List<int> repeatDays)?  recurring,TResult? Function( DateTime scheduledAt)?  oneTime,}) {final _that = this;
switch (_that) {
case RecurringTrigger() when recurring != null:
return recurring(_that.hour,_that.minute,_that.repeatDays);case OneTimeTrigger() when oneTime != null:
return oneTime(_that.scheduledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class RecurringTrigger implements AutomationTrigger {
  const RecurringTrigger({required this.hour, required this.minute, final  List<int> repeatDays = const [], final  String? $type}): _repeatDays = repeatDays,$type = $type ?? 'recurring';
  factory RecurringTrigger.fromJson(Map<String, dynamic> json) => _$RecurringTriggerFromJson(json);

 final  int hour;
 final  int minute;
/// Days of the week (1 = Monday … 7 = Sunday). Empty means every day.
 final  List<int> _repeatDays;
/// Days of the week (1 = Monday … 7 = Sunday). Empty means every day.
@JsonKey() List<int> get repeatDays {
  if (_repeatDays is EqualUnmodifiableListView) return _repeatDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_repeatDays);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of AutomationTrigger
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringTriggerCopyWith<RecurringTrigger> get copyWith => _$RecurringTriggerCopyWithImpl<RecurringTrigger>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecurringTriggerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringTrigger&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&const DeepCollectionEquality().equals(other._repeatDays, _repeatDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hour,minute,const DeepCollectionEquality().hash(_repeatDays));

@override
String toString() {
  return 'AutomationTrigger.recurring(hour: $hour, minute: $minute, repeatDays: $repeatDays)';
}


}

/// @nodoc
abstract mixin class $RecurringTriggerCopyWith<$Res> implements $AutomationTriggerCopyWith<$Res> {
  factory $RecurringTriggerCopyWith(RecurringTrigger value, $Res Function(RecurringTrigger) _then) = _$RecurringTriggerCopyWithImpl;
@useResult
$Res call({
 int hour, int minute, List<int> repeatDays
});




}
/// @nodoc
class _$RecurringTriggerCopyWithImpl<$Res>
    implements $RecurringTriggerCopyWith<$Res> {
  _$RecurringTriggerCopyWithImpl(this._self, this._then);

  final RecurringTrigger _self;
  final $Res Function(RecurringTrigger) _then;

/// Create a copy of AutomationTrigger
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hour = null,Object? minute = null,Object? repeatDays = null,}) {
  return _then(RecurringTrigger(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,repeatDays: null == repeatDays ? _self._repeatDays : repeatDays // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OneTimeTrigger implements AutomationTrigger {
  const OneTimeTrigger({required this.scheduledAt, final  String? $type}): $type = $type ?? 'oneTime';
  factory OneTimeTrigger.fromJson(Map<String, dynamic> json) => _$OneTimeTriggerFromJson(json);

 final  DateTime scheduledAt;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AutomationTrigger
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OneTimeTriggerCopyWith<OneTimeTrigger> get copyWith => _$OneTimeTriggerCopyWithImpl<OneTimeTrigger>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OneTimeTriggerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OneTimeTrigger&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scheduledAt);

@override
String toString() {
  return 'AutomationTrigger.oneTime(scheduledAt: $scheduledAt)';
}


}

/// @nodoc
abstract mixin class $OneTimeTriggerCopyWith<$Res> implements $AutomationTriggerCopyWith<$Res> {
  factory $OneTimeTriggerCopyWith(OneTimeTrigger value, $Res Function(OneTimeTrigger) _then) = _$OneTimeTriggerCopyWithImpl;
@useResult
$Res call({
 DateTime scheduledAt
});




}
/// @nodoc
class _$OneTimeTriggerCopyWithImpl<$Res>
    implements $OneTimeTriggerCopyWith<$Res> {
  _$OneTimeTriggerCopyWithImpl(this._self, this._then);

  final OneTimeTrigger _self;
  final $Res Function(OneTimeTrigger) _then;

/// Create a copy of AutomationTrigger
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? scheduledAt = null,}) {
  return _then(OneTimeTrigger(
scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
