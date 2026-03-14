import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A bottom sheet that slides up with a handle bar.
///
/// Use [ElogirBottomSheet.show] to display as a modal overlay.
/// Supports dragging to dismiss.
class ElogirBottomSheet extends StatelessWidget {
  const ElogirBottomSheet({
    super.key,
    required this.child,
    this.showHandle = true,
    this.backgroundColor,
    this.maxHeight,
  });

  final Widget child;
  final bool showHandle;
  final Color? backgroundColor;
  final double? maxHeight;

  /// Shows a bottom sheet as a modal overlay.
  ///
  /// Set [useRootNavigator] to true to display above all nested navigators
  /// (e.g. above a bottom navigation bar).
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    bool showHandle = true,
    bool useRootNavigator = false,
    double? maxHeight,
  }) {
    final curve = CurveTween(curve: Curves.easeOutCubic);
    final reverseCurve = CurveTween(curve: Curves.easeInCubic);

    return Navigator.of(context, rootNavigator: useRootNavigator).push<T>(
      PageRouteBuilder<T>(
        opaque: false,
        barrierDismissible: barrierDismissible,
        barrierColor: ElogirTheme.of(context).colors.barrier,
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 280),
        pageBuilder: (context, animation, secondaryAnimation) {
          return _ModalBottomSheet<T>(
            animation: animation,
            curve: curve,
            reverseCurve: reverseCurve,
            showHandle: showHandle,
            maxHeight: maxHeight,
            builder: builder,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    return Container(
      constraints: maxHeight != null
          ? BoxConstraints(maxHeight: maxHeight!)
          : null,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: theme.radii.lg.topLeft,
          topRight: theme.radii.lg.topRight,
        ),
        border: Border(
          top: BorderSide(
            color: colors.outline,
            width: theme.strokes.thick,
          ),
          left: BorderSide(
            color: colors.outline,
            width: theme.strokes.thick,
          ),
          right: BorderSide(
            color: colors.outline,
            width: theme.strokes.thick,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showHandle) _HandleBar(),
          Flexible(child: child),
        ],
      ),
    );
  }
}

class _HandleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: colors.outlineVariant,
          borderRadius: theme.radii.full,
        ),
      ),
    );
  }
}

class _ModalBottomSheet<T> extends StatefulWidget {
  const _ModalBottomSheet({
    required this.animation,
    required this.curve,
    required this.reverseCurve,
    required this.showHandle,
    required this.builder,
    this.maxHeight,
  });

  final Animation<double> animation;
  final Animatable<double> curve;
  final Animatable<double> reverseCurve;
  final bool showHandle;
  final WidgetBuilder builder;
  final double? maxHeight;

  @override
  State<_ModalBottomSheet<T>> createState() => _ModalBottomSheetState<T>();
}

class _ModalBottomSheetState<T> extends State<_ModalBottomSheet<T>> {
  double _dragOffset = 0;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset =
          (_dragOffset + details.delta.dy).clamp(0.0, double.infinity);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_dragOffset > 100 || details.velocity.pixelsPerSecond.dy > 500) {
      Navigator.of(context).pop();
    } else {
      setState(() => _dragOffset = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final curvedAnimation = widget.animation.status == AnimationStatus.reverse
        ? widget.animation.drive(widget.reverseCurve)
        : widget.animation.drive(widget.curve);

    return AnimatedBuilder(
      animation: curvedAnimation,
      builder: (context, child) {
        final screenHeight = MediaQuery.of(context).size.height;
        final dragFraction =
            screenHeight > 0 ? _dragOffset / screenHeight : 0.0;

        return Align(
          alignment: Alignment.bottomCenter,
          child: FractionalTranslation(
            translation: Offset(
              0,
              1.0 - curvedAnimation.value + dragFraction,
            ),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onVerticalDragUpdate: _onDragUpdate,
        onVerticalDragEnd: _onDragEnd,
        child: ElogirBottomSheet(
          showHandle: widget.showHandle,
          maxHeight: widget.maxHeight ??
              MediaQuery.of(context).size.height * 0.85,
          child: widget.builder(context),
        ),
      ),
    );
  }
}
