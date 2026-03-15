import 'package:elogir_auto/elogir_auto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_state.freezed.dart';

/// Tracks the multi-step add-device flow.
@freezed
abstract class SetupState with _$SetupState {
  const factory SetupState({
    @Default(0) int currentStep,
    String? selectedPlatform,
    TuyaCredentials? credentials,
    @Default([]) List<Map<String, dynamic>> cloudDevices,
    @Default([]) List<ScanResult> scanResults,
    String? selectedDeviceId,
    @Default('') String deviceName,
    @Default(DeviceType.light) DeviceType deviceType,
    String? localKey,
    String? deviceAddress,
    @Default(3.3) double deviceVersion,
    @Default(false) bool useLanScan,
  }) = _SetupState;
}
