import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../../theme/theme_data.dart';
import '../interaction/elogir_pressable.dart';

/// Toast style variants.
enum ElogirToastVariant { info, success, warning, error }

/// Position for toast notifications on screen.
enum ElogirToastPosition { top, bottom }

/// A non-modal toast notification that stacks and auto-dismisses.
///
/// Use [ElogirToast.show] to display a toast from anywhere in the tree.
/// Toasts stack vertically and slide in/out with animation.
class ElogirToast {
  ElogirToast._();

  static final List<_ToastEntry> _entries = [];
  static OverlayEntry? _containerEntry;

  /// Shows a toast notification.
  ///
  /// Returns a [VoidCallback] that can be called to dismiss the toast early.
  static VoidCallback show({
    required BuildContext context,
    required String message,
    ElogirToastVariant variant = ElogirToastVariant.info,
    Duration duration = const Duration(seconds: 3),
    ElogirToastPosition position = ElogirToastPosition.bottom,
    VoidCallback? onDismissed,
  }) {
    final overlay = Overlay.of(context);
    final theme = ElogirTheme.of(context);

    final entry = _ToastEntry(
      message: message,
      variant: variant,
      duration: duration,
      position: position,
      theme: theme,
      onDismissed: onDismissed,
    );

    _entries.add(entry);

    if (_containerEntry == null) {
      _containerEntry = OverlayEntry(
        builder: (_) => _ToastContainer(
          entries: _entries,
          onRemove: _removeEntry,
        ),
      );
      overlay.insert(_containerEntry!);
    } else {
      _containerEntry!.markNeedsBuild();
    }

    return () => _removeEntry(entry);
  }

  static void _removeEntry(_ToastEntry entry) {
    _entries.remove(entry);
    entry.onDismissed?.call();
    if (_entries.isEmpty) {
      _containerEntry?.remove();
      _containerEntry = null;
    } else {
      _containerEntry?.markNeedsBuild();
    }
  }
}

class _ToastEntry {
  _ToastEntry({
    required this.message,
    required this.variant,
    required this.duration,
    required this.position,
    required this.theme,
    this.onDismissed,
  }) : id = _nextId++;

  static int _nextId = 0;

  final int id;
  final String message;
  final ElogirToastVariant variant;
  final Duration duration;
  final ElogirToastPosition position;
  final ElogirThemeData theme;
  final VoidCallback? onDismissed;
}

class _ToastContainer extends StatelessWidget {
  const _ToastContainer({
    required this.entries,
    required this.onRemove,
  });

  final List<_ToastEntry> entries;
  final void Function(_ToastEntry) onRemove;

  @override
  Widget build(BuildContext context) {
    final bottomEntries =
        entries.where((e) => e.position == ElogirToastPosition.bottom).toList();
    final topEntries =
        entries.where((e) => e.position == ElogirToastPosition.top).toList();

    return Positioned.fill(
      child: IgnorePointer(
        ignoring: false,
        child: Stack(
          children: [
            // Bottom toasts
            if (bottomEntries.isNotEmpty)
              Positioned(
                left: 0,
                right: 0,
                bottom: 24,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final entry in bottomEntries)
                      _ToastWidget(
                        key: ValueKey(entry.id),
                        entry: entry,
                        onDismiss: () => onRemove(entry),
                      ),
                  ],
                ),
              ),
            // Top toasts
            if (topEntries.isNotEmpty)
              Positioned(
                left: 0,
                right: 0,
                top: 24,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final entry in topEntries)
                      _ToastWidget(
                        key: ValueKey(entry.id),
                        entry: entry,
                        onDismiss: () => onRemove(entry),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    super.key,
    required this.entry,
    required this.onDismiss,
  });

  final _ToastEntry entry;
  final VoidCallback onDismiss;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _autoDismissTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _controller.forward();
    _autoDismissTimer = Timer(widget.entry.duration, _dismiss);
  }

