import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

class AdvancedSection extends StatefulWidget {
  const AdvancedSection({super.key});

  @override
  State<AdvancedSection> createState() => _AdvancedSectionState();
}

class _AdvancedSectionState extends State<AdvancedSection> {
  final _listKey = GlobalKey<ElogirAnimatedListState>();
  final _items = ['First item', 'Second item', 'Third item'];
  int _counter = 3;

  void _addItem() {
    _counter++;
    final index = _items.length;
    _items.add('Item #$_counter');
    _listKey.currentState?.insertItem(index);
  }

  void _removeItem(int index) {
    final removed = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) {
        final t = ElogirTheme.of(context);
        return Padding(
          padding: EdgeInsets.only(bottom: t.spacing.sm),
          child: ElogirCard(
            child: Row(
              children: [
                Expanded(child: ElogirText(removed)),
                Text(
                  'tap to remove',
                  style: t.typography.caption.copyWith(
                    color: t.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElogirDivider(label: ElogirText('Command Palette')),
        SizedBox(height: theme.spacing.md),
        ElogirButton(
          size: ElogirButtonSize.sm,
          onPressed: () {
            ElogirCommandPalette.show(
              context: context,
              actions: [
                ElogirCommandAction(
                  label: 'Go to Dashboard',
                  group: 'Navigation',
                  shortcutLabel: '⌘D',
                  onAction: () {},
                ),
                ElogirCommandAction(
                  label: 'Open Settings',
                  group: 'Navigation',
                  shortcutLabel: '⌘,',
                  onAction: () {},
                ),
                ElogirCommandAction(
                  label: 'Search Users',
                  group: 'Navigation',
                  onAction: () {},
                ),
                ElogirCommandAction(
                  label: 'Toggle Dark Mode',
                  group: 'Appearance',
                  shortcutLabel: '⌘T',
                  keywords: ['theme', 'light', 'dark'],
                  onAction: () {},
                ),
                ElogirCommandAction(
                  label: 'Increase Font Size',
                  group: 'Appearance',
                  onAction: () {},
                ),
                ElogirCommandAction(
                  label: 'Export Data',
                  group: 'Actions',
                  shortcutLabel: '⌘E',
                  onAction: () {},
                ),
                ElogirCommandAction(
                  label: 'Clear Cache',
                  group: 'Actions',
                  onAction: () {},
                ),
              ],
            );
          },
          child: const Text('Open Command Palette'),
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Animated List')),
        SizedBox(height: theme.spacing.md),
        Row(
          children: [
            ElogirButton(
              size: ElogirButtonSize.sm,
              onPressed: _addItem,
              child: const Text('Add Item'),
            ),
            SizedBox(width: theme.spacing.sm),
            ElogirButton(
              size: ElogirButtonSize.sm,
              variant: ElogirButtonVariant.outlined,
              onPressed: _items.isNotEmpty
                  ? () => _removeItem(_items.length - 1)
                  : null,
              child: const Text('Remove Last'),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.sm),
        ElogirAnimatedList(
          key: _listKey,
          initialItemCount: _items.length,
          staggerDelay: const Duration(milliseconds: 80),
          itemBuilder: (context, index, animation) {
            return Padding(
              padding: EdgeInsets.only(bottom: theme.spacing.sm),
              child: ElogirPressable(
                onPressed: () => _removeItem(index),
                pressScale: 0.98,
                child: ElogirCard(
                  child: Row(
                    children: [
                      Expanded(child: ElogirText(_items[index])),
                      Text(
                        'tap to remove',
                        style: theme.typography.caption.copyWith(
                          color: theme.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Page Transitions')),
        SizedBox(height: theme.spacing.md),
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          children: [
            for (final entry in [
              ('Fade', ElogirTransitionType.fade),
              ('Slide Right', ElogirTransitionType.slideRight),
              ('Slide Up', ElogirTransitionType.slideUp),
              ('Scale', ElogirTransitionType.scale),
              ('Fade Scale', ElogirTransitionType.fadeScale),
            ])
              ElogirButton(
                size: ElogirButtonSize.sm,
                variant: ElogirButtonVariant.outlined,
                onPressed: () {
                  Navigator.of(context).push(
                    ElogirPageTransition(
                      page: _DemoPage(transitionName: entry.$1),
                      type: entry.$2,
                    ),
                  );
                },
                child: Text(entry.$1),
              ),
          ],
        ),
      ],
    );
  }
}

class _DemoPage extends StatelessWidget {
  const _DemoPage({required this.transitionName});

  final String transitionName;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirScaffold(
      appBar: ElogirAppBar(
        leading: ElogirButton(
          variant: ElogirButtonVariant.ghost,
          size: ElogirButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('← Back'),
        ),
        title: ElogirText(
          '$transitionName Transition',
          variant: ElogirTextVariant.titleMedium,
        ),
      ),
      body: Center(
        child: ElogirCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElogirText(
                'Page arrived via $transitionName',
                variant: ElogirTextVariant.titleMedium,
              ),
              SizedBox(height: theme.spacing.md),
              ElogirButton(
                size: ElogirButtonSize.sm,
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
