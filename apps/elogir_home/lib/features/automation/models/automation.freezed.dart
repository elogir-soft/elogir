// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'automation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Automation {

 String get id; String get name; AutomationTrigger get trigger; List<AutomationAction> get actions; DateTime get createdAt; DateTime get updatedAt; bool get isEnabled;
/// Create a copy of Automation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutomationCopyWith<Automation> get copyWith => _$AutomationCopyWithImpl<Automation>(this as Automation, _$identity);

  /// Serializes this Automation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Automation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&const DeepCollectionEquality().equals(other.actions, actions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,trigger,const DeepCollectionEquality().hash(actions),createdAt,updatedAt,isEnabled);

@override
String toString() {
  return 'Automation(id: $id, name: $name, trigger: $trigger, actions: $actions, createdAt: $createdAt, updatedAt: $updatedAt, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class $AutomationCopyWith<$Res>  {
  factory $AutomationCopyWith(Automation value, $Res Function(Automation) _then) = _$AutomationCopyWithImpl;
@useResult
$Res call({
 String id, String name, AutomationTrigger trigger, List<AutomationAction> actions, DateTime createdAt, DateTime updatedAt, bool isEnabled
});


$AutomationTriggerCopyWith<$Res> get trigger;

}
/// @nodoc
class _$AutomationCopyWithImpl<$Res>
    implements $AutomationCopyWith<$Res> {
  _$AutomationCopyWithImpl(this._self, this._then);

  final Automation _self;
  final $Res Function(Automation) _then;

/// Create a copy of Automation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? trigger = null,Object? actions = null,Object? createdAt = null,Object? updatedAt = null,Object? isEnabled = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as AutomationTrigger,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<AutomationAction>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Automation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AutomationTriggerCopyWith<$Res> get trigger {
  
  return $AutomationTriggerCopyWith<$Res>(_self.trigger, (value) {
    return _then(_self.copyWith(trigger: value));
  });
}
}


/// Adds pattern-matching-related methods to [Automation].
extension AutomationPatterns on Automation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Automation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Automation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Automation value)  $default,){
final _that = this;
switch (_that) {
case _Automation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Automation value)?  $default,){
final _that = this;
switch (_that) {
case _Automation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  AutomationTrigger trigger,  List<AutomationAction> actions,  DateTime createdAt,  DateTime updatedAt,  bool isEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Automation() when $default != null:
return $default(_that.id,_that.name,_that.trigger,_that.actions,_that.createdAt,_that.updatedAt,_that.isEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  AutomationTrigger trigger,  List<AutomationAction> actions,  DateTime createdAt,  DateTime updatedAt,  bool isEnabled)  $default,) {final _that = this;
switch (_that) {
case _Automation():
return $default(_that.id,_that.name,_that.trigger,_that.actions,_that.createdAt,_that.updatedAt,_that.isEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  AutomationTrigger trigger,  List<AutomationAction> actions,  DateTime createdAt,  DateTime updatedAt,  bool isEnabled)?  $default,) {final _that = this;
switch (_that) {
case _Automation() when $default != null:
return $default(_that.id,_that.name,_that.trigger,_that.actions,_that.createdAt,_that.updatedAt,_that.isEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Automation extends Automation {
  const _Automation({required this.id, this.name = '', required this.trigger, required final  List<AutomationAction> actions, required this.createdAt, required this.updatedAt, this.isEnabled = true}): _actions = actions,super._();
  factory _Automation.fromJson(Map<String, dynamic> json) => _$AutomationFromJson(json);

@override final  String id;
@override@JsonKey() final  String name;
@override final  AutomationTrigger trigger;
 final  List<AutomationAction> _actions;
@override List<AutomationAction> get actions {
  if (_actions is EqualUnmodifiableListView) return _actions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actions);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  bool isEnabled;

/// Create a copy of Automation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutomationCopyWith<_Automation> get copyWith => __$AutomationCopyWithImpl<_Automation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutomationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Automation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&const DeepCollectionEquality().equals(other._actions, _actions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,trigger,const DeepCollectionEquality().hash(_actions),createdAt,updatedAt,isEnabled);

@override
String toString() {
  return 'Automation(id: $id, name: $name, trigger: $trigger, actions: $actions, createdAt: $createdAt, updatedAt: $updatedAt, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class _$AutomationCopyWith<$Res> implements $AutomationCopyWith<$Res> {
  factory _$AutomationCopyWith(_Automation value, $Res Function(_Automation) _then) = __$AutomationCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, AutomationTrigger trigger, List<AutomationAction> actions, DateTime createdAt, DateTime updatedAt, bool isEnabled
});


@override $AutomationTriggerCopyWith<$Res> get trigger;

}
/// @nodoc
class __$AutomationCopyWithImpl<$Res>
    implements _$AutomationCopyWith<$Res> {
  __$AutomationCopyWithImpl(this._self, this._then);

  final _Automation _self;
  final $Res Function(_Automation) _then;

/// Create a copy of Automation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? trigger = null,Object? actions = null,Object? createdAt = null,Object? updatedAt = null,Object? isEnabled = null,}) {
  return _then(_Automation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as AutomationTrigger,actions: null == actions ? _self._actions : actions // ignore: cast_nullable_to_non_nullable
as List<AutomationAction>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Automation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AutomationTriggerCopyWith<$Res> get trigger {
  
  return $AutomationTriggerCopyWith<$Res>(_self.trigger, (value) {
    return _then(_self.copyWith(trigger: value));
  });
}
}

// dart format on
