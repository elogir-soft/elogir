// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Calculation {

 String get id; String get expression; String get result; DateTime get createdAt;
/// Create a copy of Calculation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculationCopyWith<Calculation> get copyWith => _$CalculationCopyWithImpl<Calculation>(this as Calculation, _$identity);

  /// Serializes this Calculation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Calculation&&(identical(other.id, id) || other.id == id)&&(identical(other.expression, expression) || other.expression == expression)&&(identical(other.result, result) || other.result == result)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,expression,result,createdAt);

@override
String toString() {
  return 'Calculation(id: $id, expression: $expression, result: $result, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CalculationCopyWith<$Res>  {
  factory $CalculationCopyWith(Calculation value, $Res Function(Calculation) _then) = _$CalculationCopyWithImpl;
@useResult
$Res call({
 String id, String expression, String result, DateTime createdAt
});




}
/// @nodoc
class _$CalculationCopyWithImpl<$Res>
    implements $CalculationCopyWith<$Res> {
  _$CalculationCopyWithImpl(this._self, this._then);

  final Calculation _self;
  final $Res Function(Calculation) _then;

/// Create a copy of Calculation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? expression = null,Object? result = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,expression: null == expression ? _self.expression : expression // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Calculation].
extension CalculationPatterns on Calculation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Calculation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Calculation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Calculation value)  $default,){
final _that = this;
switch (_that) {
case _Calculation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Calculation value)?  $default,){
final _that = this;
switch (_that) {
case _Calculation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String expression,  String result,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Calculation() when $default != null:
return $default(_that.id,_that.expression,_that.result,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String expression,  String result,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Calculation():
return $default(_that.id,_that.expression,_that.result,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String expression,  String result,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Calculation() when $default != null:
return $default(_that.id,_that.expression,_that.result,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Calculation implements Calculation {
  const _Calculation({required this.id, required this.expression, required this.result, required this.createdAt});
  factory _Calculation.fromJson(Map<String, dynamic> json) => _$CalculationFromJson(json);

@override final  String id;
@override final  String expression;
@override final  String result;
@override final  DateTime createdAt;

/// Create a copy of Calculation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculationCopyWith<_Calculation> get copyWith => __$CalculationCopyWithImpl<_Calculation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalculationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Calculation&&(identical(other.id, id) || other.id == id)&&(identical(other.expression, expression) || other.expression == expression)&&(identical(other.result, result) || other.result == result)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,expression,result,createdAt);

@override
String toString() {
  return 'Calculation(id: $id, expression: $expression, result: $result, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CalculationCopyWith<$Res> implements $CalculationCopyWith<$Res> {
  factory _$CalculationCopyWith(_Calculation value, $Res Function(_Calculation) _then) = __$CalculationCopyWithImpl;
@override @useResult
$Res call({
 String id, String expression, String result, DateTime createdAt
});




}
/// @nodoc
class __$CalculationCopyWithImpl<$Res>
    implements _$CalculationCopyWith<$Res> {
  __$CalculationCopyWithImpl(this._self, this._then);

  final _Calculation _self;
  final $Res Function(_Calculation) _then;

/// Create a copy of Calculation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? expression = null,Object? result = null,Object? createdAt = null,}) {
  return _then(_Calculation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,expression: null == expression ? _self.expression : expression // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
