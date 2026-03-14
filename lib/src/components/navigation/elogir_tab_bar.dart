import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// A single tab item.
class ElogirTab {
  const ElogirTab({required this.label, this.icon});

  final String label;
  final Widget? icon;
}

/// Style of the active tab indicator.
enum ElogirTabIndicatorStyle { underline, pill }

/// A tab strip with an animated indicator that slides between tabs.
///
/// Soft Industrial style: thick underline or filled pill indicator
/// with smooth horizontal animation between selections.
class ElogirTabBar extends StatelessWidget {
  const ElogirTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    this.indicatorStyle = ElogirTabIndicatorStyle.underline,
    this.isScrollable = false,
    this.enabled = true,
  });

  final List<ElogirTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final ElogirTabIndicatorStyle indicatorStyle;
  final bool isScrollable;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final clampedIndex = selectedIndex.clamp(0, tabs.length - 1);

    if (isScrollable) {
      return _ScrollableTabBar(
        tabs: tabs,
        selectedIndex: clampedIndex,
        onChanged: onChanged,
        indicatorStyle: indicatorStyle,
        enabled: enabled,
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: indicatorStyle == ElogirTabIndicatorStyle.underline
            ? Border(
                bottom: BorderSide(
                  color: colors.outlineVariant,
                  width: theme.strokes.thick,
                ),
              )
            : null,
        color: indicatorStyle == ElogirTabIndicatorStyle.pill
            ? colors.surfaceContainer
            : null,
        borderRadius: indicatorStyle == ElogirTabIndicatorStyle.pill
            ? theme.radii.md
            : null,
      ),
      padding: indicatorStyle == ElogirTabIndicatorStyle.pill
          ? const EdgeInsets.all(3)
          : null,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / tabs.length;

          return Stack(
            children: [
              // Animated indicator
              if (indicatorStyle == ElogirTabIndicatorStyle.underline)
                Positioned(
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: theme.durations.normal,
                    curve: Curves.easeOutCubic,
                    width: tabWidth,
                    height: theme.strokes.thick,
                    margin: EdgeInsets.only(left: clampedIndex * tabWidth),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: theme.radii.full,
                    ),
                  ),
                )
              else
                AnimatedPositioned(
                  duration: theme.durations.normal,
                  curve: Curves.easeOutCubic,
                  left: clampedIndex * tabWidth,
                  top: 0,
                  bottom: 0,
                  width: tabWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          (theme.radii.md.topLeft.x - 3).clamp(0, double.infinity),
                        ),
                      ),
                      border: Border.all(
                        color: colors.outlineVariant,
                        width: theme.strokes.thin,
                      ),
                    ),
                  ),
                ),
              // Tab items
              Row(
                children: [
                  for (int i = 0; i < tabs.length; i++)
                    Expanded(
                      child: _TabItem(
                        tab: tabs[i],
                        isSelected: i == clampedIndex,
                        indicatorStyle: indicatorStyle,
                        enabled: enabled,
                        onPressed: () => onChanged(i),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ScrollableTabBar extends StatelessWidget {
  const _ScrollableTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    required this.indicatorStyle,
    required this.enabled,
  });

  final List<ElogirTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final ElogirTabIndicatorStyle indicatorStyle;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant,
            width: theme.strokes.thick,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < tabs.length; i++)
              _TabItem(
                tab: tabs[i],
                isSelected: i == selectedIndex,
                indicatorStyle: indicatorStyle,
                enabled: enabled,
                onPressed: () => onChanged(i),
                showUnderline: true,
              ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatefulWidget {
  const _TabItem({
    required this.tab,
    required this.isSelected,
    required this.indicatorStyle,
    required this.enabled,
    required this.onPressed,
    this.showUnderline = false,
  });

  final ElogirTab tab;
  final bool isSelected;
  final ElogirTabIndicatorStyle indicatorStyle;
  final bool enabled;
  final VoidCallback onPressed;
  final bool showUnderline;

  @override
  State<_TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<_TabItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    final color = widget.isSelected
        ? colors.primary
        : _hovered
            ? colors.onSurface
            : colors.onSurfaceVariant;

    return ElogirPressable(
      enabled: widget.enabled,
      onPressed: widget.onPressed,
      onHoverChanged: (v) => setState(() => _hovered = v),
      pressScale: 0.98,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.md,
          vertical: theme.spacing.sm + theme.spacing.xs,
        ),
        decoration: widget.showUnderline && widget.isSelected
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colors.primary,
                    width: theme.strokes.thick,
                  ),
                ),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.tab.icon != null) ...[
              IconTheme(
                data: IconThemeData(color: color, size: 18),
                child: widget.tab.icon!,
              ),
              SizedBox(width: theme.spacing.xs),
            ],
            Text(
              widget.tab.label,
              style: theme.typography.labelLarge.copyWith(
                color: color,
                fontWeight: widget.isSelected
                    ? FontWeight.w700
                    : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
