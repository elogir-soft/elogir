import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/setup/widgets/cloud_device_tile.dart';
import 'package:elogir_home/features/setup/widgets/scan_result_tile.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Step 3: Select a device from cloud-fetched or LAN-scanned results.
class DeviceListStep extends StatelessWidget {
  const DeviceListStep({
    required this.cloudDevices,
    required this.scanResults,
    required this.selectedDeviceId,
    required this.useLanScan,
    required this.onDeviceSelected,
    super.key,
  });

  final List<Map<String, dynamic>> cloudDevices;
  final List<ScanResult> scanResults;
  final String? selectedDeviceId;
  final bool useLanScan;
  final ValueChanged<String> onDeviceSelected;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Padding(
      padding: EdgeInsets.all(theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElogirText(
            useLanScan ? 'Scanned Devices' : 'Cloud Devices',
            variant: ElogirTextVariant.headlineSmall,
          ),
          SizedBox(height: theme.spacing.sm),
          ElogirText(
            'Select a device to add.',
            variant: ElogirTextVariant.bodyMedium,
            style: TextStyle(color: theme.colors.onSurfaceVariant),
          ),
          SizedBox(height: theme.spacing.lg),
          Expanded(
            child: useLanScan ? _buildScanList(theme) : _buildCloudList(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildCloudList(ElogirThemeData theme) {
    if (cloudDevices.isEmpty) {
      return const Center(
        child: ElogirText('No devices found in your Tuya Cloud account.'),
      );
    }

    return ListView.separated(
      itemCount: cloudDevices.length,
      separatorBuilder: (_, __) => SizedBox(height: theme.spacing.sm),
      itemBuilder: (context, index) {
        final device = cloudDevices[index];
        final id = device['id'] as String? ?? '';
        return CloudDeviceTile(
          device: device,
          isSelected: selectedDeviceId == id,
          onTap: () => onDeviceSelected(id),
        );
      },
    );
  }

  Widget _buildScanList(ElogirThemeData theme) {
    if (scanResults.isEmpty) {
      return const Center(
        child: ElogirText('No devices found on the local network.'),
      );
    }

    return ListView.separated(
      itemCount: scanResults.length,
      separatorBuilder: (_, __) => SizedBox(height: theme.spacing.sm),
      itemBuilder: (context, index) {
        final result = scanResults[index];
        return ScanResultTile(
          result: result,
          isSelected: selectedDeviceId == result.deviceId,
          onTap: () => onDeviceSelected(result.deviceId),
        );
      },
    );
  }
}
