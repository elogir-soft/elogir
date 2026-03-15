import '../models/scan_result.dart';

abstract class DeviceScanner {
  Future<List<ScanResult>> scan({
    Duration timeout = const Duration(seconds: 10),
  });
}
