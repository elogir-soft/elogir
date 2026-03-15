import 'package:tinytuya/tinytuya.dart' as tuya;

import '../discovery/device_scanner.dart';
import '../models/scan_result.dart';

class TuyaScanner implements DeviceScanner {
  @override
  Future<List<ScanResult>> scan({
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final discovered = await tuya.deviceScan(
      scanTime: timeout.inSeconds,
    );

    return discovered
        .where((d) => d.gwId != null)
        .map(
          (d) => ScanResult(
            ip: d.ip,
            deviceId: d.gwId!,
            version: d.version,
            productKey: d.productKey,
          ),
        )
        .toList();
  }
}
