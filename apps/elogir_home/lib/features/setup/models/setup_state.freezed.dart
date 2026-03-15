// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetupState {

 int get currentStep; String? get selectedPlatform; TuyaCredentials? get credentials; List<Map<String, dynamic>> get cloudDevices; List<ScanResult> get scanResults; String? get selectedDeviceId; String get deviceName; DeviceType get deviceType; String? get localKey; String? get deviceAddress; double get deviceVersion; bool get useLanScan;
/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupStateCopyWith<SetupState> get copyWith => _$SetupStateCopyWithImpl<SetupState>(this as SetupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.selectedPlatform, selectedPlatform) || other.selectedPlatform == selectedPlatform)&&(identical(other.credentials, credentials) || other.credentials == credentials)&&const DeepCollectionEquality().equals(other.cloudDevices, cloudDevices)&&const DeepCollectionEquality().equals(other.scanResults, scanResults)&&(identical(other.selectedDeviceId, selectedDeviceId) || other.selectedDeviceId == selectedDeviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.localKey, localKey) || other.localKey == localKey)&&(identical(other.deviceAddress, deviceAddress) || other.deviceAddress == deviceAddress)&&(identical(other.deviceVersion, deviceVersion) || other.deviceVersion == deviceVersion)&&(identical(other.useLanScan, useLanScan) || other.useLanScan == useLanScan));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,selectedPlatform,credentials,const DeepCollectionEquality().hash(cloudDevices),const DeepCollectionEquality().hash(scanResults),selectedDeviceId,deviceName,deviceType,localKey,deviceAddress,deviceVersion,useLanScan);

@override
String toString() {
  return 'SetupState(currentStep: $currentStep, selectedPlatform: $selectedPlatform, credentials: $credentials, cloudDevices: $cloudDevices, scanResults: $scanResults, selectedDeviceId: $selectedDeviceId, deviceName: $deviceName, deviceType: $deviceType, localKey: $localKey, deviceAddress: $deviceAddress, deviceVersion: $deviceVersion, useLanScan: $useLanScan)';
}


}

