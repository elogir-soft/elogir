import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// List tile for a LAN-scanned device during setup.
class ScanResultTile extends StatelessWidget {
  const ScanResultTile({
    required this.result,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final ScanResult result;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirPressable(
      onPressed: onTap,
      child: ElogirCard(
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.wifi,
              size: 18,
              color: theme.colors.onSurfaceVariant,
            ),
            SizedBox(width: theme.spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElogirText(
                    result.ip,
                    variant: ElogirTextVariant.bodyMedium,
                  ),
                  ElogirText(
                    result.deviceId,
                    variant: ElogirTextVariant.bodySmall,
                    style: TextStyle(color: theme.colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            if (isSelected)
              FaIcon(
                FontAwesomeIcons.check,
                size: 16,
                color: theme.colors.primary,
              ),
          ],
        ),
      ),
    );
  }
}
