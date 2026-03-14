import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A small count or dot indicator that attaches to the corner of another widget.
class ElogirBadge extends StatefulWidget {
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

  @override
  State<ElogirBadge> createState() => _ElogirBadgeState();
}

class _ElogirBadgeState extends State<ElogirBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
      value: 1.0,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  @override
  void didUpdateWidget(ElogirBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count != oldWidget.count) {
      _scaleController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  bool get _visible => widget.showDot || (widget.count != null && widget.count! > 0);

  @override
  Widget build(BuildContext context) {
    if (!_visible) return widget.child;

    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final bg = widget.color ?? colors.error;
    final fg = widget.textColor ?? colors.onError;

    final Offset effectiveOffset;
    if (widget.offset != null) {
      effectiveOffset = widget.offset!;
    } else if (widget.alignment == Alignment.topRight) {
      effectiveOffset = const Offset(6, -6);
    } else if (widget.alignment == Alignment.topLeft) {
      effectiveOffset = const Offset(-6, -6);
    } else {
      effectiveOffset = const Offset(6, 6);
    }

    Widget badge;
    if (widget.showDot) {
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
          widget.count! > widget.maxCount ? '${widget.maxCount}+' : widget.count.toString();
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
        widget.child,
        Positioned(
          top: widget.alignment.y <= 0 ? effectiveOffset.dy : null,
          bottom: widget.alignment.y > 0 ? effectiveOffset.dy : null,
          right: widget.alignment.x >= 0 ? effectiveOffset.dx * -1 : null,
          left: widget.alignment.x < 0 ? effectiveOffset.dx * -1 : null,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: badge,
          ),
        ),
      ],
    );
  }
}