/// @nodoc
abstract mixin class $SetupStateCopyWith<$Res>  {
  factory $SetupStateCopyWith(SetupState value, $Res Function(SetupState) _then) = _$SetupStateCopyWithImpl;
@useResult
$Res call({
 int currentStep, String? selectedPlatform, TuyaCredentials? credentials, List<Map<String, dynamic>> cloudDevices, List<ScanResult> scanResults, String? selectedDeviceId, String deviceName, DeviceType deviceType, String? localKey, String? deviceAddress, double deviceVersion, bool useLanScan
});


$TuyaCredentialsCopyWith<$Res>? get credentials;

}
/// @nodoc
class _$SetupStateCopyWithImpl<$Res>
    implements $SetupStateCopyWith<$Res> {
  _$SetupStateCopyWithImpl(this._self, this._then);

  final SetupState _self;
  final $Res Function(SetupState) _then;

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStep = null,Object? selectedPlatform = freezed,Object? credentials = freezed,Object? cloudDevices = null,Object? scanResults = null,Object? selectedDeviceId = freezed,Object? deviceName = null,Object? deviceType = null,Object? localKey = freezed,Object? deviceAddress = freezed,Object? deviceVersion = null,Object? useLanScan = null,}) {
  return _then(_self.copyWith(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,selectedPlatform: freezed == selectedPlatform ? _self.selectedPlatform : selectedPlatform // ignore: cast_nullable_to_non_nullable
as String?,credentials: freezed == credentials ? _self.credentials : credentials // ignore: cast_nullable_to_non_nullable
as TuyaCredentials?,cloudDevices: null == cloudDevices ? _self.cloudDevices : cloudDevices // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,scanResults: null == scanResults ? _self.scanResults : scanResults // ignore: cast_nullable_to_non_nullable
as List<ScanResult>,selectedDeviceId: freezed == selectedDeviceId ? _self.selectedDeviceId : selectedDeviceId // ignore: cast_nullable_to_non_nullable
as String?,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as DeviceType,localKey: freezed == localKey ? _self.localKey : localKey // ignore: cast_nullable_to_non_nullable
as String?,deviceAddress: freezed == deviceAddress ? _self.deviceAddress : deviceAddress // ignore: cast_nullable_to_non_nullable
as String?,deviceVersion: null == deviceVersion ? _self.deviceVersion : deviceVersion // ignore: cast_nullable_to_non_nullable
as double,useLanScan: null == useLanScan ? _self.useLanScan : useLanScan // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TuyaCredentialsCopyWith<$Res>? get credentials {
    if (_self.credentials == null) {
    return null;
  }

  return $TuyaCredentialsCopyWith<$Res>(_self.credentials!, (value) {
    return _then(_self.copyWith(credentials: value));
  });
}
}


/// Adds pattern-matching-related methods to [SetupState].
extension SetupStatePatterns on SetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetupState value)  $default,){
final _that = this;
switch (_that) {
case _SetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetupState value)?  $default,){
final _that = this;
switch (_that) {
case _SetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentStep,  String? selectedPlatform,  TuyaCredentials? credentials,  List<Map<String, dynamic>> cloudDevices,  List<ScanResult> scanResults,  String? selectedDeviceId,  String deviceName,  DeviceType deviceType,  String? localKey,  String? deviceAddress,  double deviceVersion,  bool useLanScan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetupState() when $default != null:
return $default(_that.currentStep,_that.selectedPlatform,_that.credentials,_that.cloudDevices,_that.scanResults,_that.selectedDeviceId,_that.deviceName,_that.deviceType,_that.localKey,_that.deviceAddress,_that.deviceVersion,_that.useLanScan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentStep,  String? selectedPlatform,  TuyaCredentials? credentials,  List<Map<String, dynamic>> cloudDevices,  List<ScanResult> scanResults,  String? selectedDeviceId,  String deviceName,  DeviceType deviceType,  String? localKey,  String? deviceAddress,  double deviceVersion,  bool useLanScan)  $default,) {final _that = this;
switch (_that) {
case _SetupState():
return $default(_that.currentStep,_that.selectedPlatform,_that.credentials,_that.cloudDevices,_that.scanResults,_that.selectedDeviceId,_that.deviceName,_that.deviceType,_that.localKey,_that.deviceAddress,_that.deviceVersion,_that.useLanScan);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentStep,  String? selectedPlatform,  TuyaCredentials? credentials,  List<Map<String, dynamic>> cloudDevices,  List<ScanResult> scanResults,  String? selectedDeviceId,  String deviceName,  DeviceType deviceType,  String? localKey,  String? deviceAddress,  double deviceVersion,  bool useLanScan)?  $default,) {final _that = this;
switch (_that) {
case _SetupState() when $default != null:
return $default(_that.currentStep,_that.selectedPlatform,_that.credentials,_that.cloudDevices,_that.scanResults,_that.selectedDeviceId,_that.deviceName,_that.deviceType,_that.localKey,_that.deviceAddress,_that.deviceVersion,_that.useLanScan);case _:
  return null;

}
}

}

/// @nodoc


class _SetupState implements SetupState {
  const _SetupState({this.currentStep = 0, this.selectedPlatform, this.credentials, final  List<Map<String, dynamic>> cloudDevices = const [], final  List<ScanResult> scanResults = const [], this.selectedDeviceId, this.deviceName = '', this.deviceType = DeviceType.light, this.localKey, this.deviceAddress, this.deviceVersion = 3.3, this.useLanScan = false}): _cloudDevices = cloudDevices,_scanResults = scanResults;
  

@override@JsonKey() final  int currentStep;
@override final  String? selectedPlatform;
@override final  TuyaCredentials? credentials;
 final  List<Map<String, dynamic>> _cloudDevices;
@override@JsonKey() List<Map<String, dynamic>> get cloudDevices {
  if (_cloudDevices is EqualUnmodifiableListView) return _cloudDevices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cloudDevices);
}

 final  List<ScanResult> _scanResults;
@override@JsonKey() List<ScanResult> get scanResults {
  if (_scanResults is EqualUnmodifiableListView) return _scanResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scanResults);
}

