// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_automation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddAutomationState {

 int get currentStep;/// Whether the trigger is recurring or one-time.
 bool get isRecurring;// -- Recurring trigger fields --
 int get hour; int get minute; List<int> get repeatDays;// -- One-time trigger fields --
 DateTime? get scheduledAt;// -- Actions --
 List<AutomationAction> get actions;// -- Name --
 String get name;
/// Create a copy of AddAutomationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddAutomationStateCopyWith<AddAutomationState> get copyWith => _$AddAutomationStateCopyWithImpl<AddAutomationState>(this as AddAutomationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddAutomationState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&const DeepCollectionEquality().equals(other.repeatDays, repeatDays)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&const DeepCollectionEquality().equals(other.actions, actions)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,isRecurring,hour,minute,const DeepCollectionEquality().hash(repeatDays),scheduledAt,const DeepCollectionEquality().hash(actions),name);

@override
String toString() {
  return 'AddAutomationState(currentStep: $currentStep, isRecurring: $isRecurring, hour: $hour, minute: $minute, repeatDays: $repeatDays, scheduledAt: $scheduledAt, actions: $actions, name: $name)';
}


}

/// @nodoc
abstract mixin class $AddAutomationStateCopyWith<$Res>  {
  factory $AddAutomationStateCopyWith(AddAutomationState value, $Res Function(AddAutomationState) _then) = _$AddAutomationStateCopyWithImpl;
@useResult
$Res call({
 int currentStep, bool isRecurring, int hour, int minute, List<int> repeatDays, DateTime? scheduledAt, List<AutomationAction> actions, String name
});




}
/// @nodoc
class _$AddAutomationStateCopyWithImpl<$Res>
    implements $AddAutomationStateCopyWith<$Res> {
  _$AddAutomationStateCopyWithImpl(this._self, this._then);

  final AddAutomationState _self;
  final $Res Function(AddAutomationState) _then;

/// Create a copy of AddAutomationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStep = null,Object? isRecurring = null,Object? hour = null,Object? minute = null,Object? repeatDays = null,Object? scheduledAt = freezed,Object? actions = null,Object? name = null,}) {
  return _then(_self.copyWith(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,repeatDays: null == repeatDays ? _self.repeatDays : repeatDays // ignore: cast_nullable_to_non_nullable
as List<int>,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<AutomationAction>,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AddAutomationState].
extension AddAutomationStatePatterns on AddAutomationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddAutomationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddAutomationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddAutomationState value)  $default,){
final _that = this;
switch (_that) {
case _AddAutomationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddAutomationState value)?  $default,){
final _that = this;
switch (_that) {
case _AddAutomationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentStep,  bool isRecurring,  int hour,  int minute,  List<int> repeatDays,  DateTime? scheduledAt,  List<AutomationAction> actions,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddAutomationState() when $default != null:
return $default(_that.currentStep,_that.isRecurring,_that.hour,_that.minute,_that.repeatDays,_that.scheduledAt,_that.actions,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentStep,  bool isRecurring,  int hour,  int minute,  List<int> repeatDays,  DateTime? scheduledAt,  List<AutomationAction> actions,  String name)  $default,) {final _that = this;
switch (_that) {
case _AddAutomationState():
return $default(_that.currentStep,_that.isRecurring,_that.hour,_that.minute,_that.repeatDays,_that.scheduledAt,_that.actions,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentStep,  bool isRecurring,  int hour,  int minute,  List<int> repeatDays,  DateTime? scheduledAt,  List<AutomationAction> actions,  String name)?  $default,) {final _that = this;
switch (_that) {
case _AddAutomationState() when $default != null:
return $default(_that.currentStep,_that.isRecurring,_that.hour,_that.minute,_that.repeatDays,_that.scheduledAt,_that.actions,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _AddAutomationState implements AddAutomationState {
  const _AddAutomationState({this.currentStep = 0, this.isRecurring = true, this.hour = 8, this.minute = 0, final  List<int> repeatDays = const [], this.scheduledAt, final  List<AutomationAction> actions = const [], this.name = ''}): _repeatDays = repeatDays,_actions = actions;
  

@override@JsonKey() final  int currentStep;
/// Whether the trigger is recurring or one-time.
@override@JsonKey() final  bool isRecurring;
// -- Recurring trigger fields --
@override@JsonKey() final  int hour;
@override@JsonKey() final  int minute;
 final  List<int> _repeatDays;
@override@JsonKey() List<int> get repeatDays {
  if (_repeatDays is EqualUnmodifiableListView) return _repeatDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_repeatDays);
}

// -- One-time trigger fields --
@override final  DateTime? scheduledAt;
// -- Actions --
 final  List<AutomationAction> _actions;
// -- Actions --
@override@JsonKey() List<AutomationAction> get actions {
  if (_actions is EqualUnmodifiableListView) return _actions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actions);
}

// -- Name --
@override@JsonKey() final  String name;

/// Create a copy of AddAutomationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddAutomationStateCopyWith<_AddAutomationState> get copyWith => __$AddAutomationStateCopyWithImpl<_AddAutomationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddAutomationState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&const DeepCollectionEquality().equals(other._repeatDays, _repeatDays)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&const DeepCollectionEquality().equals(other._actions, _actions)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,isRecurring,hour,minute,const DeepCollectionEquality().hash(_repeatDays),scheduledAt,const DeepCollectionEquality().hash(_actions),name);

@override
String toString() {
  return 'AddAutomationState(currentStep: $currentStep, isRecurring: $isRecurring, hour: $hour, minute: $minute, repeatDays: $repeatDays, scheduledAt: $scheduledAt, actions: $actions, name: $name)';
}


}

/// @nodoc
abstract mixin class _$AddAutomationStateCopyWith<$Res> implements $AddAutomationStateCopyWith<$Res> {
  factory _$AddAutomationStateCopyWith(_AddAutomationState value, $Res Function(_AddAutomationState) _then) = __$AddAutomationStateCopyWithImpl;
@override @useResult
$Res call({
 int currentStep, bool isRecurring, int hour, int minute, List<int> repeatDays, DateTime? scheduledAt, List<AutomationAction> actions, String name
});




}
/// @nodoc
class __$AddAutomationStateCopyWithImpl<$Res>
    implements _$AddAutomationStateCopyWith<$Res> {
  __$AddAutomationStateCopyWithImpl(this._self, this._then);

  final _AddAutomationState _self;
  final $Res Function(_AddAutomationState) _then;

/// Create a copy of AddAutomationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStep = null,Object? isRecurring = null,Object? hour = null,Object? minute = null,Object? repeatDays = null,Object? scheduledAt = freezed,Object? actions = null,Object? name = null,}) {
  return _then(_AddAutomationState(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,repeatDays: null == repeatDays ? _self._repeatDays : repeatDays // ignore: cast_nullable_to_non_nullable
as List<int>,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actions: null == actions ? _self._actions : actions // ignore: cast_nullable_to_non_nullable
as List<AutomationAction>,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
