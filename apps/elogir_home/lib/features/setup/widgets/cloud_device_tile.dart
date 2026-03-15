import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// List tile for a cloud-fetched device during setup.
class CloudDeviceTile extends StatelessWidget {
  const CloudDeviceTile({
    required this.device,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final Map<String, dynamic> device;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final name = device['name'] as String? ?? 'Unknown';
    final id = device['id'] as String? ?? '';

    return ElogirPressable(
      onPressed: onTap,
      child: ElogirCard(
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.cloud,
              size: 18,
              color: theme.colors.onSurfaceVariant,
            ),
            SizedBox(width: theme.spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElogirText(
                    name,
                    variant: ElogirTextVariant.bodyMedium,
                  ),
                  ElogirText(
                    id,
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
