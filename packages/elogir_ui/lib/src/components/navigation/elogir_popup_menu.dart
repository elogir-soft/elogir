import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/theme.dart';
import '../../theme/theme_data.dart';
import '../buttons/elogir_icon_button.dart';
import '../interaction/elogir_pressable.dart';

/// A single item in an [ElogirPopupMenu].
class ElogirPopupMenuItem {
  const ElogirPopupMenuItem({
    required this.label,
    required this.onPressed,
    this.icon,
  });

  /// Display label for this item.
  final String label;

  /// Callback when the item is tapped.
  final VoidCallback onPressed;

  /// Optional leading icon.
  final Widget? icon;
}

/// A three-dot overflow popup menu with Soft Industrial styling.
///
/// Drops a right-aligned overlay below the anchor button. Uses the same
/// overlay pattern as [ElogirDropdown]: barrier dismissal, fade animation,
/// and [CompositedTransformFollower] positioning.
class ElogirPopupMenu extends StatefulWidget {
  const ElogirPopupMenu({
    super.key,
    required this.items,
    this.anchor,
    this.width = 180,
  });

  /// The menu items to display.
  final List<ElogirPopupMenuItem> items;

  /// Custom anchor widget. Defaults to a three-dot [ElogirIconButton].
  final Widget? anchor;

  /// Width of the popup overlay.
  final double width;

  @override
  State<ElogirPopupMenu> createState() => _ElogirPopupMenuState();
}

class _ElogirPopupMenuState extends State<ElogirPopupMenu>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  OverlayEntry? _barrierEntry;
  late final AnimationController _fadeController;
  bool _isOpen = false;

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
    _close();
    _fadeController.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_isOpen) {
      _close();
    } else {
      _open();
    }
  }

  void _open() {
    if (_isOpen) return;
    _isOpen = true;

    final overlay = Overlay.of(context);

    _barrierEntry = OverlayEntry(
      builder: (_) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _close,
        child: const SizedBox.expand(),
      ),
    );
    overlay.insert(_barrierEntry!);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final theme = ElogirTheme.of(context);
        return _PopupMenuOverlay(
          link: _layerLink,
          fadeAnimation: _fadeController,
          theme: theme,
          items: widget.items,
          width: widget.width,
          onItemPressed: (item) {
            _close(immediate: true);
            item.onPressed();
          },
        );
      },
    );
    overlay.insert(_overlayEntry!);
    _fadeController.forward();
    setState(() {});
  }

  void _close({bool immediate = false}) {
    if (!_isOpen) return;
    _isOpen = false;
    if (immediate) {
      _fadeController.reset();
      _overlayEntry?.remove();
      _overlayEntry = null;
      _barrierEntry?.remove();
      _barrierEntry = null;
    } else {
      _fadeController.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _barrierEntry?.remove();
        _barrierEntry = null;
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.anchor != null
          ? GestureDetector(onTap: _toggle, child: widget.anchor)
          : ElogirIconButton(
              onPressed: _toggle,
              icon: const FaIcon(FontAwesomeIcons.ellipsisVertical, size: 18),
            ),
    );
  }
}

class _PopupMenuOverlay extends StatelessWidget {
  const _PopupMenuOverlay({
    required this.link,
    required this.fadeAnimation,
    required this.theme,
    required this.items,
    required this.width,
    required this.onItemPressed,
  });

  final LayerLink link;
  final AnimationController fadeAnimation;
  final ElogirThemeData theme;
  final List<ElogirPopupMenuItem> items;
  final double width;
  final ValueChanged<ElogirPopupMenuItem> onItemPressed;

  @override
  Widget build(BuildContext context) {
    final colors = theme.colors;

    return Positioned(
      left: 0,
      top: 0,
      child: CompositedTransformFollower(
        link: link,
        offset: const Offset(0, 4),
        targetAnchor: Alignment.bottomRight,
        followerAnchor: Alignment.topRight,
        showWhenUnlinked: false,
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: fadeAnimation,
            curve: Curves.easeOut,
          ),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: theme.radii.md,
              border: Border.all(
                color: colors.outline,
                width: theme.strokes.thick,
              ),
            ),
            child: ClipRRect(
              borderRadius: theme.radii.md,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: theme.spacing.xs),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final item in items)
                      _PopupMenuItemWidget(
                        item: item,
                        theme: theme,
                        onPressed: () => onItemPressed(item),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PopupMenuItemWidget extends StatefulWidget {
  const _PopupMenuItemWidget({
    required this.item,
    required this.theme,
    required this.onPressed,
  });

  final ElogirPopupMenuItem item;
  final ElogirThemeData theme;
  final VoidCallback onPressed;

  @override
  State<_PopupMenuItemWidget> createState() => _PopupMenuItemWidgetState();
}

class _PopupMenuItemWidgetState extends State<_PopupMenuItemWidget> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.theme.colors;

    return ElogirPressable(
      onPressed: widget.onPressed,
      onHoverChanged: (v) => setState(() => _hovered = v),
      onPressChanged: (v) => setState(() => _pressed = v),
      pressScale: 0.98,
      child: AnimatedContainer(
        duration: widget.theme.durations.fast,
        padding: EdgeInsets.symmetric(
          horizontal: widget.theme.spacing.md,
          vertical: widget.theme.spacing.sm + widget.theme.spacing.xxs,
        ),
        color: _pressed || _hovered
            ? colors.surfaceContainer
            : colors.surface,
        child: Row(
          children: [
            if (widget.item.icon != null) ...[
              IconTheme(
                data: IconThemeData(
                  color: colors.onSurfaceVariant,
                  size: 16,
                ),
                child: widget.item.icon!,
              ),
              SizedBox(width: widget.theme.spacing.sm),
            ],
            Expanded(
              child: Text(
                widget.item.label,
                style: widget.theme.typography.bodyMedium.copyWith(
                  color: colors.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
