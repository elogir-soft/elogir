import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/config/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Typed wrapper around [FlutterSecureStorage] for Tuya credentials.
class CredentialsService {
  const CredentialsService(this._storage);

  final FlutterSecureStorage _storage;

  Future<TuyaCredentials?> getTuyaCredentials() async {
    final apiKey = await _storage.read(key: AppConstants.tuyaApiKeyKey);
    final apiSecret =
        await _storage.read(key: AppConstants.tuyaApiSecretKey);
    final region = await _storage.read(key: AppConstants.tuyaRegionKey);

    if (apiKey == null || apiSecret == null || region == null) return null;

    return TuyaCredentials(
      apiKey: apiKey,
      apiSecret: apiSecret,
      region: region,
    );
  }

  Future<void> saveTuyaCredentials(TuyaCredentials credentials) async {
    await _storage.write(
      key: AppConstants.tuyaApiKeyKey,
      value: credentials.apiKey,
    );
    await _storage.write(
      key: AppConstants.tuyaApiSecretKey,
      value: credentials.apiSecret,
    );
    await _storage.write(
      key: AppConstants.tuyaRegionKey,
      value: credentials.region,
    );
  }

  Future<void> deleteTuyaCredentials() async {
    await _storage.delete(key: AppConstants.tuyaApiKeyKey);
    await _storage.delete(key: AppConstants.tuyaApiSecretKey);
    await _storage.delete(key: AppConstants.tuyaRegionKey);
  }

  Future<bool> hasTuyaCredentials() async {
    final apiKey = await _storage.read(key: AppConstants.tuyaApiKeyKey);
    return apiKey != null;
  }
}
