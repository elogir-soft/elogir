// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lap.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Lap {

/// Lap number (1-indexed).
 int get number;/// Absolute elapsed time at the moment this lap was recorded.
@_DurationConverter() Duration get elapsed;/// Time since the previous lap (or from start for lap 1).
@_DurationConverter() Duration get delta;
/// Create a copy of Lap
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LapCopyWith<Lap> get copyWith => _$LapCopyWithImpl<Lap>(this as Lap, _$identity);

  /// Serializes this Lap to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lap&&(identical(other.number, number) || other.number == number)&&(identical(other.elapsed, elapsed) || other.elapsed == elapsed)&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,elapsed,delta);

@override
String toString() {
  return 'Lap(number: $number, elapsed: $elapsed, delta: $delta)';
}


}

/// @nodoc
abstract mixin class $LapCopyWith<$Res>  {
  factory $LapCopyWith(Lap value, $Res Function(Lap) _then) = _$LapCopyWithImpl;
@useResult
$Res call({
 int number,@_DurationConverter() Duration elapsed,@_DurationConverter() Duration delta
});




}
/// @nodoc
class _$LapCopyWithImpl<$Res>
    implements $LapCopyWith<$Res> {
  _$LapCopyWithImpl(this._self, this._then);

  final Lap _self;
  final $Res Function(Lap) _then;

/// Create a copy of Lap
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? elapsed = null,Object? delta = null,}) {
  return _then(_self.copyWith(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,elapsed: null == elapsed ? _self.elapsed : elapsed // ignore: cast_nullable_to_non_nullable
as Duration,delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [Lap].
extension LapPatterns on Lap {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Lap value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Lap() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Lap value)  $default,){
final _that = this;
switch (_that) {
case _Lap():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Lap value)?  $default,){
final _that = this;
switch (_that) {
case _Lap() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number, @_DurationConverter()  Duration elapsed, @_DurationConverter()  Duration delta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Lap() when $default != null:
return $default(_that.number,_that.elapsed,_that.delta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number, @_DurationConverter()  Duration elapsed, @_DurationConverter()  Duration delta)  $default,) {final _that = this;
switch (_that) {
case _Lap():
return $default(_that.number,_that.elapsed,_that.delta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number, @_DurationConverter()  Duration elapsed, @_DurationConverter()  Duration delta)?  $default,) {final _that = this;
switch (_that) {
case _Lap() when $default != null:
return $default(_that.number,_that.elapsed,_that.delta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Lap implements Lap {
  const _Lap({required this.number, @_DurationConverter() required this.elapsed, @_DurationConverter() required this.delta});
  factory _Lap.fromJson(Map<String, dynamic> json) => _$LapFromJson(json);

/// Lap number (1-indexed).
@override final  int number;
/// Absolute elapsed time at the moment this lap was recorded.
@override@_DurationConverter() final  Duration elapsed;
/// Time since the previous lap (or from start for lap 1).
@override@_DurationConverter() final  Duration delta;

/// Create a copy of Lap
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LapCopyWith<_Lap> get copyWith => __$LapCopyWithImpl<_Lap>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LapToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Lap&&(identical(other.number, number) || other.number == number)&&(identical(other.elapsed, elapsed) || other.elapsed == elapsed)&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,elapsed,delta);

@override
String toString() {
  return 'Lap(number: $number, elapsed: $elapsed, delta: $delta)';
}


}

/// @nodoc
abstract mixin class _$LapCopyWith<$Res> implements $LapCopyWith<$Res> {
  factory _$LapCopyWith(_Lap value, $Res Function(_Lap) _then) = __$LapCopyWithImpl;
@override @useResult
$Res call({
 int number,@_DurationConverter() Duration elapsed,@_DurationConverter() Duration delta
});




}
/// @nodoc
class __$LapCopyWithImpl<$Res>
    implements _$LapCopyWith<$Res> {
  __$LapCopyWithImpl(this._self, this._then);

  final _Lap _self;
  final $Res Function(_Lap) _then;

/// Create a copy of Lap
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? elapsed = null,Object? delta = null,}) {
  return _then(_Lap(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,elapsed: null == elapsed ? _self.elapsed : elapsed // ignore: cast_nullable_to_non_nullable
as Duration,delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
