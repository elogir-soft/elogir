import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../../theme/theme_data.dart';
import '../interaction/elogir_pressable.dart';

/// An overlay-based dropdown that allows selecting multiple values.
///
/// Displays selected count in the trigger. Options show checkboxes and
/// stay open until the user taps outside or presses the trigger again.
///
/// ```dart
/// ElogirMultiDropdown<String>(
///   options: [
///     ElogirDropdownOption(value: 'a', label: 'Alpha'),
///     ElogirDropdownOption(value: 'b', label: 'Beta'),
///   ],
///   values: _selected,
///   onChanged: (v) => setState(() => _selected = v),
///   placeholder: 'Select items…',
/// )
/// ```
class ElogirMultiDropdown<T> extends StatefulWidget {
  const ElogirMultiDropdown({
    super.key,
    required this.options,
    required this.onChanged,
    this.values = const {},
    this.placeholder,
    this.enabled = true,
    this.width,
    this.maxDisplayLabels = 2,
  });

  /// Available options.
  final List<ElogirMultiDropdownOption<T>> options;

  /// Called when the selected set changes.
  final ValueChanged<Set<T>> onChanged;

  /// Currently selected values.
  final Set<T> values;

  /// Text shown when nothing is selected.
  final String? placeholder;

  /// Whether the dropdown is interactive.
  final bool enabled;

  /// Fixed width for the trigger and overlay. Null = intrinsic.
  final double? width;

  /// Max number of selected labels to show before collapsing to "N selected".
  final int maxDisplayLabels;

  @override
  State<ElogirMultiDropdown<T>> createState() => _ElogirMultiDropdownState<T>();
}

