// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smart_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SmartDevice {

 String get id; String get name; DeviceType get type; DeviceConnection get connection;
/// Create a copy of SmartDevice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmartDeviceCopyWith<SmartDevice> get copyWith => _$SmartDeviceCopyWithImpl<SmartDevice>(this as SmartDevice, _$identity);

  /// Serializes this SmartDevice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmartDevice&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.connection, connection) || other.connection == connection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,connection);

@override
String toString() {
  return 'SmartDevice(id: $id, name: $name, type: $type, connection: $connection)';
}


}

/// @nodoc
abstract mixin class $SmartDeviceCopyWith<$Res>  {
  factory $SmartDeviceCopyWith(SmartDevice value, $Res Function(SmartDevice) _then) = _$SmartDeviceCopyWithImpl;
@useResult
$Res call({
 String id, String name, DeviceType type, DeviceConnection connection
});


$DeviceConnectionCopyWith<$Res> get connection;

}
/// @nodoc
class _$SmartDeviceCopyWithImpl<$Res>
    implements $SmartDeviceCopyWith<$Res> {
  _$SmartDeviceCopyWithImpl(this._self, this._then);

  final SmartDevice _self;
  final $Res Function(SmartDevice) _then;

/// Create a copy of SmartDevice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? connection = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DeviceType,connection: null == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as DeviceConnection,
  ));
}
/// Create a copy of SmartDevice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceConnectionCopyWith<$Res> get connection {
  
  return $DeviceConnectionCopyWith<$Res>(_self.connection, (value) {
    return _then(_self.copyWith(connection: value));
  });
}
}


/// Adds pattern-matching-related methods to [SmartDevice].
extension SmartDevicePatterns on SmartDevice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SmartDevice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SmartDevice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SmartDevice value)  $default,){
final _that = this;
switch (_that) {
case _SmartDevice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SmartDevice value)?  $default,){
final _that = this;
switch (_that) {
case _SmartDevice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  DeviceType type,  DeviceConnection connection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SmartDevice() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.connection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  DeviceType type,  DeviceConnection connection)  $default,) {final _that = this;
switch (_that) {
case _SmartDevice():
return $default(_that.id,_that.name,_that.type,_that.connection);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  DeviceType type,  DeviceConnection connection)?  $default,) {final _that = this;
switch (_that) {
case _SmartDevice() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.connection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SmartDevice implements SmartDevice {
  const _SmartDevice({required this.id, required this.name, required this.type, required this.connection});
  factory _SmartDevice.fromJson(Map<String, dynamic> json) => _$SmartDeviceFromJson(json);

@override final  String id;
@override final  String name;
@override final  DeviceType type;
@override final  DeviceConnection connection;

/// Create a copy of SmartDevice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SmartDeviceCopyWith<_SmartDevice> get copyWith => __$SmartDeviceCopyWithImpl<_SmartDevice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SmartDeviceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SmartDevice&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.connection, connection) || other.connection == connection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,connection);

@override
String toString() {
  return 'SmartDevice(id: $id, name: $name, type: $type, connection: $connection)';
}


}

/// @nodoc
abstract mixin class _$SmartDeviceCopyWith<$Res> implements $SmartDeviceCopyWith<$Res> {
  factory _$SmartDeviceCopyWith(_SmartDevice value, $Res Function(_SmartDevice) _then) = __$SmartDeviceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DeviceType type, DeviceConnection connection
});


@override $DeviceConnectionCopyWith<$Res> get connection;

}
/// @nodoc
class __$SmartDeviceCopyWithImpl<$Res>
    implements _$SmartDeviceCopyWith<$Res> {
  __$SmartDeviceCopyWithImpl(this._self, this._then);

  final _SmartDevice _self;
  final $Res Function(_SmartDevice) _then;

/// Create a copy of SmartDevice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? connection = null,}) {
  return _then(_SmartDevice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DeviceType,connection: null == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as DeviceConnection,
  ));
}

/// Create a copy of SmartDevice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceConnectionCopyWith<$Res> get connection {
  
  return $DeviceConnectionCopyWith<$Res>(_self.connection, (value) {
    return _then(_self.copyWith(connection: value));
  });
}
}

DeviceConnection _$DeviceConnectionFromJson(
  Map<String, dynamic> json
) {
    return TuyaConnection.fromJson(
      json
    );
}

