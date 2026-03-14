import 'dart:math' show pi;

import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// A single accordion section with a header and collapsible body.
///
/// Use inside an [ElogirAccordionGroup] for coordinated single-open
/// behavior, or standalone for independent expand/collapse.
class ElogirAccordion extends StatefulWidget {
  const ElogirAccordion({
    super.key,
    required this.title,
    required this.body,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.leading,
  });

  final Widget title;
  final Widget body;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final Widget? leading;

  @override
  State<ElogirAccordion> createState() => ElogirAccordionState();
}

class ElogirAccordionState extends State<ElogirAccordion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _heightFactor;
  late final Animation<double> _chevronTurns;
  late final Animation<double> _contentOpacity;
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
      value: _expanded ? 1.0 : 0.0,
    );
    _heightFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeOutCubic.flipped,
    );
    _contentOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      reverseCurve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
    _chevronTurns = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeOutCubic.flipped,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get isExpanded => _expanded;

  void toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    widget.onExpansionChanged?.call(_expanded);
  }

  void expand() {
    if (!_expanded) toggle();
  }

  void collapse() {
    if (_expanded) toggle();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    return AnimatedContainer(
      duration: theme.durations.fast,
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.outlineVariant,
          width: theme.strokes.medium,
        ),
        borderRadius: theme.radii.md,
        color: colors.surface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          ElogirPressable(
            onPressed: toggle,
            pressScale: 0.99,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.md,
                vertical: theme.spacing.md,
              ),
              child: Row(
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    SizedBox(width: theme.spacing.sm),
                  ],
                  Expanded(
                    child: DefaultTextStyle.merge(
                      style: theme.typography.titleSmall.copyWith(
                        color: colors.onSurface,
                      ),
                      child: widget.title,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _chevronTurns,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _chevronTurns.value * pi,
                        child: child,
                      );
                    },
                    child: CustomPaint(
                      size: const Size(16, 16),
                      painter: _ChevronPainter(
                        color: colors.onSurfaceVariant,
                        strokeWidth: theme.strokes.medium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Body
          AnimatedBuilder(
            animation: _heightFactor,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _heightFactor.value,
                  child: child,
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: theme.strokes.thin,
                  color: colors.outlineVariant,
                ),
                FadeTransition(
                  opacity: _contentOpacity,
                  child: Padding(
                    padding: EdgeInsets.all(theme.spacing.md),
                    child: DefaultTextStyle.merge(
                      style: theme.typography.bodyMedium.copyWith(
                        color: colors.onSurface,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: widget.body,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Groups multiple [ElogirAccordion]s with optional single-open behavior.
class ElogirAccordionGroup extends StatefulWidget {
  const ElogirAccordionGroup({
    super.key,
    required this.children,
    this.allowMultiple = false,
    this.spacing,
  });

  final List<ElogirAccordion> children;
  final bool allowMultiple;
  final double? spacing;

  @override
  State<ElogirAccordionGroup> createState() => _ElogirAccordionGroupState();
}

class _ElogirAccordionGroupState extends State<ElogirAccordionGroup> {
  final List<GlobalKey<ElogirAccordionState>> _keys = [];

  @override
  void initState() {
    super.initState();
    _keys.addAll(
      widget.children.map((_) => GlobalKey<ElogirAccordionState>()),
    );
  }

  @override
  void didUpdateWidget(ElogirAccordionGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    while (_keys.length < widget.children.length) {
      _keys.add(GlobalKey<ElogirAccordionState>());
    }
    while (_keys.length > widget.children.length) {
      _keys.removeLast();
    }
  }

  void _handleExpansion(int index, bool expanded) {
    if (!widget.allowMultiple && expanded) {
      for (int i = 0; i < _keys.length; i++) {
        if (i != index) {
          _keys[i].currentState?.collapse();
        }
      }
    }
    // Forward the original callback
    widget.children[index].onExpansionChanged?.call(expanded);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final spacing = widget.spacing ?? theme.spacing.sm;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < widget.children.length; i++) ...[
          if (i > 0) SizedBox(height: spacing),
          ElogirAccordion(
            key: _keys[i],
            title: widget.children[i].title,
            body: widget.children[i].body,
            initiallyExpanded: widget.children[i].initiallyExpanded,
            leading: widget.children[i].leading,
            onExpansionChanged: (expanded) => _handleExpansion(i, expanded),
          ),
        ],
      ],
    );
  }
}

/// Draws a downward-pointing chevron (V shape).
class _ChevronPainter extends CustomPainter {
  _ChevronPainter({required this.color, required this.strokeWidth});
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
