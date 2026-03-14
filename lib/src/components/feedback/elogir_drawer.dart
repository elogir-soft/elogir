import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// The edge from which the drawer slides in.
enum ElogirDrawerPosition { left, right, top, bottom }

/// A slide-in panel from any edge with a scrim overlay.
///
/// Use [ElogirDrawer.show] to display as a modal overlay, or embed
/// directly with your own animation controller.
class ElogirDrawer extends StatelessWidget {
  const ElogirDrawer({
    super.key,
    required this.child,
    this.width = 320,
    this.height = 400,
    this.position = ElogirDrawerPosition.left,
    this.backgroundColor,
  });

  final Widget child;
  final double width;
  final double height;
  final ElogirDrawerPosition position;
  final Color? backgroundColor;

  /// Shows the drawer as a modal overlay.
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    ElogirDrawerPosition position = ElogirDrawerPosition.left,
    double width = 320,
    double height = 400,
    bool barrierDismissible = true,
  }) {
    return Navigator.of(context).push<T>(
      PageRouteBuilder<T>(
        opaque: false,
        barrierDismissible: barrierDismissible,
        barrierColor: ElogirTheme.of(context).colors.barrier,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, animation, secondaryAnimation) {
          final Offset begin;
          switch (position) {
            case ElogirDrawerPosition.left:
              begin = const Offset(-1, 0);
            case ElogirDrawerPosition.right:
              begin = const Offset(1, 0);
            case ElogirDrawerPosition.top:
              begin = const Offset(0, -1);
            case ElogirDrawerPosition.bottom:
              begin = const Offset(0, 1);
          }

          return SlideTransition(
            position: Tween<Offset>(begin: begin, end: Offset.zero).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
                reverseCurve: Curves.easeOutCubic.flipped,
              ),
            ),
            child: _DrawerLayout(
              position: position,
              child: ElogirDrawer(
                position: position,
                width: width,
                height: height,
                child: builder(context),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final isHorizontal = position == ElogirDrawerPosition.left ||
        position == ElogirDrawerPosition.right;

    final BorderSide borderSide = BorderSide(
      color: colors.outline,
      width: theme.strokes.thick,
    );

    final Border border;
    switch (position) {
      case ElogirDrawerPosition.left:
        border = Border(right: borderSide);
      case ElogirDrawerPosition.right:
        border = Border(left: borderSide);
      case ElogirDrawerPosition.top:
        border = Border(bottom: borderSide);
      case ElogirDrawerPosition.bottom:
        border = Border(top: borderSide);
    }

    return Container(
      width: isHorizontal ? width : null,
      height: !isHorizontal ? height : null,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surface,
        border: border,
      ),
      child: child,
    );
  }
}

/// Positions the drawer against the correct edge.
class _DrawerLayout extends StatelessWidget {
  const _DrawerLayout({
    required this.position,
    required this.child,
  });

  final ElogirDrawerPosition position;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Alignment alignment;
    switch (position) {
      case ElogirDrawerPosition.left:
        alignment = Alignment.centerLeft;
      case ElogirDrawerPosition.right:
        alignment = Alignment.centerRight;
      case ElogirDrawerPosition.top:
        alignment = Alignment.topCenter;
      case ElogirDrawerPosition.bottom:
        alignment = Alignment.bottomCenter;
    }

    return Align(
      alignment: alignment,
      child: child,
    );
  }
}
