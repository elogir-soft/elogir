import 'package:freezed_annotation/freezed_annotation.dart';

part 'tuya_credentials.freezed.dart';
part 'tuya_credentials.g.dart';

@freezed
sealed class TuyaCredentials with _$TuyaCredentials {
  const factory TuyaCredentials({
    required String apiKey,
    required String apiSecret,
    required String region,
  }) = _TuyaCredentials;

  factory TuyaCredentials.fromJson(Map<String, dynamic> json) =>
      _$TuyaCredentialsFromJson(json);
}
