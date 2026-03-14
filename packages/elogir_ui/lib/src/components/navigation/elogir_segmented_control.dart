import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// A segment within an [ElogirSegmentedControl].
class ElogirSegment<T> {
  const ElogirSegment({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final Widget? icon;
}

/// A pill-style segmented toggle group with animated selection indicator.
///
/// Soft Industrial style: thick border around the container, solid fill
/// for the selected segment that slides between options.
class ElogirSegmentedControl<T> extends StatelessWidget {
  const ElogirSegmentedControl({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
    this.enabled = true,
  });

  final List<ElogirSegment<T>> segments;
  final T selected;
  final ValueChanged<T> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final selectedIndex =
        segments.indexWhere((s) => s.value == selected).clamp(0, segments.length - 1);

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: theme.radii.md,
        border: Border.all(
          color: colors.outlineVariant,
          width: theme.strokes.thick,
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / segments.length;

          return Stack(
            children: [
              // Animated selection indicator
              AnimatedPositioned(
                duration: theme.durations.normal,
                curve: Curves.easeOutCubic,
                left: selectedIndex * segmentWidth,
                top: 0,
                bottom: 0,
                width: segmentWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.all(
                        Radius.circular(
                          (theme.radii.md.topLeft.x - 4).clamp(0, double.infinity),
                        ),
                      ),
                  ),
                ),
              ),
              // Segments
              Row(
                children: segments.map((segment) {
                  final isSelected = segment.value == selected;
                  return Expanded(
                    child: ElogirPressable(
                      enabled: enabled,
                      onPressed: () => onChanged(segment.value),
                      pressScale: 0.98,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: theme.spacing.sm,
                          horizontal: theme.spacing.sm,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (segment.icon != null) ...[
                              IconTheme(
                                data: IconThemeData(
                                  color: isSelected
                                      ? colors.onPrimary
                                      : colors.onSurfaceVariant,
                                  size: 16,
                                ),
                                child: segment.icon!,
                              ),
                              SizedBox(width: theme.spacing.xs),
                            ],
                            Text(
                              segment.label,
                              style: theme.typography.labelMedium.copyWith(
                                color: isSelected
                                    ? colors.onPrimary
                                    : colors.onSurfaceVariant,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
