import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/devices/widgets/device_type_icon.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Displays device metadata: name, type, connection details.
class DeviceInfoSection extends StatelessWidget {
  const DeviceInfoSection({required this.device, super.key});

  final SmartDevice device;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final connection = device.connection;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: theme.spacing.xs,
            bottom: theme.spacing.sm,
          ),
          child: ElogirText(
            'Device Info',
            variant: ElogirTextVariant.labelLarge,
            style: TextStyle(color: theme.colors.onSurfaceVariant),
          ),
        ),
        ElogirCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _InfoRow(label: 'Name', value: device.name),
              ElogirDivider(),
              _InfoRow(
                label: 'Type',
                value: DeviceTypeIcon.labelFor(device.type),
              ),
              ElogirDivider(),
              _InfoRow(
                label: 'Platform',
                value: switch (connection) {
                  TuyaConnection() => 'Tuya',
                },
              ),
              if (connection case TuyaConnection(:final deviceId)) ...[
                ElogirDivider(),
                _InfoRow(label: 'Device ID', value: deviceId),
              ],
              if (connection
                  case TuyaConnection(:final address)
                  when address.isNotEmpty) ...[
                ElogirDivider(),
                _InfoRow(label: 'LAN IP', value: address),
              ],
              if (connection case TuyaConnection(:final version)) ...[
                ElogirDivider(),
                _InfoRow(label: 'Protocol', value: 'v$version'),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.md,
        vertical: theme.spacing.sm,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: ElogirText(
              label,
              variant: ElogirTextVariant.bodyMedium,
              style: TextStyle(color: theme.colors.onSurfaceVariant),
            ),
          ),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: theme.typography.bodyMedium.copyWith(
                color: theme.colors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
