import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A modal dialog with backdrop, built from primitives.
///
/// Soft Industrial style: thick-bordered card, no shadow, clean layout.
///
/// Use [ElogirDialog.show] for a convenient way to display the dialog.
class ElogirDialog extends StatelessWidget {
  const ElogirDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.width = 420,
    this.padding,
  });

  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final double width;
  final EdgeInsets? padding;

  /// Shows this dialog as a modal overlay.
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    return Navigator.of(context).push<T>(
      PageRouteBuilder<T>(
        opaque: false,
        barrierDismissible: barrierDismissible,
        barrierColor: ElogirTheme.of(context).colors.barrier,
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 150),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ),
              ),
              child: Center(child: builder(context)),
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
    final effectivePadding = padding ?? EdgeInsets.all(theme.spacing.lg);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: Container(
        margin: EdgeInsets.all(theme.spacing.lg),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: theme.radii.lg,
          border: Border.all(
            color: colors.outline,
            width: theme.strokes.thick,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  effectivePadding.left,
                  effectivePadding.top,
                  effectivePadding.right,
                  theme.spacing.sm,
                ),
                child: DefaultTextStyle.merge(
                  style: theme.typography.titleLarge.copyWith(
                    color: colors.onSurface,
                  ),
                  child: title!,
                ),
              ),
            if (content != null)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  effectivePadding.left,
                  title != null ? 0 : effectivePadding.top,
                  effectivePadding.right,
                  theme.spacing.md,
                ),
                child: DefaultTextStyle.merge(
                  style: theme.typography.bodyMedium.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                  child: content!,
                ),
              ),
            if (actions != null && actions!.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: colors.outlineVariant,
                      width: theme.strokes.thin,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(theme.spacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    for (int i = 0; i < actions!.length; i++) ...[
                      if (i > 0) SizedBox(width: theme.spacing.sm),
                      actions![i],
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
