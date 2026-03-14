import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../../theme/theme_data.dart';

/// Preferred position for the tooltip relative to the target widget.
enum ElogirTooltipPosition { above, below, left, right }

/// A tooltip that shows a message on hover (desktop) or long press (mobile).
///
/// Positioned using an [Overlay] with an arrow pointing at the target.
class ElogirTooltip extends StatefulWidget {
  const ElogirTooltip({
    super.key,
    required this.message,
    required this.child,
    this.position = ElogirTooltipPosition.above,
    this.showDelay = const Duration(milliseconds: 400),
    this.hideDelay = const Duration(milliseconds: 100),
  });

  final String message;
  final Widget child;
  final ElogirTooltipPosition position;
  final Duration showDelay;
  final Duration hideDelay;

  @override
  State<ElogirTooltip> createState() => _ElogirTooltipState();
}

class _ElogirTooltipState extends State<ElogirTooltip>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late final AnimationController _fadeController;
  final LayerLink _layerLink = LayerLink();
  bool _mouseIsOver = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hideTooltip();
    _fadeController.dispose();
    super.dispose();
  }

  void _showTooltip() {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _fadeController.forward();
  }

  void _hideTooltip() {
    if (_overlayEntry == null) return;
    _fadeController.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  void _onHover(bool hovering) {
    _mouseIsOver = hovering;
    if (hovering) {
      Future.delayed(widget.showDelay, () {
        if (_mouseIsOver && mounted) _showTooltip();
      });
    } else {
      Future.delayed(widget.hideDelay, () {
        if (!_mouseIsOver && mounted) _hideTooltip();
      });
    }
  }

  void _onLongPress() {
    _showTooltip();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _hideTooltip();
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        final theme = ElogirTheme.of(context);
        return _TooltipOverlay(
          link: _layerLink,
          position: widget.position,
          fadeAnimation: _fadeController,
          theme: theme,
          message: widget.message,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: GestureDetector(
          onLongPress: _onLongPress,
          behavior: HitTestBehavior.translucent,
          child: widget.child,
        ),
      ),
    );
  }
}

class _TooltipOverlay extends StatelessWidget {
  const _TooltipOverlay({
    required this.link,
    required this.position,
    required this.fadeAnimation,
    required this.theme,
    required this.message,
  });

  final LayerLink link;
  final ElogirTooltipPosition position;
  final AnimationController fadeAnimation;
  final ElogirThemeData theme;
  final String message;

  @override
  Widget build(BuildContext context) {
    final Offset offset;
    final Alignment targetAnchor;
    final Alignment followerAnchor;

    switch (position) {
      case ElogirTooltipPosition.above:
        offset = const Offset(0, -8);
        targetAnchor = Alignment.topCenter;
        followerAnchor = Alignment.bottomCenter;
      case ElogirTooltipPosition.below:
        offset = const Offset(0, 8);
        targetAnchor = Alignment.bottomCenter;
        followerAnchor = Alignment.topCenter;
      case ElogirTooltipPosition.left:
        offset = const Offset(-8, 0);
        targetAnchor = Alignment.centerLeft;
        followerAnchor = Alignment.centerRight;
      case ElogirTooltipPosition.right:
        offset = const Offset(8, 0);
        targetAnchor = Alignment.centerRight;
        followerAnchor = Alignment.centerLeft;
    }

    final colors = theme.colors;

    return Positioned(
      left: 0,
      top: 0,
      child: CompositedTransformFollower(
        link: link,
        offset: offset,
        targetAnchor: targetAnchor,
        followerAnchor: followerAnchor,
        showWhenUnlinked: false,
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: fadeAnimation,
            curve: Curves.easeOut,
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 240),
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.sm + 4,
              vertical: theme.spacing.xs + 2,
            ),
            decoration: BoxDecoration(
              color: colors.onBackground,
              borderRadius: theme.radii.sm,
              border: Border.all(
                color: colors.outline,
                width: theme.strokes.thin,
              ),
            ),
            child: Text(
              message,
              style: theme.typography.caption.copyWith(
                color: colors.background,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
