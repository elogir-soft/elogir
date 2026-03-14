import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// A single item in the bottom navigation bar.
class ElogirBottomNavItem {
  const ElogirBottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });

  final Widget icon;
  final String label;

  /// Alternate icon shown when this item is selected.
  /// Falls back to [icon] if not provided.
  final Widget? activeIcon;
}

/// A mobile bottom navigation bar with animated selection.
///
/// Soft Industrial style: thick top border with a sliding active
/// indicator segment, bold label on the selected item.
class ElogirBottomNav extends StatelessWidget {
  const ElogirBottomNav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    this.enabled = true,
  });

  final List<ElogirBottomNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final clampedIndex = selectedIndex.clamp(0, items.length - 1);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(
            color: colors.outlineVariant,
            width: theme.strokes.thick,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / items.length;

            return Stack(
              children: [
                // Sliding active indicator at top
                AnimatedPositioned(
                  duration: theme.durations.normal,
                  curve: Curves.easeOutCubic,
                  left: clampedIndex * itemWidth + itemWidth * 0.2,
                  top: 0,
                  width: itemWidth * 0.6,
                  height: theme.strokes.thick,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                      ),
                    ),
                  ),
                ),
                // Items
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: theme.spacing.sm,
                    horizontal: theme.spacing.sm,
                  ),
                  child: Row(
                    children: [
                      for (int i = 0; i < items.length; i++)
                        Expanded(
                          child: _BottomNavItemWidget(
                            item: items[i],
                            isSelected: i == clampedIndex,
                            enabled: enabled,
                            onPressed: () => onChanged(i),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BottomNavItemWidget extends StatelessWidget {
  const _BottomNavItemWidget({
    required this.item,
    required this.isSelected,
    required this.enabled,
    required this.onPressed,
  });

  final ElogirBottomNavItem item;
  final bool isSelected;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    final color = isSelected ? colors.primary : colors.onSurfaceVariant;
    final iconWidget =
        isSelected ? (item.activeIcon ?? item.icon) : item.icon;

    return ElogirPressable(
      enabled: enabled,
      onPressed: onPressed,
      pressScale: 0.95,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: theme.spacing.xs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme(
              data: IconThemeData(color: color, size: 22),
              child: iconWidget,
            ),
            SizedBox(height: theme.spacing.xs),
            AnimatedDefaultTextStyle(
              duration: theme.durations.fast,
              style: theme.typography.labelSmall.copyWith(
                color: color,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}
