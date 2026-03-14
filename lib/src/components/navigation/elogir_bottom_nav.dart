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

class _BottomNavItemWidget extends StatefulWidget {
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
  State<_BottomNavItemWidget> createState() => _BottomNavItemWidgetState();
}

class _BottomNavItemWidgetState extends State<_BottomNavItemWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 60,
      ),
    ]).animate(_scaleController);
  }

  @override
  void didUpdateWidget(_BottomNavItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _scaleController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    final color =
        widget.isSelected ? colors.primary : colors.onSurfaceVariant;
    final iconWidget = widget.isSelected
        ? (widget.item.activeIcon ?? widget.item.icon)
        : widget.item.icon;

    return ElogirPressable(
      enabled: widget.enabled,
      onPressed: widget.onPressed,
      pressScale: 0.95,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: theme.spacing.xs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                );
              },
              child: IconTheme(
                data: IconThemeData(color: color, size: 22),
                child: iconWidget,
              ),
            ),
            SizedBox(height: theme.spacing.xs),
            AnimatedDefaultTextStyle(
              duration: theme.durations.fast,
              style: theme.typography.labelSmall.copyWith(
                color: color,
                fontWeight:
                    widget.isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
              child: Text(widget.item.label),
            ),
          ],
        ),
      ),
    );
  }
}
