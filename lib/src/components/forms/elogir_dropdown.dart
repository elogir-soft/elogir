import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../../theme/theme_data.dart';
import '../interaction/elogir_pressable.dart';

/// A single option in a dropdown.
class ElogirDropdownOption<T> {
  const ElogirDropdownOption({
    required this.value,
    required this.label,
    this.icon,
    this.enabled = true,
  });

  final T value;
  final String label;
  final Widget? icon;
  final bool enabled;
}

/// An overlay-based dropdown picker.
///
/// Soft Industrial style: thick-bordered trigger button, floating overlay
/// with border and no shadow, hover highlight on options.
class ElogirDropdown<T> extends StatefulWidget {
  const ElogirDropdown({
    super.key,
    required this.options,
    required this.onChanged,
    this.value,
    this.placeholder,
    this.enabled = true,
    this.width,
  });

  final List<ElogirDropdownOption<T>> options;
  final ValueChanged<T> onChanged;
  final T? value;
  final String? placeholder;
  final bool enabled;
  final double? width;

  @override
  State<ElogirDropdown<T>> createState() => _ElogirDropdownState<T>();
}

class _ElogirDropdownState<T> extends State<ElogirDropdown<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  OverlayEntry? _barrierEntry;
  late final AnimationController _fadeController;
  bool _isOpen = false;
  bool _hovered = false;

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
    final renderBox = context.findRenderObject() as RenderBox;
    final triggerWidth = renderBox.size.width;

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
        return _DropdownOverlay<T>(
          link: _layerLink,
          fadeAnimation: _fadeController,
          theme: theme,
          options: widget.options,
          selectedValue: widget.value,
          triggerWidth: widget.width ?? triggerWidth,
          onSelect: (value) {
            widget.onChanged(value);
            _close();
          },
        );
      },
    );
    overlay.insert(_overlayEntry!);
    _fadeController.forward();
    setState(() {});
  }

  void _close() {
    if (!_isOpen) return;
    _isOpen = false;
    _fadeController.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _barrierEntry?.remove();
      _barrierEntry = null;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final enabled = widget.enabled;

    // Find selected label
    final selectedOption = widget.options
        .where((o) => o.value == widget.value)
        .toList();
    final displayText = selectedOption.isNotEmpty
        ? selectedOption.first.label
        : (widget.placeholder ?? 'Select...');
    final isPlaceholder = selectedOption.isEmpty;

    return CompositedTransformTarget(
      link: _layerLink,
      child: ElogirPressable(
        enabled: enabled,
        onPressed: enabled ? _toggle : null,
        onHoverChanged: (v) => setState(() => _hovered = v),
        pressScale: 0.99,
        isButton: true,
        child: AnimatedContainer(
          duration: theme.durations.fast,
          width: widget.width,
          height: 44,
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: theme.radii.md,
            border: Border.all(
              color: _isOpen
                  ? colors.primary
                  : _hovered
                      ? colors.onSurfaceVariant
                      : colors.outline,
              width: theme.strokes.thick,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  displayText,
                  style: theme.typography.bodyMedium.copyWith(
                    color: isPlaceholder
                        ? colors.onSurfaceVariant
                        : (enabled ? colors.onSurface : colors.onDisabled),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: theme.spacing.sm),
              // Chevron
              AnimatedRotation(
                turns: _isOpen ? 0.5 : 0.0,
                duration: theme.durations.fast,
                child: CustomPaint(
                  size: const Size(12, 12),
                  painter: _ChevronPainter(
                    color: enabled
                        ? colors.onSurfaceVariant
                        : colors.onDisabled,
                    strokeWidth: theme.strokes.thick,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropdownOverlay<T> extends StatelessWidget {
  const _DropdownOverlay({
    required this.link,
    required this.fadeAnimation,
    required this.theme,
    required this.options,
    required this.selectedValue,
    required this.triggerWidth,
    required this.onSelect,
  });

  final LayerLink link;
  final AnimationController fadeAnimation;
  final ElogirThemeData theme;
  final List<ElogirDropdownOption<T>> options;
  final T? selectedValue;
  final double triggerWidth;
  final ValueChanged<T> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = theme.colors;

    return Positioned(
      left: 0,
      top: 0,
      child: CompositedTransformFollower(
        link: link,
        offset: const Offset(0, 4),
        targetAnchor: Alignment.bottomLeft,
        followerAnchor: Alignment.topLeft,
        showWhenUnlinked: false,
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: fadeAnimation,
            curve: Curves.easeOut,
          ),
          child: Container(
            width: triggerWidth,
            constraints: const BoxConstraints(maxHeight: 280),
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
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: theme.spacing.xs),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final option in options)
                      _DropdownOptionItem<T>(
                        option: option,
                        isSelected: option.value == selectedValue,
                        theme: theme,
                        onSelect: onSelect,
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

class _DropdownOptionItem<T> extends StatefulWidget {
  const _DropdownOptionItem({
    required this.option,
    required this.isSelected,
    required this.theme,
    required this.onSelect,
  });

  final ElogirDropdownOption<T> option;
  final bool isSelected;
  final ElogirThemeData theme;
  final ValueChanged<T> onSelect;

  @override
  State<_DropdownOptionItem<T>> createState() => _DropdownOptionItemState<T>();
}

class _DropdownOptionItemState<T> extends State<_DropdownOptionItem<T>> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.theme.colors;

    return ElogirPressable(
      enabled: widget.option.enabled,
      onPressed: () => widget.onSelect(widget.option.value),
      onHoverChanged: (v) => setState(() => _hovered = v),
      pressScale: 1.0,
      child: AnimatedContainer(
        duration: widget.theme.durations.fast,
        padding: EdgeInsets.symmetric(
          horizontal: widget.theme.spacing.md,
          vertical: widget.theme.spacing.sm + 2,
        ),
        color: widget.isSelected
            ? colors.primaryContainer
            : _hovered
                ? colors.surfaceContainer
                : colors.surface,
        child: Row(
          children: [
            if (widget.option.icon != null) ...[
              IconTheme(
                data: IconThemeData(
                  color: widget.isSelected
                      ? colors.onPrimaryContainer
                      : colors.onSurfaceVariant,
                  size: 18,
                ),
                child: widget.option.icon!,
              ),
              SizedBox(width: widget.theme.spacing.sm),
            ],
            Expanded(
              child: Text(
                widget.option.label,
                style: widget.theme.typography.bodyMedium.copyWith(
                  color: widget.option.enabled
                      ? (widget.isSelected
                          ? colors.onPrimaryContainer
                          : colors.onSurface)
                      : colors.onDisabled,
                  fontWeight: widget.isSelected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            ),
            // Check mark for selected
            if (widget.isSelected)
              CustomPaint(
                size: const Size(14, 14),
                painter: _CheckPainter(
                  color: colors.onPrimaryContainer,
                  strokeWidth: widget.theme.strokes.thick,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ChevronPainter extends CustomPainter {
  _ChevronPainter({
    required this.color,
    required this.strokeWidth,
  });

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.35)
      ..lineTo(size.width * 0.5, size.height * 0.65)
      ..lineTo(size.width * 0.8, size.height * 0.35);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ChevronPainter old) =>
      color != old.color || strokeWidth != old.strokeWidth;
}

class _CheckPainter extends CustomPainter {
  _CheckPainter({
    required this.color,
    required this.strokeWidth,
  });

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(size.width * 0.15, size.height * 0.5)
      ..lineTo(size.width * 0.4, size.height * 0.75)
      ..lineTo(size.width * 0.85, size.height * 0.25);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CheckPainter old) => color != old.color;
}
