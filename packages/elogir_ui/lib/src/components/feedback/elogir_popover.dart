import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../../theme/theme_data.dart';

/// Preferred position for the popover relative to the anchor.
enum ElogirPopoverPosition { above, below, left, right }

/// An anchored floating panel with arbitrary content.
///
/// Unlike [ElogirTooltip] which shows a text message, a popover can
/// contain any widget — forms, lists, menus, etc.
///
/// Shown by calling [ElogirPopoverState.show] or [ElogirPopoverState.toggle]
/// via a GlobalKey.
class ElogirPopover extends StatefulWidget {
  const ElogirPopover({
    super.key,
    required this.anchor,
    required this.content,
    this.position = ElogirPopoverPosition.below,
    this.width,
    this.barrierDismissible = true,
  });

  final Widget anchor;
  final WidgetBuilder content;
  final ElogirPopoverPosition position;
  final double? width;
  final bool barrierDismissible;

  @override
  State<ElogirPopover> createState() => ElogirPopoverState();
}

class ElogirPopoverState extends State<ElogirPopover>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  OverlayEntry? _barrierEntry;
  late final AnimationController _fadeController;
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;

  bool get isOpen => _isOpen;

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
    hide();
    _fadeController.dispose();
    super.dispose();
  }

  void toggle() {
    if (_isOpen) {
      hide();
    } else {
      show();
    }
  }

  void show() {
    if (_isOpen) return;
    _isOpen = true;

    final overlay = Overlay.of(context);

    if (widget.barrierDismissible) {
      _barrierEntry = OverlayEntry(
        builder: (_) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: hide,
          child: const SizedBox.expand(),
        ),
      );
      overlay.insert(_barrierEntry!);
    }

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final theme = ElogirTheme.of(context);
        return _PopoverOverlay(
          link: _layerLink,
          position: widget.position,
          fadeAnimation: _fadeController,
          theme: theme,
          width: widget.width,
          content: widget.content,
        );
      },
    );
    overlay.insert(_overlayEntry!);
    _fadeController.forward();
  }

  void hide() {
    if (!_isOpen) return;
    _isOpen = false;
    _fadeController.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _barrierEntry?.remove();
      _barrierEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.anchor,
    );
  }
}

class _PopoverOverlay extends StatelessWidget {
  const _PopoverOverlay({
    required this.link,
    required this.position,
    required this.fadeAnimation,
    required this.theme,
    required this.content,
    this.width,
  });

  final LayerLink link;
  final ElogirPopoverPosition position;
  final AnimationController fadeAnimation;
  final ElogirThemeData theme;
  final WidgetBuilder content;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final Offset offset;
    final Alignment targetAnchor;
    final Alignment followerAnchor;

    switch (position) {
      case ElogirPopoverPosition.above:
        offset = const Offset(0, -8);
        targetAnchor = Alignment.topLeft;
        followerAnchor = Alignment.bottomLeft;
      case ElogirPopoverPosition.below:
        offset = const Offset(0, 8);
        targetAnchor = Alignment.bottomLeft;
        followerAnchor = Alignment.topLeft;
      case ElogirPopoverPosition.left:
        offset = const Offset(-8, 0);
        targetAnchor = Alignment.centerLeft;
        followerAnchor = Alignment.centerRight;
      case ElogirPopoverPosition.right:
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
            width: width,
            constraints: width == null
                ? const BoxConstraints(maxWidth: 320)
                : null,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: theme.radii.md,
              border: Border.all(
                color: colors.outline,
                width: theme.strokes.thick,
              ),
            ),
            child: content(context),
          ),
        ),
      ),
    );
  }
}
