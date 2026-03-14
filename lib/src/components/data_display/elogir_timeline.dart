import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A single item in a timeline.
class ElogirTimelineItem {
  const ElogirTimelineItem({
    required this.title,
    this.subtitle,
    this.content,
    this.icon,
    this.dotColor,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? content;
  final Widget? icon;
  final Color? dotColor;
}

/// A vertical timeline showing a sequence of events with connectors.
///
/// Each item has a dot (or custom icon), a continuous connecting line,
/// and title/subtitle/content on the right side.
class ElogirTimeline extends StatelessWidget {
  const ElogirTimeline({
    super.key,
    required this.items,
    this.dotSize = 12.0,
    this.lineWidth,
    this.spacing,
  });

  final List<ElogirTimelineItem> items;
  final double dotSize;
  final double? lineWidth;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < items.length; i++)
          _ElogirTimelineEntry(
            item: items[i],
            isFirst: i == 0,
            isLast: i == items.length - 1,
            dotSize: dotSize,
            lineWidth: lineWidth,
            spacing: spacing ?? theme.spacing.md,
          ),
      ],
    );
  }
}

class _ElogirTimelineEntry extends StatelessWidget {
  const _ElogirTimelineEntry({
    required this.item,
    required this.isFirst,
    required this.isLast,
    required this.dotSize,
    required this.spacing,
    this.lineWidth,
  });

  final ElogirTimelineItem item;
  final bool isFirst;
  final bool isLast;
  final double dotSize;
  final double spacing;
  final double? lineWidth;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final effectiveLineWidth = lineWidth ?? theme.strokes.medium;
    final dotColor = item.dotColor ?? colors.primary;
    final railWidth = dotSize + theme.spacing.md;
    // Center dot with title text: titleSmall is 14px * 1.43 line height ≈ 20px
    final titleLineHeight = theme.typography.titleSmall.fontSize! *
        (theme.typography.titleSmall.height ?? 1.43);
    final dotOffset = (titleLineHeight - dotSize) / 2;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline rail: continuous line with dot overlaid
          SizedBox(
            width: railWidth,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Continuous vertical line
                Positioned(
                  top: isFirst ? dotOffset + dotSize / 2 : 0,
                  bottom: isLast ? null : 0,
                  width: effectiveLineWidth,
                  child: isLast
                      ? SizedBox(height: dotSize / 2)
                      : Container(color: colors.outlineVariant),
                ),
                // Dot or icon
                Positioned(
                  top: dotOffset,
                  child: item.icon != null
                      ? SizedBox(
                          width: dotSize,
                          height: dotSize,
                          child: item.icon,
                        )
                      : Container(
                          width: dotSize,
                          height: dotSize,
                          decoration: BoxDecoration(
                            color: dotColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : spacing,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextStyle.merge(
                    style: theme.typography.titleSmall.copyWith(
                      color: colors.onSurface,
                    ),
                    child: item.title,
                  ),
                  if (item.subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: DefaultTextStyle.merge(
                        style: theme.typography.caption.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                        child: item.subtitle!,
                      ),
                    ),
                  if (item.content != null)
                    Padding(
                      padding: EdgeInsets.only(top: theme.spacing.xs),
                      child: DefaultTextStyle.merge(
                        style: theme.typography.bodySmall.copyWith(
                          color: colors.onSurface,
                        ),
                        child: item.content!,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
