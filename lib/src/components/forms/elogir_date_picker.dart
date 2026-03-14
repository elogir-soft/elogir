import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';
import 'elogir_calendar.dart';

/// An overlay-based date picker trigger that opens an [ElogirCalendar]
/// in a dropdown overlay.
///
/// For a standalone calendar widget you can embed anywhere, use
/// [ElogirCalendar] directly.
///
/// ```dart
/// ElogirDatePicker(
///   value: _date,
///   onChanged: (d) => setState(() => _date = d),
/// )
/// ```
class ElogirDatePicker extends StatefulWidget {
  const ElogirDatePicker({
    super.key,
    // Single mode
    this.value,
    this.onChanged,
    // Range mode
    this.rangeStart,
    this.rangeEnd,
    this.onRangeChanged,
    // Multi mode
    this.selectedDates,
    this.onMultiChanged,
    // Mode
    this.selectionMode = ElogirDateSelectionMode.single,
    // Bounds
    this.firstDate,
    this.lastDate,
    // Display
    this.placeholder,
    this.width,
    this.enabled = true,
    this.formatDate,
  });

  final DateTime? value;
  final ValueChanged<DateTime>? onChanged;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final void Function(DateTime start, DateTime end)? onRangeChanged;
  final Set<DateTime>? selectedDates;
  final ValueChanged<Set<DateTime>>? onMultiChanged;
  final ElogirDateSelectionMode selectionMode;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? placeholder;
  final double? width;
  final bool enabled;
  final String Function(DateTime)? formatDate;

  @override
  State<ElogirDatePicker> createState() => _ElogirDatePickerState();
}

class _ElogirDatePickerState extends State<ElogirDatePicker>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  OverlayEntry? _barrierEntry;
  late final AnimationController _fadeController;
  bool _isOpen = false;
  bool _hovered = false;

  // Multi-select pending state (emit on close)
  Set<DateTime> _pendingMultiDates = {};

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
    _removeOverlay();
    _fadeController.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _barrierEntry?.remove();
    _barrierEntry = null;
  }

  void _toggle() {
    _isOpen ? _close() : _open();
  }

  void _open() {
    if (_isOpen) return;
    _isOpen = true;

    _pendingMultiDates = Set.from(widget.selectedDates ?? {});

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
      builder: (ctx) {
        return Positioned(
          left: 0,
          top: 0,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: const Offset(0, 4),
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            showWhenUnlinked: false,
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _fadeController,
                curve: Curves.easeOut,
              ),
              child: ElogirCalendar(
                selectionMode: widget.selectionMode,
                value: widget.value,
                onChanged: (date) {
                  widget.onChanged?.call(date);
                  _close();
                },
                rangeStart: widget.rangeStart,
                rangeEnd: widget.rangeEnd,
                onRangeChanged: (start, end) {
                  widget.onRangeChanged?.call(start, end);
                  _close();
                },
                selectedDates: _pendingMultiDates,
                onMultiChanged: (dates) {
                  _pendingMultiDates = dates;
                  _overlayEntry?.markNeedsBuild();
                },
                firstDate: widget.firstDate,
                lastDate: widget.lastDate,
              ),
            ),
          ),
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

    if (widget.selectionMode == ElogirDateSelectionMode.multiple) {
      widget.onMultiChanged?.call(_pendingMultiDates);
    }

    _fadeController.reverse().then((_) => _removeOverlay());
    setState(() {});
  }

  String _fmt(DateTime d) {
    if (widget.formatDate != null) return widget.formatDate!(d);
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }

  String get _displayText {
    switch (widget.selectionMode) {
      case ElogirDateSelectionMode.single:
        if (widget.value != null) return _fmt(widget.value!);
        return widget.placeholder ?? 'Select date';

      case ElogirDateSelectionMode.range:
        final s = widget.rangeStart;
        final e = widget.rangeEnd;
        if (s != null && e != null) return '${_fmt(s)} – ${_fmt(e)}';
        if (s != null) return '${_fmt(s)} – …';
        return widget.placeholder ?? 'Select dates';

      case ElogirDateSelectionMode.multiple:
        final dates = widget.selectedDates;
        if (dates != null && dates.isNotEmpty) {
          if (dates.length == 1) return _fmt(dates.first);
          return '${dates.length} dates selected';
        }
        return widget.placeholder ?? 'Select dates';
    }
  }

  bool get _hasValue {
    switch (widget.selectionMode) {
      case ElogirDateSelectionMode.single:
        return widget.value != null;
      case ElogirDateSelectionMode.range:
        return widget.rangeStart != null;
      case ElogirDateSelectionMode.multiple:
        return widget.selectedDates != null &&
            widget.selectedDates!.isNotEmpty;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final enabled = widget.enabled;

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
              CustomPaint(
                size: const Size(16, 16),
                painter: _CalendarIconPainter(
                  color: enabled
                      ? colors.onSurfaceVariant
                      : colors.onDisabled,
                  strokeWidth: theme.strokes.medium,
                ),
              ),
              SizedBox(width: theme.spacing.sm),
              Expanded(
                child: Text(
                  _displayText,
                  style: theme.typography.bodyMedium.copyWith(
                    color: _hasValue
                        ? (enabled ? colors.onSurface : colors.onDisabled)
                        : colors.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Custom Painters ──────────────────────────────────────────────

class _CalendarIconPainter extends CustomPainter {
  _CalendarIconPainter({
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

    final w = size.width;
    final h = size.height;

    canvas.drawRRect(
      RRect.fromLTRBR(0, h * 0.15, w, h, Radius.circular(w * 0.12)),
      paint,
    );
    canvas.drawLine(Offset(0, h * 0.35), Offset(w, h * 0.35), paint);
    canvas.drawLine(Offset(w * 0.3, 0), Offset(w * 0.3, h * 0.25), paint);
    canvas.drawLine(Offset(w * 0.7, 0), Offset(w * 0.7, h * 0.25), paint);

    final dotPaint = Paint()..color = color;
    final dotSize = w * 0.08;
    for (int r = 0; r < 2; r++) {
      for (int c = 0; c < 3; c++) {
        canvas.drawCircle(
          Offset(w * 0.25 + c * w * 0.25, h * 0.55 + r * h * 0.2),
          dotSize,
          dotPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_CalendarIconPainter old) => color != old.color;
}
