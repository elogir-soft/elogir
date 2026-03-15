// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'light_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LightState {

 bool get isOn; int get brightness; int get r; int get g; int get b; int get colorTemp; LightMode get mode;
/// Create a copy of LightState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LightStateCopyWith<LightState> get copyWith => _$LightStateCopyWithImpl<LightState>(this as LightState, _$identity);

  /// Serializes this LightState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightState&&(identical(other.isOn, isOn) || other.isOn == isOn)&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.r, r) || other.r == r)&&(identical(other.g, g) || other.g == g)&&(identical(other.b, b) || other.b == b)&&(identical(other.colorTemp, colorTemp) || other.colorTemp == colorTemp)&&(identical(other.mode, mode) || other.mode == mode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isOn,brightness,r,g,b,colorTemp,mode);

@override
String toString() {
  return 'LightState(isOn: $isOn, brightness: $brightness, r: $r, g: $g, b: $b, colorTemp: $colorTemp, mode: $mode)';
}


}

/// @nodoc
abstract mixin class $LightStateCopyWith<$Res>  {
  factory $LightStateCopyWith(LightState value, $Res Function(LightState) _then) = _$LightStateCopyWithImpl;
@useResult
$Res call({
 bool isOn, int brightness, int r, int g, int b, int colorTemp, LightMode mode
});




}
/// @nodoc
class _$LightStateCopyWithImpl<$Res>
    implements $LightStateCopyWith<$Res> {
  _$LightStateCopyWithImpl(this._self, this._then);

  final LightState _self;
  final $Res Function(LightState) _then;

/// Create a copy of LightState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isOn = null,Object? brightness = null,Object? r = null,Object? g = null,Object? b = null,Object? colorTemp = null,Object? mode = null,}) {
  return _then(_self.copyWith(
isOn: null == isOn ? _self.isOn : isOn // ignore: cast_nullable_to_non_nullable
as bool,brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as int,r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as int,g: null == g ? _self.g : g // ignore: cast_nullable_to_non_nullable
as int,b: null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as int,colorTemp: null == colorTemp ? _self.colorTemp : colorTemp // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as LightMode,
  ));
}

}


/// Adds pattern-matching-related methods to [LightState].
extension LightStatePatterns on LightState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LightState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LightState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LightState value)  $default,){
final _that = this;
switch (_that) {
case _LightState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LightState value)?  $default,){
final _that = this;
switch (_that) {
case _LightState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isOn,  int brightness,  int r,  int g,  int b,  int colorTemp,  LightMode mode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LightState() when $default != null:
return $default(_that.isOn,_that.brightness,_that.r,_that.g,_that.b,_that.colorTemp,_that.mode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isOn,  int brightness,  int r,  int g,  int b,  int colorTemp,  LightMode mode)  $default,) {final _that = this;
switch (_that) {
case _LightState():
return $default(_that.isOn,_that.brightness,_that.r,_that.g,_that.b,_that.colorTemp,_that.mode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isOn,  int brightness,  int r,  int g,  int b,  int colorTemp,  LightMode mode)?  $default,) {final _that = this;
switch (_that) {
case _LightState() when $default != null:
return $default(_that.isOn,_that.brightness,_that.r,_that.g,_that.b,_that.colorTemp,_that.mode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LightState implements LightState {
  const _LightState({this.isOn = false, this.brightness = 100, this.r = 255, this.g = 255, this.b = 255, this.colorTemp = 50, this.mode = LightMode.white});
  factory _LightState.fromJson(Map<String, dynamic> json) => _$LightStateFromJson(json);

@override@JsonKey() final  bool isOn;
@override@JsonKey() final  int brightness;
@override@JsonKey() final  int r;
@override@JsonKey() final  int g;
@override@JsonKey() final  int b;
@override@JsonKey() final  int colorTemp;
@override@JsonKey() final  LightMode mode;

/// Create a copy of LightState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LightStateCopyWith<_LightState> get copyWith => __$LightStateCopyWithImpl<_LightState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LightStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LightState&&(identical(other.isOn, isOn) || other.isOn == isOn)&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.r, r) || other.r == r)&&(identical(other.g, g) || other.g == g)&&(identical(other.b, b) || other.b == b)&&(identical(other.colorTemp, colorTemp) || other.colorTemp == colorTemp)&&(identical(other.mode, mode) || other.mode == mode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isOn,brightness,r,g,b,colorTemp,mode);

@override
String toString() {
  return 'LightState(isOn: $isOn, brightness: $brightness, r: $r, g: $g, b: $b, colorTemp: $colorTemp, mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$LightStateCopyWith<$Res> implements $LightStateCopyWith<$Res> {
  factory _$LightStateCopyWith(_LightState value, $Res Function(_LightState) _then) = __$LightStateCopyWithImpl;
@override @useResult
$Res call({
 bool isOn, int brightness, int r, int g, int b, int colorTemp, LightMode mode
});




}
/// @nodoc
class __$LightStateCopyWithImpl<$Res>
    implements _$LightStateCopyWith<$Res> {
  __$LightStateCopyWithImpl(this._self, this._then);

  final _LightState _self;
  final $Res Function(_LightState) _then;

/// Create a copy of LightState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isOn = null,Object? brightness = null,Object? r = null,Object? g = null,Object? b = null,Object? colorTemp = null,Object? mode = null,}) {
  return _then(_LightState(
isOn: null == isOn ? _self.isOn : isOn // ignore: cast_nullable_to_non_nullable
as bool,brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as int,r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as int,g: null == g ? _self.g : g // ignore: cast_nullable_to_non_nullable
as int,b: null == b ? _self.b : b // ignore: cast_nullable_to_non_nullable
as int,colorTemp: null == colorTemp ? _self.colorTemp : colorTemp // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as LightMode,
  ));
}


}

// dart format on
