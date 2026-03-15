import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Card representing a smart home platform in the setup flow.
class PlatformCard extends StatelessWidget {
  const PlatformCard({
    required this.name,
    required this.icon,
    required this.isEnabled,
    this.onTap,
    super.key,
  });

  final String name;
  final Widget icon;
  final bool isEnabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirPressable(
      onPressed: isEnabled ? onTap : null,
      pressScale: isEnabled ? 0.97 : 1,
      child: ElogirCard(
        child: Opacity(
          opacity: isEnabled ? 1.0 : 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(height: theme.spacing.sm),
              ElogirText(
                name,
                variant: ElogirTextVariant.bodyMedium,
              ),
              if (!isEnabled) ...[
                SizedBox(height: theme.spacing.xxs),
                ElogirText(
                  'Coming Soon',
                  variant: ElogirTextVariant.bodySmall,
                  style: TextStyle(color: theme.colors.onSurfaceVariant),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