class _ElogirMultiDropdownState<T> extends State<ElogirMultiDropdown<T>>
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
  void didUpdateWidget(ElogirMultiDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isOpen && widget.values != oldWidget.values) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _overlayEntry?.markNeedsBuild();
      });
    }
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
        return _MultiDropdownOverlay<T>(
          link: _layerLink,
          fadeAnimation: _fadeController,
          theme: theme,
          options: widget.options,
          selectedValues: widget.values,
          triggerWidth: widget.width ?? triggerWidth,
          onToggle: _toggleValue,
          onSelectAll: _selectAll,
          onClearAll: _clearAll,
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

  void _toggleValue(T value) {
    final next = Set<T>.from(widget.values);
    if (next.contains(value)) {
      next.remove(value);
    } else {
      next.add(value);
    }
    widget.onChanged(next);
  }

  void _selectAll() {
    final all = widget.options
        .where((o) => o.enabled)
        .map((o) => o.value)
        .toSet();
    widget.onChanged(all);
  }

  void _clearAll() {
    widget.onChanged({});
  }

  String _buildDisplayText() {
    if (widget.values.isEmpty) {
      return widget.placeholder ?? 'Select...';
    }

    final selectedLabels = widget.options
        .where((o) => widget.values.contains(o.value))
        .map((o) => o.label)
        .toList();

    if (selectedLabels.length <= widget.maxDisplayLabels) {
      return selectedLabels.join(', ');
    }
    return '${selectedLabels.length} selected';
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final enabled = widget.enabled;
    final isPlaceholder = widget.values.isEmpty;

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
                  _buildDisplayText(),
                  style: theme.typography.bodyMedium.copyWith(
                    color: isPlaceholder
                        ? colors.onSurfaceVariant
                        : (enabled ? colors.onSurface : colors.onDisabled),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.values.isNotEmpty && enabled) ...[
                _TriggerClearLabel(
                  theme: theme,
                  onTap: () {
                    _clearAll();
                  },
                ),
                SizedBox(width: theme.spacing.sm),
              ],
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

/// A single option in a multi-dropdown.
class ElogirMultiDropdownOption<T> {
  const ElogirMultiDropdownOption({
    required this.value,
    required this.label,
    this.enabled = true,
  });

  final T value;
  final String label;
  final bool enabled;
}

// ─── Trigger clear label ─────────────────────────────────────────

class _TriggerClearLabel extends StatefulWidget {
  const _TriggerClearLabel({required this.theme, required this.onTap});

  final ElogirThemeData theme;
  final VoidCallback onTap;

  @override
  State<_TriggerClearLabel> createState() => _TriggerClearLabelState();
}

class _TriggerClearLabelState extends State<_TriggerClearLabel> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.theme.colors;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          'Clear',
          style: widget.theme.typography.caption.copyWith(
            color: _hovered ? colors.error : colors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ─── Overlay ─────────────────────────────────────────────────────

class _MultiDropdownOverlay<T> extends StatelessWidget {
  const _MultiDropdownOverlay({
    required this.link,
    required this.fadeAnimation,
    required this.theme,
    required this.options,
    required this.selectedValues,
    required this.triggerWidth,
    required this.onToggle,
    required this.onSelectAll,
    required this.onClearAll,
  });

  final LayerLink link;
  final AnimationController fadeAnimation;
  final ElogirThemeData theme;
  final List<ElogirMultiDropdownOption<T>> options;
  final Set<T> selectedValues;
  final double triggerWidth;
  final ValueChanged<T> onToggle;
  final VoidCallback onSelectAll;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    final colors = theme.colors;
    final allSelected = options
        .where((o) => o.enabled)
        .every((o) => selectedValues.contains(o.value));
    final hasSelection = selectedValues.isNotEmpty;

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
            constraints: const BoxConstraints(maxHeight: 320),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: theme.radii.md,
              border: Border.all(
                color: colors.outline,
                width: theme.strokes.thick,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  (theme.radii.md.topLeft.x - theme.strokes.thick)
                      .clamp(0, double.infinity),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Actions header
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: theme.spacing.md,
                      vertical: theme.spacing.sm,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (hasSelection)
                          Text(
                            '${selectedValues.length} selected',
                            style: theme.typography.labelSmall.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!allSelected)
                              _ActionButton(
                                label: 'All',
                                theme: theme,
                                onTap: onSelectAll,
                              ),
                            if (!allSelected && hasSelection)
                              SizedBox(width: theme.spacing.xs),
                            if (hasSelection)
                              _ActionButton(
                                label: 'Clear',
                                theme: theme,
                                onTap: onClearAll,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: theme.strokes.thin,
                    color: colors.outlineVariant,
                  ),
                  // Options
                  Flexible(
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: theme.spacing.xs),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final option in options)
                            _MultiOptionItem<T>(
                              option: option,
                              isSelected:
                                  selectedValues.contains(option.value),
                              theme: theme,
                              onToggle: onToggle,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Action button (All / Clear) ─────────────────────────────────

class _ActionButton extends StatefulWidget {
  const _ActionButton({
    required this.label,
    required this.theme,
    required this.onTap,
  });

  final String label;
  final ElogirThemeData theme;
  final VoidCallback onTap;

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.theme.colors;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.theme.spacing.sm,
            vertical: widget.theme.spacing.xs,
          ),
          decoration: BoxDecoration(
            color: _hovered
                ? colors.surfaceContainer
                : const Color(0x00000000),
            borderRadius: widget.theme.radii.sm,
            border: Border.all(
              color: colors.outlineVariant,
              width: widget.theme.strokes.thin,
            ),
          ),
          child: Text(
            widget.label,
            style: widget.theme.typography.labelSmall.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Option item with checkbox ───────────────────────────────────

class _MultiOptionItem<T> extends StatefulWidget {
  const _MultiOptionItem({
    required this.option,
    required this.isSelected,
    required this.theme,
    required this.onToggle,
  });

  final ElogirMultiDropdownOption<T> option;
  final bool isSelected;
  final ElogirThemeData theme;
  final ValueChanged<T> onToggle;

  @override
  State<_MultiOptionItem<T>> createState() => _MultiOptionItemState<T>();
}

class _MultiOptionItemState<T> extends State<_MultiOptionItem<T>> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.theme.colors;

    return ElogirPressable(
      enabled: widget.option.enabled,
      onPressed: () => widget.onToggle(widget.option.value),
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
            // Mini checkbox
            CustomPaint(
              size: const Size.square(16),
              painter: _MiniCheckPainter(
                checked: widget.isSelected,
                borderColor: widget.isSelected
                    ? colors.primary
                    : colors.outline,
                fillColor: colors.primary,
                checkColor: colors.onPrimary,
                strokeWidth: widget.theme.strokes.thick,
              ),
            ),
            SizedBox(width: widget.theme.spacing.sm),
            Expanded(
              child: Text(
                widget.option.label,
                style: widget.theme.typography.bodyMedium.copyWith(
                  color: widget.option.enabled
                      ? (widget.isSelected
                          ? colors.onPrimaryContainer
                          : colors.onSurface)
                      : colors.onDisabled,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Custom Painters ─────────────────────────────────────────────

class _MiniCheckPainter extends CustomPainter {
  _MiniCheckPainter({
    required this.checked,
    required this.borderColor,
    required this.fillColor,
    required this.checkColor,
    required this.strokeWidth,
  });

  final bool checked;
  final Color borderColor;
  final Color fillColor;
  final Color checkColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final insetRect = rect.deflate(strokeWidth / 2);
    final rrect =
        RRect.fromRectAndRadius(insetRect, const Radius.circular(3));

    if (checked) {
      canvas.drawRRect(rrect, Paint()..color = fillColor);
    }

    canvas.drawRRect(
      rrect,
      Paint()
        ..color = checked ? fillColor : borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    if (checked) {
      final paint = Paint()
        ..color = checkColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final path = Path()
        ..moveTo(size.width * 0.2, size.height * 0.5)
        ..lineTo(size.width * 0.4, size.height * 0.72)
        ..lineTo(size.width * 0.8, size.height * 0.28);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_MiniCheckPainter old) =>
      checked != old.checked || borderColor != old.borderColor;
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

