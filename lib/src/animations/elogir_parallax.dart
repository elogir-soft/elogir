import 'package:flutter/widgets.dart';

/// Scroll-linked offset for a depth/parallax effect in lists.
///
/// Place inside a [ListView] or [CustomScrollView]. The child
/// shifts based on its position within the viewport.
///
/// ```dart
/// ListView(
///   children: [
///     ElogirParallax(
///       factor: 0.3,
///       child: Image.network(url, height: 200, fit: BoxFit.cover),
///     ),
///   ],
/// )
/// ```
class ElogirParallax extends StatelessWidget {
  const ElogirParallax({
    super.key,
    required this.child,
    this.factor = 0.3,
    this.direction = Axis.vertical,
    this.clipBehavior = Clip.hardEdge,
  });

  final Widget child;

  /// How much the child shifts relative to scroll. 0 = no shift, 1 = full shift.
  final double factor;

  /// Scroll direction to offset against.
  final Axis direction;

  /// Clip behavior for the parallax container.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: clipBehavior,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return _ParallaxContent(
            factor: factor,
            direction: direction,
            child: child,
          );
        },
      ),
    );
  }
}

class _ParallaxContent extends StatefulWidget {
  const _ParallaxContent({
    required this.factor,
    required this.direction,
    required this.child,
  });

  final double factor;
  final Axis direction;
  final Widget child;

  @override
  State<_ParallaxContent> createState() => _ParallaxContentState();
}

class _ParallaxContentState extends State<_ParallaxContent> {
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        itemContext: context,
        factor: widget.factor,
        direction: widget.direction,
      ),
      children: [widget.child],
    );
  }
}

class _ParallaxFlowDelegate extends FlowDelegate {
  _ParallaxFlowDelegate({
    required this.scrollable,
    required this.itemContext,
    required this.factor,
    required this.direction,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext itemContext;
  final double factor;
  final Axis direction;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox =
        scrollable.context.findRenderObject() as RenderBox;
    final itemBox = itemContext.findRenderObject() as RenderBox;
    final itemOffset = itemBox.localToGlobal(
      Offset.zero,
      ancestor: scrollableBox,
    );

    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction = direction == Axis.vertical
        ? (itemOffset.dy / viewportDimension).clamp(-1.0, 2.0)
        : (itemOffset.dx / viewportDimension).clamp(-1.0, 2.0);

    final parallaxOffset = (scrollFraction - 0.5) * factor * 100;

    context.paintChild(
      0,
      transform: direction == Axis.vertical
          ? Matrix4.translationValues(0.0, parallaxOffset, 0.0)
          : Matrix4.translationValues(parallaxOffset, 0.0, 0.0),
    );
  }

  @override
  bool shouldRepaint(_ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        itemContext != oldDelegate.itemContext ||
        factor != oldDelegate.factor;
  }
}
