import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A small count or dot indicator that attaches to the corner of another widget.
class ElogirBadge extends StatelessWidget {
  const ElogirBadge({
    super.key,
    required this.child,
    this.count,
    this.showDot = false,
    this.maxCount = 99,
    this.color,
    this.textColor,
    this.alignment = Alignment.topRight,
    this.offset,
  });

  /// The widget to attach the badge to.
  final Widget child;

  /// Optional count to display. If null and [showDot] is false, no badge shown.
  final int? count;

  /// Show a small dot instead of a count.
  final bool showDot;

  /// Maximum count before showing "99+".
  final int maxCount;

  final Color? color;
  final Color? textColor;
  final Alignment alignment;
  final Offset? offset;

  bool get _visible => showDot || (count != null && count! > 0);

  @override
  Widget build(BuildContext context) {
    if (!_visible) return child;

    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final bg = color ?? colors.error;
    final fg = textColor ?? colors.onError;

    final Offset effectiveOffset;
    if (offset != null) {
      effectiveOffset = offset!;
    } else if (alignment == Alignment.topRight) {
      effectiveOffset = const Offset(6, -6);
    } else if (alignment == Alignment.topLeft) {
      effectiveOffset = const Offset(-6, -6);
    } else {
      effectiveOffset = const Offset(6, 6);
    }

    Widget badge;
    if (showDot) {
      badge = Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: Border.all(
            color: colors.surface,
            width: theme.strokes.medium,
          ),
        ),
      );
    } else {
      final label =
          count! > maxCount ? '$maxCount+' : count.toString();
      badge = Container(
        constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: theme.radii.full,
          border: Border.all(
            color: colors.surface,
            width: theme.strokes.medium,
          ),
        ),
        child: Center(
          widthFactor: 1,
          child: Text(
            label,
            style: theme.typography.caption.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: alignment.y <= 0 ? effectiveOffset.dy : null,
          bottom: alignment.y > 0 ? effectiveOffset.dy : null,
          right: alignment.x >= 0 ? effectiveOffset.dx * -1 : null,
          left: alignment.x < 0 ? effectiveOffset.dx * -1 : null,
          child: badge,
        ),
      ],
    );
  }
}