@override final  String? selectedDeviceId;
@override@JsonKey() final  String deviceName;
@override@JsonKey() final  DeviceType deviceType;
@override final  String? localKey;
@override final  String? deviceAddress;
@override@JsonKey() final  double deviceVersion;
@override@JsonKey() final  bool useLanScan;

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetupStateCopyWith<_SetupState> get copyWith => __$SetupStateCopyWithImpl<_SetupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetupState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.selectedPlatform, selectedPlatform) || other.selectedPlatform == selectedPlatform)&&(identical(other.credentials, credentials) || other.credentials == credentials)&&const DeepCollectionEquality().equals(other._cloudDevices, _cloudDevices)&&const DeepCollectionEquality().equals(other._scanResults, _scanResults)&&(identical(other.selectedDeviceId, selectedDeviceId) || other.selectedDeviceId == selectedDeviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.localKey, localKey) || other.localKey == localKey)&&(identical(other.deviceAddress, deviceAddress) || other.deviceAddress == deviceAddress)&&(identical(other.deviceVersion, deviceVersion) || other.deviceVersion == deviceVersion)&&(identical(other.useLanScan, useLanScan) || other.useLanScan == useLanScan));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,selectedPlatform,credentials,const DeepCollectionEquality().hash(_cloudDevices),const DeepCollectionEquality().hash(_scanResults),selectedDeviceId,deviceName,deviceType,localKey,deviceAddress,deviceVersion,useLanScan);

@override
String toString() {
  return 'SetupState(currentStep: $currentStep, selectedPlatform: $selectedPlatform, credentials: $credentials, cloudDevices: $cloudDevices, scanResults: $scanResults, selectedDeviceId: $selectedDeviceId, deviceName: $deviceName, deviceType: $deviceType, localKey: $localKey, deviceAddress: $deviceAddress, deviceVersion: $deviceVersion, useLanScan: $useLanScan)';
}


}

/// @nodoc
abstract mixin class _$SetupStateCopyWith<$Res> implements $SetupStateCopyWith<$Res> {
  factory _$SetupStateCopyWith(_SetupState value, $Res Function(_SetupState) _then) = __$SetupStateCopyWithImpl;
@override @useResult
$Res call({
 int currentStep, String? selectedPlatform, TuyaCredentials? credentials, List<Map<String, dynamic>> cloudDevices, List<ScanResult> scanResults, String? selectedDeviceId, String deviceName, DeviceType deviceType, String? localKey, String? deviceAddress, double deviceVersion, bool useLanScan
});


@override $TuyaCredentialsCopyWith<$Res>? get credentials;

}
/// @nodoc
class __$SetupStateCopyWithImpl<$Res>
    implements _$SetupStateCopyWith<$Res> {
  __$SetupStateCopyWithImpl(this._self, this._then);

  final _SetupState _self;
  final $Res Function(_SetupState) _then;

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStep = null,Object? selectedPlatform = freezed,Object? credentials = freezed,Object? cloudDevices = null,Object? scanResults = null,Object? selectedDeviceId = freezed,Object? deviceName = null,Object? deviceType = null,Object? localKey = freezed,Object? deviceAddress = freezed,Object? deviceVersion = null,Object? useLanScan = null,}) {
  return _then(_SetupState(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,selectedPlatform: freezed == selectedPlatform ? _self.selectedPlatform : selectedPlatform // ignore: cast_nullable_to_non_nullable
as String?,credentials: freezed == credentials ? _self.credentials : credentials // ignore: cast_nullable_to_non_nullable
as TuyaCredentials?,cloudDevices: null == cloudDevices ? _self._cloudDevices : cloudDevices // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,scanResults: null == scanResults ? _self._scanResults : scanResults // ignore: cast_nullable_to_non_nullable
as List<ScanResult>,selectedDeviceId: freezed == selectedDeviceId ? _self.selectedDeviceId : selectedDeviceId // ignore: cast_nullable_to_non_nullable
as String?,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as DeviceType,localKey: freezed == localKey ? _self.localKey : localKey // ignore: cast_nullable_to_non_nullable
as String?,deviceAddress: freezed == deviceAddress ? _self.deviceAddress : deviceAddress // ignore: cast_nullable_to_non_nullable
as String?,deviceVersion: null == deviceVersion ? _self.deviceVersion : deviceVersion // ignore: cast_nullable_to_non_nullable
as double,useLanScan: null == useLanScan ? _self.useLanScan : useLanScan // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TuyaCredentialsCopyWith<$Res>? get credentials {
    if (_self.credentials == null) {
    return null;
  }

  return $TuyaCredentialsCopyWith<$Res>(_self.credentials!, (value) {
    return _then(_self.copyWith(credentials: value));
  });
}
}

// dart format on