/// @nodoc
mixin _$DeviceConnection {

 String get deviceId; String get address; String get localKey; double get version; int get port;
/// Create a copy of DeviceConnection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceConnectionCopyWith<DeviceConnection> get copyWith => _$DeviceConnectionCopyWithImpl<DeviceConnection>(this as DeviceConnection, _$identity);

  /// Serializes this DeviceConnection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceConnection&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.address, address) || other.address == address)&&(identical(other.localKey, localKey) || other.localKey == localKey)&&(identical(other.version, version) || other.version == version)&&(identical(other.port, port) || other.port == port));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,address,localKey,version,port);

@override
String toString() {
  return 'DeviceConnection(deviceId: $deviceId, address: $address, localKey: $localKey, version: $version, port: $port)';
}


}

/// @nodoc
abstract mixin class $DeviceConnectionCopyWith<$Res>  {
  factory $DeviceConnectionCopyWith(DeviceConnection value, $Res Function(DeviceConnection) _then) = _$DeviceConnectionCopyWithImpl;
@useResult
$Res call({
 String deviceId, String address, String localKey, double version, int port
});




}
/// @nodoc
class _$DeviceConnectionCopyWithImpl<$Res>
    implements $DeviceConnectionCopyWith<$Res> {
  _$DeviceConnectionCopyWithImpl(this._self, this._then);

  final DeviceConnection _self;
  final $Res Function(DeviceConnection) _then;

/// Create a copy of DeviceConnection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? address = null,Object? localKey = null,Object? version = null,Object? port = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,localKey: null == localKey ? _self.localKey : localKey // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as double,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceConnection].
extension DeviceConnectionPatterns on DeviceConnection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TuyaConnection value)?  tuya,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TuyaConnection() when tuya != null:
return tuya(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TuyaConnection value)  tuya,}){
final _that = this;
switch (_that) {
case TuyaConnection():
return tuya(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TuyaConnection value)?  tuya,}){
final _that = this;
switch (_that) {
case TuyaConnection() when tuya != null:
return tuya(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String deviceId,  String address,  String localKey,  double version,  int port)?  tuya,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TuyaConnection() when tuya != null:
return tuya(_that.deviceId,_that.address,_that.localKey,_that.version,_that.port);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String deviceId,  String address,  String localKey,  double version,  int port)  tuya,}) {final _that = this;
switch (_that) {
case TuyaConnection():
return tuya(_that.deviceId,_that.address,_that.localKey,_that.version,_that.port);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String deviceId,  String address,  String localKey,  double version,  int port)?  tuya,}) {final _that = this;
switch (_that) {
case TuyaConnection() when tuya != null:
return tuya(_that.deviceId,_that.address,_that.localKey,_that.version,_that.port);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class TuyaConnection implements DeviceConnection {
  const TuyaConnection({required this.deviceId, required this.address, required this.localKey, this.version = 3.3, this.port = 6668});
  factory TuyaConnection.fromJson(Map<String, dynamic> json) => _$TuyaConnectionFromJson(json);

@override final  String deviceId;
@override final  String address;
@override final  String localKey;
@override@JsonKey() final  double version;
@override@JsonKey() final  int port;

/// Create a copy of DeviceConnection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TuyaConnectionCopyWith<TuyaConnection> get copyWith => _$TuyaConnectionCopyWithImpl<TuyaConnection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TuyaConnectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TuyaConnection&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.address, address) || other.address == address)&&(identical(other.localKey, localKey) || other.localKey == localKey)&&(identical(other.version, version) || other.version == version)&&(identical(other.port, port) || other.port == port));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,address,localKey,version,port);

@override
String toString() {
  return 'DeviceConnection.tuya(deviceId: $deviceId, address: $address, localKey: $localKey, version: $version, port: $port)';
}


}

/// @nodoc
abstract mixin class $TuyaConnectionCopyWith<$Res> implements $DeviceConnectionCopyWith<$Res> {
  factory $TuyaConnectionCopyWith(TuyaConnection value, $Res Function(TuyaConnection) _then) = _$TuyaConnectionCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, String address, String localKey, double version, int port
});




}
/// @nodoc
class _$TuyaConnectionCopyWithImpl<$Res>
    implements $TuyaConnectionCopyWith<$Res> {
  _$TuyaConnectionCopyWithImpl(this._self, this._then);

  final TuyaConnection _self;
  final $Res Function(TuyaConnection) _then;

/// Create a copy of DeviceConnection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? address = null,Object? localKey = null,Object? version = null,Object? port = null,}) {
  return _then(TuyaConnection(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,localKey: null == localKey ? _self.localKey : localKey // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as double,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
