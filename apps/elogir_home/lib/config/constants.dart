/// App-wide constants for elogir_home.
abstract final class AppConstants {
  /// Database file name for app-local settings.
  static const String databaseName = 'elogir_home.db';

  /// Secure storage key for Tuya API key.
  static const String tuyaApiKeyKey = 'tuya_api_key';

  /// Secure storage key for Tuya API secret.
  static const String tuyaApiSecretKey = 'tuya_api_secret';

  /// Secure storage key for Tuya region.
  static const String tuyaRegionKey = 'tuya_region';

  /// Default LAN scan timeout.
  static const Duration scanTimeout = Duration(seconds: 10);
}
