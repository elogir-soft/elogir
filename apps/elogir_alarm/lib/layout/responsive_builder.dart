import 'package:elogir_alarm/layout/breakpoints.dart';
import 'package:flutter/widgets.dart';

/// Selects a child widget based on the current breakpoint.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.compact,
    required this.medium,
    required this.expanded,
    super.key,
  });

  /// Widget for compact layout (< 600dp).
  final Widget Function(BuildContext context) compact;

  /// Widget for medium layout (600–839dp).
  final Widget Function(BuildContext context) medium;

  /// Widget for expanded layout (≥ 840dp).
  final Widget Function(BuildContext context) expanded;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final breakpoint = Breakpoint.fromWidth(constraints.maxWidth);
        return switch (breakpoint) {
          Breakpoint.compact => compact(context),
          Breakpoint.medium => medium(context),
          Breakpoint.expanded => expanded(context),
        };
      },
    );
  }
}
