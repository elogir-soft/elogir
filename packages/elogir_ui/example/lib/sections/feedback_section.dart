import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

class FeedbackSection extends StatefulWidget {
  const FeedbackSection({super.key});

  @override
  State<FeedbackSection> createState() => _FeedbackSectionState();
}

class _FeedbackSectionState extends State<FeedbackSection> {
  final GlobalKey<ElogirPopoverState> _popoverKey =
      GlobalKey<ElogirPopoverState>();

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElogirDivider(label: ElogirText('Progress & Loading')),
        SizedBox(height: theme.spacing.md),
        ElogirProgressBar(
          value: 0.65,
          label: const Text('Uploading files'),
          showPercentage: true,
        ),
        SizedBox(height: theme.spacing.md),
        const ElogirProgressBar(value: null, height: 6),
        SizedBox(height: theme.spacing.md),
        Row(
          children: [
            const ElogirSpinner(size: 20),
            SizedBox(width: theme.spacing.sm),
            const ElogirSpinner(size: 32),
            SizedBox(width: theme.spacing.sm),
            const ElogirSpinner(size: 44),
          ],
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Accordion')),
        SizedBox(height: theme.spacing.md),
        ElogirAccordionGroup(
          children: [
            ElogirAccordion(
              title: const Text('What is Soft Industrial?'),
              body: const Text(
                'A design language defined by thick borders, warm neutrals, '
                'generous spacing, and measured typography. Depth comes from '
                'borders and layering rather than shadows.',
              ),
              initiallyExpanded: true,
            ),
            ElogirAccordion(
              title: const Text('Why no Material imports?'),
              body: const Text(
                'Every widget is built from Flutter primitives — '
                'GestureDetector, FocusableActionDetector, AnimatedContainer, '
                'EditableText. This gives full control over styling and behavior.',
              ),
            ),
            ElogirAccordion(
              title: const Text('How do I use it?'),
              body: const Text(
                'Add elogir_ui as a dependency, wrap your app in ElogirApp, '
                'and use the widgets. Customize via ElogirThemeData.',
              ),
            ),
          ],
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Tooltip')),
        SizedBox(height: theme.spacing.md),
        Wrap(
          spacing: theme.spacing.md,
          runSpacing: theme.spacing.sm,
          children: [
            ElogirTooltip(
              message: 'This is a tooltip above',
              child: ElogirButton(
                variant: ElogirButtonVariant.outlined,
                size: ElogirButtonSize.sm,
                onPressed: () {},
                child: const Text('Hover me'),
              ),
            ),
            ElogirTooltip(
              message: 'Tooltip below the button',
              position: ElogirTooltipPosition.below,
              child: ElogirButton(
                variant: ElogirButtonVariant.ghost,
                size: ElogirButtonSize.sm,
                onPressed: () {},
                child: const Text('Below tooltip'),
              ),
            ),
          ],
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Toast & Card & Dialog')),
        SizedBox(height: theme.spacing.md),
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          children: [
            ElogirButton(
              size: ElogirButtonSize.sm,
              onPressed: () => ElogirToast.show(
                context: context,
                message: 'This is an info toast',
              ),
              child: const Text('Info Toast'),
            ),
            ElogirButton(
              size: ElogirButtonSize.sm,
              variant: ElogirButtonVariant.outlined,
              onPressed: () => ElogirToast.show(
                context: context,
                message: 'Operation completed!',
                variant: ElogirToastVariant.success,
              ),
              child: const Text('Success Toast'),
            ),
            ElogirButton(
              size: ElogirButtonSize.sm,
              variant: ElogirButtonVariant.outlined,
              onPressed: () => ElogirToast.show(
                context: context,
                message: 'Check your input',
                variant: ElogirToastVariant.warning,
              ),
              child: const Text('Warning Toast'),
            ),
            ElogirButton(
              size: ElogirButtonSize.sm,
              variant: ElogirButtonVariant.ghost,
              onPressed: () => ElogirToast.show(
                context: context,
                message: 'Something went wrong',
                variant: ElogirToastVariant.error,
              ),
              child: const Text('Error Toast'),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.md),
        ElogirCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElogirText('Card Title', variant: ElogirTextVariant.titleMedium),
              SizedBox(height: theme.spacing.xs),
              ElogirText(
                'This is a card built entirely from Flutter primitives. '
                'No Material, no Cupertino — just the Soft Industrial style.',
              ),
              SizedBox(height: theme.spacing.md),
              ElogirButton(
                variant: ElogirButtonVariant.outlined,
                size: ElogirButtonSize.sm,
                onPressed: () {
                  ElogirDialog.show(
                    context: context,
                    builder: (_) => ElogirDialog(
                      title: const Text('Hello'),
                      content: const Text(
                        'This dialog is built from Flutter primitives with '
                        'the Soft Industrial style.',
                      ),
                      actions: [
                        ElogirButton(
                          variant: ElogirButtonVariant.ghost,
                          size: ElogirButtonSize.sm,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        ElogirButton(
                          size: ElogirButtonSize.sm,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ],
          ),
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Drawer & Bottom Sheet')),
        SizedBox(height: theme.spacing.md),
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          children: [
            ElogirButton(
              size: ElogirButtonSize.sm,
              onPressed: () {
                ElogirDrawer.show(
                  context: context,
                  position: ElogirDrawerPosition.left,
                  builder: (_) => Padding(
                    padding: EdgeInsets.all(theme.spacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElogirText('Drawer',
                            variant: ElogirTextVariant.titleLarge),
                        SizedBox(height: theme.spacing.md),
                        ElogirText('This drawer slides in from the left.'),
                        SizedBox(height: theme.spacing.lg),
                        ElogirButton(
                          size: ElogirButtonSize.sm,
                          variant: ElogirButtonVariant.outlined,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Left Drawer'),
            ),
            ElogirButton(
              size: ElogirButtonSize.sm,
              variant: ElogirButtonVariant.outlined,
              onPressed: () {
                ElogirDrawer.show(
                  context: context,
                  position: ElogirDrawerPosition.right,
                  builder: (_) => Padding(
                    padding: EdgeInsets.all(theme.spacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElogirText('Right Drawer',
                            variant: ElogirTextVariant.titleLarge),
                        SizedBox(height: theme.spacing.md),
                        ElogirText('Slides in from the right side.'),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Right Drawer'),
            ),
            ElogirButton(
              size: ElogirButtonSize.sm,
              variant: ElogirButtonVariant.ghost,
              onPressed: () {
                ElogirBottomSheet.show(
                  context: context,
                  builder: (_) => Padding(
                    padding: EdgeInsets.all(theme.spacing.lg),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElogirText('Bottom Sheet',
                            variant: ElogirTextVariant.titleLarge),
                        SizedBox(height: theme.spacing.sm),
                        ElogirText('Drag down to dismiss, or tap the scrim.'),
                        SizedBox(height: theme.spacing.md),
                        ElogirTextField(
                          label: 'Quick note',
                          hint: 'Type something…',
                        ),
                        SizedBox(height: theme.spacing.md),
                        ElogirButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Done'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Bottom Sheet'),
            ),
          ],
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Popover')),
        SizedBox(height: theme.spacing.md),
        ElogirPopover(
          key: _popoverKey,
          anchor: ElogirButton(
            size: ElogirButtonSize.sm,
            variant: ElogirButtonVariant.outlined,
            onPressed: () => _popoverKey.currentState?.toggle(),
            child: const Text('Toggle Popover'),
          ),
          content: (context) => Padding(
            padding: EdgeInsets.all(theme.spacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElogirText('Popover Content',
                    variant: ElogirTextVariant.titleSmall),
                SizedBox(height: theme.spacing.xs),
                ElogirText(
                    'This can contain any widget — forms, lists, etc.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
