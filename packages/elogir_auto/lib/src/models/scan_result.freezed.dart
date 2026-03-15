// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScanResult {

 String get ip; String get deviceId; String? get version; String? get productKey;
/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanResultCopyWith<ScanResult> get copyWith => _$ScanResultCopyWithImpl<ScanResult>(this as ScanResult, _$identity);

  /// Serializes this ScanResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanResult&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.version, version) || other.version == version)&&(identical(other.productKey, productKey) || other.productKey == productKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ip,deviceId,version,productKey);

@override
String toString() {
  return 'ScanResult(ip: $ip, deviceId: $deviceId, version: $version, productKey: $productKey)';
}


}

/// @nodoc
abstract mixin class $ScanResultCopyWith<$Res>  {
  factory $ScanResultCopyWith(ScanResult value, $Res Function(ScanResult) _then) = _$ScanResultCopyWithImpl;
@useResult
$Res call({
 String ip, String deviceId, String? version, String? productKey
});




}
/// @nodoc
class _$ScanResultCopyWithImpl<$Res>
    implements $ScanResultCopyWith<$Res> {
  _$ScanResultCopyWithImpl(this._self, this._then);

  final ScanResult _self;
  final $Res Function(ScanResult) _then;

/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ip = null,Object? deviceId = null,Object? version = freezed,Object? productKey = freezed,}) {
  return _then(_self.copyWith(
ip: null == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,productKey: freezed == productKey ? _self.productKey : productKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanResult].
extension ScanResultPatterns on ScanResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanResult value)  $default,){
final _that = this;
switch (_that) {
case _ScanResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanResult value)?  $default,){
final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ip,  String deviceId,  String? version,  String? productKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
return $default(_that.ip,_that.deviceId,_that.version,_that.productKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ip,  String deviceId,  String? version,  String? productKey)  $default,) {final _that = this;
switch (_that) {
case _ScanResult():
return $default(_that.ip,_that.deviceId,_that.version,_that.productKey);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ip,  String deviceId,  String? version,  String? productKey)?  $default,) {final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
return $default(_that.ip,_that.deviceId,_that.version,_that.productKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScanResult implements ScanResult {
  const _ScanResult({required this.ip, required this.deviceId, this.version, this.productKey});
  factory _ScanResult.fromJson(Map<String, dynamic> json) => _$ScanResultFromJson(json);

@override final  String ip;
@override final  String deviceId;
@override final  String? version;
@override final  String? productKey;

/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanResultCopyWith<_ScanResult> get copyWith => __$ScanResultCopyWithImpl<_ScanResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScanResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanResult&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.version, version) || other.version == version)&&(identical(other.productKey, productKey) || other.productKey == productKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ip,deviceId,version,productKey);

@override
String toString() {
  return 'ScanResult(ip: $ip, deviceId: $deviceId, version: $version, productKey: $productKey)';
}


}

/// @nodoc
abstract mixin class _$ScanResultCopyWith<$Res> implements $ScanResultCopyWith<$Res> {
  factory _$ScanResultCopyWith(_ScanResult value, $Res Function(_ScanResult) _then) = __$ScanResultCopyWithImpl;
@override @useResult
$Res call({
 String ip, String deviceId, String? version, String? productKey
});




}
/// @nodoc
class __$ScanResultCopyWithImpl<$Res>
    implements _$ScanResultCopyWith<$Res> {
  __$ScanResultCopyWithImpl(this._self, this._then);

  final _ScanResult _self;
  final $Res Function(_ScanResult) _then;

/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ip = null,Object? deviceId = null,Object? version = freezed,Object? productKey = freezed,}) {
  return _then(_ScanResult(
ip: null == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,productKey: freezed == productKey ? _self.productKey : productKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
