import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/devices/widgets/device_type_icon.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Card displaying a device's name, type icon, and connection platform.
class DeviceCard extends StatelessWidget {
  const DeviceCard({
    required this.device,
    required this.onTap,
    super.key,
  });

  final SmartDevice device;
  final VoidCallback onTap;

  String get _platformLabel => switch (device.connection) {
        TuyaConnection() => 'Tuya',
      };

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirPressable(
      onPressed: onTap,
      pressScale: 0.98,
      child: ElogirCard(
        child: Row(
          children: [
            DeviceTypeIcon(
              type: device.type,
              size: 24,
              color: theme.colors.primary,
            ),
            SizedBox(width: theme.spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElogirText(
                    device.name,
                    variant: ElogirTextVariant.bodyLarge,
                  ),
                  SizedBox(height: theme.spacing.xxs),
                  ElogirText(
                    '${DeviceTypeIcon.labelFor(device.type)} · $_platformLabel',
                    variant: ElogirTextVariant.bodySmall,
                    style: TextStyle(color: theme.colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 12,
              color: theme.colors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
