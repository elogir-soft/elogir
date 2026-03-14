import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElogirDivider(label: ElogirText('Buttons')),
        SizedBox(height: theme.spacing.md),
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          children: [
            ElogirButton(onPressed: () {}, child: const Text('Filled')),
            ElogirButton(
              variant: ElogirButtonVariant.outlined,
              onPressed: () {},
              child: const Text('Outlined'),
            ),
            ElogirButton(
              variant: ElogirButtonVariant.ghost,
              onPressed: () {},
              child: const Text('Ghost'),
            ),
            ElogirButton(onPressed: null, child: const Text('Disabled')),
          ],
        ),
        SizedBox(height: theme.spacing.md),
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElogirButton(
              size: ElogirButtonSize.sm,
              onPressed: () {},
              child: const Text('Small'),
            ),
            ElogirButton(
              size: ElogirButtonSize.md,
              onPressed: () {},
              child: const Text('Medium'),
            ),
            ElogirButton(
              size: ElogirButtonSize.lg,
              onPressed: () {},
              child: const Text('Large'),
            ),
          ],
        ),
      ],
    );
  }
}
