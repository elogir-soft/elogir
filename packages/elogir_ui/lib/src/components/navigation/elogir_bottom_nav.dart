import 'dart:ui' show ImageFilter;
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

/// A mobile bottom navigation bar with a unique floating glass pill design.
///
/// Features:
/// - Floating design with generous margins
/// - Glassmorphism (BackdropFilter blur)
/// - Sliding solid background pill for the active item
/// - Scale-bump animations on selection
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

    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final horizontalPadding = theme.spacing.lg;
    final verticalMargin = theme.spacing.md;

    final outerRadius = theme.radii.xl.topLeft.x + 12;
    final indicatorPadding = theme.spacing.sm;
    final innerRadius = outerRadius - indicatorPadding;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        0,
        horizontalPadding,
        bottomPadding > 0 ? bottomPadding : verticalMargin,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(outerRadius)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            height: 80, // Increased height for better vertical breathing room
            decoration: BoxDecoration(
              color: colors.surface.withOpacity(0.85),
              borderRadius: BorderRadius.all(Radius.circular(outerRadius)),
              border: Border.all(
                color: colors.outlineVariant,
                width: theme.strokes.thick,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth / items.length;
                final pillHeight = 56.0; // Slightly taller pill to comfortably fit content
                final pillTop = (constraints.maxHeight - pillHeight) / 2;

                return Stack(
                  children: [
                    // Sliding active background pill
                    AnimatedPositioned(
                      duration: theme.durations.normal,
                      curve: Curves.easeOutCubic,
                      left: clampedIndex * itemWidth + indicatorPadding,
                      top: pillTop,
                      width: itemWidth - (indicatorPadding * 2),
                      height: pillHeight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          borderRadius: BorderRadius.all(Radius.circular(innerRadius)),
                        ),
                      ),
                    ),
                    // Items
                    Positioned.fill(
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
        tween: Tween(begin: 1.0, end: 1.1)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.1, end: 1.0)
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

    final color = widget.isSelected
        ? colors.onPrimaryContainer
        : colors.onSurfaceVariant;
    final iconWidget = widget.isSelected
        ? (widget.item.activeIcon ?? widget.item.icon)
        : widget.item.icon;

    return ElogirPressable(
      enabled: widget.enabled,
      onPressed: widget.onPressed,
      pressScale: 0.96,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                );
              },
              child: AnimatedDefaultTextStyle(
                duration: theme.durations.normal,
                curve: Curves.easeOutCubic,
                style: TextStyle(color: color),
                child: IconTheme(
                  data: IconThemeData(color: color, size: 24),
                  child: iconWidget,
                ),
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: theme.durations.normal,
              curve: Curves.easeOutCubic,
              style: theme.typography.labelSmall.copyWith(
                color: color,
                fontSize: 10,
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
