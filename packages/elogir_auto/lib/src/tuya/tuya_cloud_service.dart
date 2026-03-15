import 'package:tinytuya/tinytuya.dart' as tuya;

import '../models/tuya_credentials.dart';

class TuyaCloudService {
  TuyaCloudService(this._credentials)
      : _cloud = tuya.Cloud(
          apiKey: _credentials.apiKey,
          apiSecret: _credentials.apiSecret,
          apiRegion: _credentials.region,
        );

  final TuyaCredentials _credentials;
  final tuya.Cloud _cloud;

  TuyaCredentials get credentials => _credentials;

  Future<bool> init() => _cloud.init();

  Future<List<Map<String, dynamic>>> getDevices() => _cloud.getDevices();

  Future<Map<String, dynamic>?> getStatus(String deviceId) =>
      _cloud.getStatus(deviceId);

  Future<Map<String, dynamic>?> sendCommand(
    String deviceId,
    Map<String, dynamic> commands,
  ) =>
      _cloud.sendCommand(deviceId, commands);
}