  @override
  void dispose() {
    _autoDismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() {
    _autoDismissTimer?.cancel();
    _controller.reverse().then((_) {
      if (mounted) widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.entry.theme;
    final colors = theme.colors;

    final Color bg;
    final Color fg;
    final Color borderColor;

    switch (widget.entry.variant) {
      case ElogirToastVariant.info:
        bg = colors.surfaceContainer;
        fg = colors.onSurface;
        borderColor = colors.outline;
      case ElogirToastVariant.success:
        bg = Color.lerp(colors.surface, colors.success, 0.1)!;
        fg = colors.success;
        borderColor = colors.success;
      case ElogirToastVariant.warning:
        bg = Color.lerp(colors.surface, colors.warning, 0.1)!;
        fg = colors.warning;
        borderColor = colors.warning;
      case ElogirToastVariant.error:
        bg = Color.lerp(colors.surface, colors.error, 0.1)!;
        fg = colors.error;
        borderColor = colors.error;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.sm),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: widget.entry.position == ElogirToastPosition.bottom
              ? const Offset(0, 1)
              : const Offset(0, -1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        )),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
          ),
          child: Center(
            child: ElogirPressable(
              onPressed: _dismiss,
              pressScale: 0.97,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.md,
                  vertical: theme.spacing.sm + theme.spacing.xs,
                ),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: theme.radii.md,
                  border: Border.all(
                    color: borderColor,
                    width: theme.strokes.medium,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomPaint(
                      size: const Size(16, 16),
                      painter: _ToastIconPainter(
                        variant: widget.entry.variant,
                        color: fg,
                        strokeWidth: theme.strokes.medium,
                      ),
                    ),
                    SizedBox(width: theme.spacing.sm),
                    Flexible(
                      child: Text(
                        widget.entry.message,
                        style: theme.typography.bodyMedium.copyWith(
                          color: widget.entry.variant == ElogirToastVariant.info
                              ? colors.onSurface
                              : fg,
                        ),
                      ),
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

/// Draws simple icons for each toast variant.
class _ToastIconPainter extends CustomPainter {
  _ToastIconPainter({
    required this.variant,
    required this.color,
    required this.strokeWidth,
  });

  final ElogirToastVariant variant;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.42;

    switch (variant) {
      case ElogirToastVariant.info:
        // Circle with "i"
        canvas.drawCircle(Offset(cx, cy), r, paint);
        paint.style = PaintingStyle.fill;
        canvas.drawCircle(Offset(cx, cy - r * 0.35), 1.2, paint);
        paint.style = PaintingStyle.stroke;
        canvas.drawLine(
          Offset(cx, cy - r * 0.05),
          Offset(cx, cy + r * 0.5),
          paint,
        );
      case ElogirToastVariant.success:
        // Checkmark
        canvas.drawLine(
          Offset(size.width * 0.2, cy),
          Offset(size.width * 0.42, size.height * 0.7),
          paint,
        );
        canvas.drawLine(
          Offset(size.width * 0.42, size.height * 0.7),
          Offset(size.width * 0.8, size.height * 0.3),
          paint,
        );
      case ElogirToastVariant.warning:
        // Triangle with "!"
        final path = Path()
          ..moveTo(cx, size.height * 0.12)
          ..lineTo(size.width * 0.1, size.height * 0.88)
          ..lineTo(size.width * 0.9, size.height * 0.88)
          ..close();
        canvas.drawPath(path, paint);
        paint.style = PaintingStyle.fill;
        canvas.drawCircle(Offset(cx, size.height * 0.73), 1.2, paint);
        paint.style = PaintingStyle.stroke;
        canvas.drawLine(
          Offset(cx, size.height * 0.38),
          Offset(cx, size.height * 0.6),
          paint,
        );
      case ElogirToastVariant.error:
        // Circle with ×
        canvas.drawCircle(Offset(cx, cy), r, paint);
        final inset = size.width * 0.28;
        canvas.drawLine(
          Offset(inset, inset),
          Offset(size.width - inset, size.height - inset),
          paint,
        );
        canvas.drawLine(
          Offset(size.width - inset, inset),
          Offset(inset, size.height - inset),
          paint,
        );
    }
  }

  @override
  bool shouldRepaint(_ToastIconPainter old) =>
      variant != old.variant || color != old.color;
}
