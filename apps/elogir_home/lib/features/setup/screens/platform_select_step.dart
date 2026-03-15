import 'package:elogir_home/features/setup/widgets/platform_card.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Step 1: Select the smart home platform.
class PlatformSelectStep extends StatelessWidget {
  const PlatformSelectStep({required this.onPlatformSelected, super.key});

  final ValueChanged<String> onPlatformSelected;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Padding(
      padding: EdgeInsets.all(theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ElogirText(
            'Select Platform',
            variant: ElogirTextVariant.headlineSmall,
          ),
          SizedBox(height: theme.spacing.sm),
          ElogirText(
            'Choose your smart home platform to get started.',
            variant: ElogirTextVariant.bodyMedium,
            style: TextStyle(color: theme.colors.onSurfaceVariant),
          ),
          SizedBox(height: theme.spacing.lg),
          Wrap(
            spacing: theme.spacing.md,
            runSpacing: theme.spacing.md,
            children: [
              SizedBox(
                width: 140,
                height: 120,
                child: PlatformCard(
                  name: 'Tuya',
                  icon: FaIcon(
                    FontAwesomeIcons.bolt,
                    size: 28,
                    color: theme.colors.primary,
                  ),
                  isEnabled: true,
                  onTap: () => onPlatformSelected('tuya'),
                ),
              ),
              SizedBox(
                width: 140,
                height: 120,
                child: PlatformCard(
                  name: 'Matter',
                  icon: FaIcon(
                    FontAwesomeIcons.microchip,
                    size: 28,
                    color: theme.colors.onSurfaceVariant,
                  ),
                  isEnabled: false,
                ),
              ),
              SizedBox(
                width: 140,
                height: 120,
                child: PlatformCard(
                  name: 'HomeKit',
                  icon: FaIcon(
                    FontAwesomeIcons.house,
                    size: 28,
                    color: theme.colors.onSurfaceVariant,
                  ),
                  isEnabled: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
