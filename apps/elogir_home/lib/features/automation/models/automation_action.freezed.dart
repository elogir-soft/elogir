// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'automation_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
AutomationAction _$AutomationActionFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'turnOn':
          return TurnOnAction.fromJson(
            json
          );
                case 'turnOff':
          return TurnOffAction.fromJson(
            json
          );
                case 'setBrightness':
          return SetBrightnessAction.fromJson(
            json
          );
                case 'setColor':
          return SetColorAction.fromJson(
            json
          );
                case 'setColorTemperature':
          return SetColorTemperatureAction.fromJson(
            json
          );
                case 'openCover':
          return OpenCoverAction.fromJson(
            json
          );
                case 'closeCover':
          return CloseCoverAction.fromJson(
            json
          );
                case 'switchOn':
          return SwitchOnAction.fromJson(
            json
          );
                case 'switchOff':
          return SwitchOffAction.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'AutomationAction',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$AutomationAction {

 String get deviceId;
/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutomationActionCopyWith<AutomationAction> get copyWith => _$AutomationActionCopyWithImpl<AutomationAction>(this as AutomationAction, _$identity);

  /// Serializes this AutomationAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutomationAction&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId);

@override
String toString() {
  return 'AutomationAction(deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $AutomationActionCopyWith<$Res>  {
  factory $AutomationActionCopyWith(AutomationAction value, $Res Function(AutomationAction) _then) = _$AutomationActionCopyWithImpl;
@useResult
$Res call({
 String deviceId
});




}
/// @nodoc
class _$AutomationActionCopyWithImpl<$Res>
    implements $AutomationActionCopyWith<$Res> {
  _$AutomationActionCopyWithImpl(this._self, this._then);

  final AutomationAction _self;
  final $Res Function(AutomationAction) _then;

/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AutomationAction].
extension AutomationActionPatterns on AutomationAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TurnOnAction value)?  turnOn,TResult Function( TurnOffAction value)?  turnOff,TResult Function( SetBrightnessAction value)?  setBrightness,TResult Function( SetColorAction value)?  setColor,TResult Function( SetColorTemperatureAction value)?  setColorTemperature,TResult Function( OpenCoverAction value)?  openCover,TResult Function( CloseCoverAction value)?  closeCover,TResult Function( SwitchOnAction value)?  switchOn,TResult Function( SwitchOffAction value)?  switchOff,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TurnOnAction() when turnOn != null:
return turnOn(_that);case TurnOffAction() when turnOff != null:
return turnOff(_that);case SetBrightnessAction() when setBrightness != null:
return setBrightness(_that);case SetColorAction() when setColor != null:
return setColor(_that);case SetColorTemperatureAction() when setColorTemperature != null:
return setColorTemperature(_that);case OpenCoverAction() when openCover != null:
return openCover(_that);case CloseCoverAction() when closeCover != null:
return closeCover(_that);case SwitchOnAction() when switchOn != null:
return switchOn(_that);case SwitchOffAction() when switchOff != null:
return switchOff(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TurnOnAction value)  turnOn,required TResult Function( TurnOffAction value)  turnOff,required TResult Function( SetBrightnessAction value)  setBrightness,required TResult Function( SetColorAction value)  setColor,required TResult Function( SetColorTemperatureAction value)  setColorTemperature,required TResult Function( OpenCoverAction value)  openCover,required TResult Function( CloseCoverAction value)  closeCover,required TResult Function( SwitchOnAction value)  switchOn,required TResult Function( SwitchOffAction value)  switchOff,}){
final _that = this;
switch (_that) {
case TurnOnAction():
return turnOn(_that);case TurnOffAction():
return turnOff(_that);case SetBrightnessAction():
return setBrightness(_that);case SetColorAction():
return setColor(_that);case SetColorTemperatureAction():
return setColorTemperature(_that);case OpenCoverAction():
return openCover(_that);case CloseCoverAction():
return closeCover(_that);case SwitchOnAction():
return switchOn(_that);case SwitchOffAction():
return switchOff(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TurnOnAction value)?  turnOn,TResult? Function( TurnOffAction value)?  turnOff,TResult? Function( SetBrightnessAction value)?  setBrightness,TResult? Function( SetColorAction value)?  setColor,TResult? Function( SetColorTemperatureAction value)?  setColorTemperature,TResult? Function( OpenCoverAction value)?  openCover,TResult? Function( CloseCoverAction value)?  closeCover,TResult? Function( SwitchOnAction value)?  switchOn,TResult? Function( SwitchOffAction value)?  switchOff,}){
final _that = this;
switch (_that) {
case TurnOnAction() when turnOn != null:
return turnOn(_that);case TurnOffAction() when turnOff != null:
return turnOff(_that);case SetBrightnessAction() when setBrightness != null:
return setBrightness(_that);case SetColorAction() when setColor != null:
return setColor(_that);case SetColorTemperatureAction() when setColorTemperature != null:
return setColorTemperature(_that);case OpenCoverAction() when openCover != null:
return openCover(_that);case CloseCoverAction() when closeCover != null:
return closeCover(_that);case SwitchOnAction() when switchOn != null:
return switchOn(_that);case SwitchOffAction() when switchOff != null:
return switchOff(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String deviceId)?  turnOn,TResult Function( String deviceId)?  turnOff,TResult Function( String deviceId,  int percentage)?  setBrightness,TResult Function( String deviceId,  int r,  int g,  int b)?  setColor,TResult Function( String deviceId,  int percentage)?  setColorTemperature,TResult Function( String deviceId)?  openCover,TResult Function( String deviceId)?  closeCover,TResult Function( String deviceId)?  switchOn,TResult Function( String deviceId)?  switchOff,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TurnOnAction() when turnOn != null:
return turnOn(_that.deviceId);case TurnOffAction() when turnOff != null:
return turnOff(_that.deviceId);case SetBrightnessAction() when setBrightness != null:
return setBrightness(_that.deviceId,_that.percentage);case SetColorAction() when setColor != null:
return setColor(_that.deviceId,_that.r,_that.g,_that.b);case SetColorTemperatureAction() when setColorTemperature != null:
return setColorTemperature(_that.deviceId,_that.percentage);case OpenCoverAction() when openCover != null:
return openCover(_that.deviceId);case CloseCoverAction() when closeCover != null:
return closeCover(_that.deviceId);case SwitchOnAction() when switchOn != null:
return switchOn(_that.deviceId);case SwitchOffAction() when switchOff != null:
return switchOff(_that.deviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String deviceId)  turnOn,required TResult Function( String deviceId)  turnOff,required TResult Function( String deviceId,  int percentage)  setBrightness,required TResult Function( String deviceId,  int r,  int g,  int b)  setColor,required TResult Function( String deviceId,  int percentage)  setColorTemperature,required TResult Function( String deviceId)  openCover,required TResult Function( String deviceId)  closeCover,required TResult Function( String deviceId)  switchOn,required TResult Function( String deviceId)  switchOff,}) {final _that = this;
switch (_that) {
case TurnOnAction():
return turnOn(_that.deviceId);case TurnOffAction():
return turnOff(_that.deviceId);case SetBrightnessAction():
return setBrightness(_that.deviceId,_that.percentage);case SetColorAction():
return setColor(_that.deviceId,_that.r,_that.g,_that.b);case SetColorTemperatureAction():
return setColorTemperature(_that.deviceId,_that.percentage);case OpenCoverAction():
return openCover(_that.deviceId);case CloseCoverAction():
return closeCover(_that.deviceId);case SwitchOnAction():
return switchOn(_that.deviceId);case SwitchOffAction():
return switchOff(_that.deviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String deviceId)?  turnOn,TResult? Function( String deviceId)?  turnOff,TResult? Function( String deviceId,  int percentage)?  setBrightness,TResult? Function( String deviceId,  int r,  int g,  int b)?  setColor,TResult? Function( String deviceId,  int percentage)?  setColorTemperature,TResult? Function( String deviceId)?  openCover,TResult? Function( String deviceId)?  closeCover,TResult? Function( String deviceId)?  switchOn,TResult? Function( String deviceId)?  switchOff,}) {final _that = this;
switch (_that) {
case TurnOnAction() when turnOn != null:
return turnOn(_that.deviceId);case TurnOffAction() when turnOff != null:
return turnOff(_that.deviceId);case SetBrightnessAction() when setBrightness != null:
return setBrightness(_that.deviceId,_that.percentage);case SetColorAction() when setColor != null:
return setColor(_that.deviceId,_that.r,_that.g,_that.b);case SetColorTemperatureAction() when setColorTemperature != null:
return setColorTemperature(_that.deviceId,_that.percentage);case OpenCoverAction() when openCover != null:
return openCover(_that.deviceId);case CloseCoverAction() when closeCover != null:
return closeCover(_that.deviceId);case SwitchOnAction() when switchOn != null:
return switchOn(_that.deviceId);case SwitchOffAction() when switchOff != null:
return switchOff(_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class TurnOnAction implements AutomationAction {
  const TurnOnAction({required this.deviceId, final  String? $type}): $type = $type ?? 'turnOn';
  factory TurnOnAction.fromJson(Map<String, dynamic> json) => _$TurnOnActionFromJson(json);

@override final  String deviceId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TurnOnActionCopyWith<TurnOnAction> get copyWith => _$TurnOnActionCopyWithImpl<TurnOnAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TurnOnActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TurnOnAction&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId);

@override
String toString() {
  return 'AutomationAction.turnOn(deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $TurnOnActionCopyWith<$Res> implements $AutomationActionCopyWith<$Res> {
  factory $TurnOnActionCopyWith(TurnOnAction value, $Res Function(TurnOnAction) _then) = _$TurnOnActionCopyWithImpl;
@override @useResult
$Res call({
 String deviceId
});




}
/// @nodoc
class _$TurnOnActionCopyWithImpl<$Res>
    implements $TurnOnActionCopyWith<$Res> {
  _$TurnOnActionCopyWithImpl(this._self, this._then);

  final TurnOnAction _self;
  final $Res Function(TurnOnAction) _then;

/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,}) {
  return _then(TurnOnAction(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TurnOffAction implements AutomationAction {
  const TurnOffAction({required this.deviceId, final  String? $type}): $type = $type ?? 'turnOff';
  factory TurnOffAction.fromJson(Map<String, dynamic> json) => _$TurnOffActionFromJson(json);

@override final  String deviceId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TurnOffActionCopyWith<TurnOffAction> get copyWith => _$TurnOffActionCopyWithImpl<TurnOffAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TurnOffActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TurnOffAction&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId);

@override
String toString() {
  return 'AutomationAction.turnOff(deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $TurnOffActionCopyWith<$Res> implements $AutomationActionCopyWith<$Res> {
  factory $TurnOffActionCopyWith(TurnOffAction value, $Res Function(TurnOffAction) _then) = _$TurnOffActionCopyWithImpl;
@override @useResult
$Res call({
 String deviceId
});




}
/// @nodoc
class _$TurnOffActionCopyWithImpl<$Res>
    implements $TurnOffActionCopyWith<$Res> {
  _$TurnOffActionCopyWithImpl(this._self, this._then);

  final TurnOffAction _self;
  final $Res Function(TurnOffAction) _then;

/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,}) {
  return _then(TurnOffAction(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SetBrightnessAction implements AutomationAction {
  const SetBrightnessAction({required this.deviceId, required this.percentage, final  String? $type}): $type = $type ?? 'setBrightness';
  factory SetBrightnessAction.fromJson(Map<String, dynamic> json) => _$SetBrightnessActionFromJson(json);

@override final  String deviceId;
 final  int percentage;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetBrightnessActionCopyWith<SetBrightnessAction> get copyWith => _$SetBrightnessActionCopyWithImpl<SetBrightnessAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetBrightnessActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetBrightnessAction&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,percentage);

@override
String toString() {
  return 'AutomationAction.setBrightness(deviceId: $deviceId, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class $SetBrightnessActionCopyWith<$Res> implements $AutomationActionCopyWith<$Res> {
  factory $SetBrightnessActionCopyWith(SetBrightnessAction value, $Res Function(SetBrightnessAction) _then) = _$SetBrightnessActionCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, int percentage
});




}
/// @nodoc
class _$SetBrightnessActionCopyWithImpl<$Res>
    implements $SetBrightnessActionCopyWith<$Res> {
  _$SetBrightnessActionCopyWithImpl(this._self, this._then);

  final SetBrightnessAction _self;
  final $Res Function(SetBrightnessAction) _then;

/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? percentage = null,}) {
  return _then(SetBrightnessAction(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SetColorAction implements AutomationAction {
  const SetColorAction({required this.deviceId, required this.r, required this.g, required this.b, final  String? $type}): $type = $type ?? 'setColor';
  factory SetColorAction.fromJson(Map<String, dynamic> json) => _$SetColorActionFromJson(json);

@override final  String deviceId;
 final  int r;
 final  int g;
 final  int b;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetColorActionCopyWith<SetColorAction> get copyWith => _$SetColorActionCopyWithImpl<SetColorAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetColorActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetColorAction&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.r, r) || other.r == r)&&(identical(other.g, g) || other.g == g)&&(identical(other.b, b) || other.b == b));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,r,g,b);

@override
String toString() {
  return 'AutomationAction.setColor(deviceId: $deviceId, r: $r, g: $g, b: $b)';
}


}

/// @nodoc
abstract mixin class $SetColorActionCopyWith<$Res> implements $AutomationActionCopyWith<$Res> {
  factory $SetColorActionCopyWith(SetColorAction value, $Res Function(SetColorAction) _then) = _$SetColorActionCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, int r, int g, int b
});




}
/// @nodoc
class _$SetColorActionCopyWithImpl<$Res>
    implements $SetColorActionCopyWith<$Res> {
  _$SetColorActionCopyWithImpl(this._self, this._then);

  final SetColorAction _self;
  final $Res Function(SetColorAction) _then;

/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? r = null,Object? g = null,Object? b = null,}) {
  return _then(SetColorAction(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as int,g: null == g ? _self.g : g // ignore: cast_nullable_to_non_nullable
as int,b: null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SetColorTemperatureAction implements AutomationAction {
  const SetColorTemperatureAction({required this.deviceId, required this.percentage, final  String? $type}): $type = $type ?? 'setColorTemperature';
  factory SetColorTemperatureAction.fromJson(Map<String, dynamic> json) => _$SetColorTemperatureActionFromJson(json);

@override final  String deviceId;
 final  int percentage;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetColorTemperatureActionCopyWith<SetColorTemperatureAction> get copyWith => _$SetColorTemperatureActionCopyWithImpl<SetColorTemperatureAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetColorTemperatureActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetColorTemperatureAction&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,percentage);

@override
String toString() {
  return 'AutomationAction.setColorTemperature(deviceId: $deviceId, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class $SetColorTemperatureActionCopyWith<$Res> implements $AutomationActionCopyWith<$Res> {
  factory $SetColorTemperatureActionCopyWith(SetColorTemperatureAction value, $Res Function(SetColorTemperatureAction) _then) = _$SetColorTemperatureActionCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, int percentage
});




}
/// @nodoc
class _$SetColorTemperatureActionCopyWithImpl<$Res>
    implements $SetColorTemperatureActionCopyWith<$Res> {
  _$SetColorTemperatureActionCopyWithImpl(this._self, this._then);

  final SetColorTemperatureAction _self;
  final $Res Function(SetColorTemperatureAction) _then;

/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? percentage = null,}) {
  return _then(SetColorTemperatureAction(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OpenCoverAction implements AutomationAction {
  const OpenCoverAction({required this.deviceId, final  String? $type}): $type = $type ?? 'openCover';
  factory OpenCoverAction.fromJson(Map<String, dynamic> json) => _$OpenCoverActionFromJson(json);

@override final  String deviceId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenCoverActionCopyWith<OpenCoverAction> get copyWith => _$OpenCoverActionCopyWithImpl<OpenCoverAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenCoverActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenCoverAction&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId);

@override
String toString() {
  return 'AutomationAction.openCover(deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $OpenCoverActionCopyWith<$Res> implements $AutomationActionCopyWith<$Res> {
  factory $OpenCoverActionCopyWith(OpenCoverAction value, $Res Function(OpenCoverAction) _then) = _$OpenCoverActionCopyWithImpl;
@override @useResult
$Res call({
 String deviceId
});




}
/// @nodoc
class _$OpenCoverActionCopyWithImpl<$Res>
    implements $OpenCoverActionCopyWith<$Res> {
  _$OpenCoverActionCopyWithImpl(this._self, this._then);

  final OpenCoverAction _self;
  final $Res Function(OpenCoverAction) _then;

/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,}) {
  return _then(OpenCoverAction(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CloseCoverAction implements AutomationAction {
  const CloseCoverAction({required this.deviceId, final  String? $type}): $type = $type ?? 'closeCover';
  factory CloseCoverAction.fromJson(Map<String, dynamic> json) => _$CloseCoverActionFromJson(json);

@override final  String deviceId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CloseCoverActionCopyWith<CloseCoverAction> get copyWith => _$CloseCoverActionCopyWithImpl<CloseCoverAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CloseCoverActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CloseCoverAction&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId);

@override
String toString() {
  return 'AutomationAction.closeCover(deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $CloseCoverActionCopyWith<$Res> implements $AutomationActionCopyWith<$Res> {
  factory $CloseCoverActionCopyWith(CloseCoverAction value, $Res Function(CloseCoverAction) _then) = _$CloseCoverActionCopyWithImpl;
@override @useResult
$Res call({
 String deviceId
});




}
/// @nodoc
class _$CloseCoverActionCopyWithImpl<$Res>
    implements $CloseCoverActionCopyWith<$Res> {
  _$CloseCoverActionCopyWithImpl(this._self, this._then);

  final CloseCoverAction _self;
  final $Res Function(CloseCoverAction) _then;

/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,}) {
  return _then(CloseCoverAction(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SwitchOnAction implements AutomationAction {
  const SwitchOnAction({required this.deviceId, final  String? $type}): $type = $type ?? 'switchOn';
  factory SwitchOnAction.fromJson(Map<String, dynamic> json) => _$SwitchOnActionFromJson(json);

@override final  String deviceId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwitchOnActionCopyWith<SwitchOnAction> get copyWith => _$SwitchOnActionCopyWithImpl<SwitchOnAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SwitchOnActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwitchOnAction&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId);

@override
String toString() {
  return 'AutomationAction.switchOn(deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $SwitchOnActionCopyWith<$Res> implements $AutomationActionCopyWith<$Res> {
  factory $SwitchOnActionCopyWith(SwitchOnAction value, $Res Function(SwitchOnAction) _then) = _$SwitchOnActionCopyWithImpl;
@override @useResult
$Res call({
 String deviceId
});




}
/// @nodoc
class _$SwitchOnActionCopyWithImpl<$Res>
    implements $SwitchOnActionCopyWith<$Res> {
  _$SwitchOnActionCopyWithImpl(this._self, this._then);

  final SwitchOnAction _self;
  final $Res Function(SwitchOnAction) _then;

/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,}) {
  return _then(SwitchOnAction(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SwitchOffAction implements AutomationAction {
  const SwitchOffAction({required this.deviceId, final  String? $type}): $type = $type ?? 'switchOff';
  factory SwitchOffAction.fromJson(Map<String, dynamic> json) => _$SwitchOffActionFromJson(json);

@override final  String deviceId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwitchOffActionCopyWith<SwitchOffAction> get copyWith => _$SwitchOffActionCopyWithImpl<SwitchOffAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SwitchOffActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwitchOffAction&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId);

@override
String toString() {
  return 'AutomationAction.switchOff(deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $SwitchOffActionCopyWith<$Res> implements $AutomationActionCopyWith<$Res> {
  factory $SwitchOffActionCopyWith(SwitchOffAction value, $Res Function(SwitchOffAction) _then) = _$SwitchOffActionCopyWithImpl;
@override @useResult
$Res call({
 String deviceId
});




}
/// @nodoc
class _$SwitchOffActionCopyWithImpl<$Res>
    implements $SwitchOffActionCopyWith<$Res> {
  _$SwitchOffActionCopyWithImpl(this._self, this._then);

  final SwitchOffAction _self;
  final $Res Function(SwitchOffAction) _then;

/// Create a copy of AutomationAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,}) {
  return _then(SwitchOffAction(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
