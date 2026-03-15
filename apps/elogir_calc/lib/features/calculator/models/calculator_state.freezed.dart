// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculator_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalculatorState {

 String get expression; String get display; String get preview; bool get hasError; bool get isScientific; bool get isDegrees; bool get justEvaluated;
/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculatorStateCopyWith<CalculatorState> get copyWith => _$CalculatorStateCopyWithImpl<CalculatorState>(this as CalculatorState, _$identity);

  /// Serializes this CalculatorState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalculatorState&&(identical(other.expression, expression) || other.expression == expression)&&(identical(other.display, display) || other.display == display)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.isScientific, isScientific) || other.isScientific == isScientific)&&(identical(other.isDegrees, isDegrees) || other.isDegrees == isDegrees)&&(identical(other.justEvaluated, justEvaluated) || other.justEvaluated == justEvaluated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expression,display,preview,hasError,isScientific,isDegrees,justEvaluated);

@override
String toString() {
  return 'CalculatorState(expression: $expression, display: $display, preview: $preview, hasError: $hasError, isScientific: $isScientific, isDegrees: $isDegrees, justEvaluated: $justEvaluated)';
}


}

/// @nodoc
abstract mixin class $CalculatorStateCopyWith<$Res>  {
  factory $CalculatorStateCopyWith(CalculatorState value, $Res Function(CalculatorState) _then) = _$CalculatorStateCopyWithImpl;
@useResult
$Res call({
 String expression, String display, String preview, bool hasError, bool isScientific, bool isDegrees, bool justEvaluated
});




}
/// @nodoc
class _$CalculatorStateCopyWithImpl<$Res>
    implements $CalculatorStateCopyWith<$Res> {
  _$CalculatorStateCopyWithImpl(this._self, this._then);

  final CalculatorState _self;
  final $Res Function(CalculatorState) _then;

/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expression = null,Object? display = null,Object? preview = null,Object? hasError = null,Object? isScientific = null,Object? isDegrees = null,Object? justEvaluated = null,}) {
  return _then(_self.copyWith(
expression: null == expression ? _self.expression : expression // ignore: cast_nullable_to_non_nullable
as String,display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as String,preview: null == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as String,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,isScientific: null == isScientific ? _self.isScientific : isScientific // ignore: cast_nullable_to_non_nullable
as bool,isDegrees: null == isDegrees ? _self.isDegrees : isDegrees // ignore: cast_nullable_to_non_nullable
as bool,justEvaluated: null == justEvaluated ? _self.justEvaluated : justEvaluated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CalculatorState].
extension CalculatorStatePatterns on CalculatorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalculatorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalculatorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalculatorState value)  $default,){
final _that = this;
switch (_that) {
case _CalculatorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalculatorState value)?  $default,){
final _that = this;
switch (_that) {
case _CalculatorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String expression,  String display,  String preview,  bool hasError,  bool isScientific,  bool isDegrees,  bool justEvaluated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalculatorState() when $default != null:
return $default(_that.expression,_that.display,_that.preview,_that.hasError,_that.isScientific,_that.isDegrees,_that.justEvaluated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String expression,  String display,  String preview,  bool hasError,  bool isScientific,  bool isDegrees,  bool justEvaluated)  $default,) {final _that = this;
switch (_that) {
case _CalculatorState():
return $default(_that.expression,_that.display,_that.preview,_that.hasError,_that.isScientific,_that.isDegrees,_that.justEvaluated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String expression,  String display,  String preview,  bool hasError,  bool isScientific,  bool isDegrees,  bool justEvaluated)?  $default,) {final _that = this;
switch (_that) {
case _CalculatorState() when $default != null:
return $default(_that.expression,_that.display,_that.preview,_that.hasError,_that.isScientific,_that.isDegrees,_that.justEvaluated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalculatorState implements CalculatorState {
  const _CalculatorState({this.expression = '', this.display = '0', this.preview = '', this.hasError = false, this.isScientific = false, this.isDegrees = true, this.justEvaluated = false});
  factory _CalculatorState.fromJson(Map<String, dynamic> json) => _$CalculatorStateFromJson(json);

@override@JsonKey() final  String expression;
@override@JsonKey() final  String display;
@override@JsonKey() final  String preview;
@override@JsonKey() final  bool hasError;
@override@JsonKey() final  bool isScientific;
@override@JsonKey() final  bool isDegrees;
@override@JsonKey() final  bool justEvaluated;

/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculatorStateCopyWith<_CalculatorState> get copyWith => __$CalculatorStateCopyWithImpl<_CalculatorState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalculatorStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalculatorState&&(identical(other.expression, expression) || other.expression == expression)&&(identical(other.display, display) || other.display == display)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.isScientific, isScientific) || other.isScientific == isScientific)&&(identical(other.isDegrees, isDegrees) || other.isDegrees == isDegrees)&&(identical(other.justEvaluated, justEvaluated) || other.justEvaluated == justEvaluated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expression,display,preview,hasError,isScientific,isDegrees,justEvaluated);

@override
String toString() {
  return 'CalculatorState(expression: $expression, display: $display, preview: $preview, hasError: $hasError, isScientific: $isScientific, isDegrees: $isDegrees, justEvaluated: $justEvaluated)';
}


}

/// @nodoc
abstract mixin class _$CalculatorStateCopyWith<$Res> implements $CalculatorStateCopyWith<$Res> {
  factory _$CalculatorStateCopyWith(_CalculatorState value, $Res Function(_CalculatorState) _then) = __$CalculatorStateCopyWithImpl;
@override @useResult
$Res call({
 String expression, String display, String preview, bool hasError, bool isScientific, bool isDegrees, bool justEvaluated
});




}
/// @nodoc
class __$CalculatorStateCopyWithImpl<$Res>
    implements _$CalculatorStateCopyWith<$Res> {
  __$CalculatorStateCopyWithImpl(this._self, this._then);

  final _CalculatorState _self;
  final $Res Function(_CalculatorState) _then;

/// Create a copy of CalculatorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expression = null,Object? display = null,Object? preview = null,Object? hasError = null,Object? isScientific = null,Object? isDegrees = null,Object? justEvaluated = null,}) {
  return _then(_CalculatorState(
expression: null == expression ? _self.expression : expression // ignore: cast_nullable_to_non_nullable
as String,display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as String,preview: null == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as String,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,isScientific: null == isScientific ? _self.isScientific : isScientific // ignore: cast_nullable_to_non_nullable
as bool,isDegrees: null == isDegrees ? _self.isDegrees : isDegrees // ignore: cast_nullable_to_non_nullable
as bool,justEvaluated: null == justEvaluated ? _self.justEvaluated : justEvaluated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
