import 'package:flutter/widgets.dart';

import 'elogir_fade_in.dart';

/// Applies cascading fade-in animations to a list of children.
///
/// Each child starts its animation after a delay offset from the previous one.
///
/// ```dart
/// ElogirStaggeredList(
///   children: items.map((i) => ElogirCard(child: Text(i))).toList(),
/// )
/// ```
class ElogirStaggeredList extends StatelessWidget {
  const ElogirStaggeredList({
    super.key,
    required this.children,
    this.itemDelay = const Duration(milliseconds: 50),
    this.itemDuration = const Duration(milliseconds: 400),
    this.direction = ElogirFadeInDirection.up,
    this.offset = 20.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.padding,
    this.scrollable = true,
    this.controller,
    this.physics,
  });

  final List<Widget> children;

  /// Delay between each child's animation start.
  final Duration itemDelay;

  /// Duration of each child's animation.
  final Duration itemDuration;

  /// Slide direction for each child.
  final ElogirFadeInDirection direction;

  /// Slide distance in logical pixels.
  final double offset;

  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  /// Optional padding around the list.
  final EdgeInsetsGeometry? padding;

  /// Whether the list should be scrollable (wraps in ListView).
  /// If false, uses a Column.
  final bool scrollable;

  final ScrollController? controller;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    final animatedChildren = [
      for (int i = 0; i < children.length; i++)
        ElogirFadeIn(
          duration: itemDuration,
          delay: itemDelay * i,
          direction: direction,
          offset: offset,
          child: children[i],
        ),
    ];

    if (scrollable) {
      return ListView(
        padding: padding,
        controller: controller,
        physics: physics,
        children: animatedChildren,
      );
    }

    Widget result = Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: animatedChildren,
    );

    if (padding != null) {
      result = Padding(padding: padding!, child: result);
    }

    return result;
  }
}
