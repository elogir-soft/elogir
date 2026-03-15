import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_result.freezed.dart';
part 'scan_result.g.dart';

@freezed
sealed class ScanResult with _$ScanResult {
  const factory ScanResult({
    required String ip,
    required String deviceId,
    String? version,
    String? productKey,
  }) = _ScanResult;

  factory ScanResult.fromJson(Map<String, dynamic> json) =>
      _$ScanResultFromJson(json);
}
