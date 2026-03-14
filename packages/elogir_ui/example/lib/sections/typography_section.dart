import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

class TypographySection extends StatelessWidget {
  const TypographySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElogirText('Typography', variant: ElogirTextVariant.headlineMedium),
        SizedBox(height: theme.spacing.sm),
        ElogirText('Display Small', variant: ElogirTextVariant.displaySmall),
        ElogirText('Headline Small', variant: ElogirTextVariant.headlineSmall),
        ElogirText('Title Medium', variant: ElogirTextVariant.titleMedium),
        ElogirText('Body Medium (default)'),
        ElogirText('Label Large', variant: ElogirTextVariant.labelLarge),
        ElogirText('Caption text', variant: ElogirTextVariant.caption),
      ],
    );
  }
}
