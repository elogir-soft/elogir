import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElogirDivider(label: ElogirText('Theme Colors')),
        SizedBox(height: theme.spacing.md),
        const ElogirThemeShowcase(),
      ],
    );
  }
}
