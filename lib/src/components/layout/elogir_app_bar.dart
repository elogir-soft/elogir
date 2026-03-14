import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A top app bar with leading/title/trailing layout.
///
/// Soft Industrial style: thick bottom border, generous height.
class ElogirAppBar extends StatelessWidget {
  const ElogirAppBar({
    super.key,
    this.title,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.height = 60.0,
    this.padding,
  });

  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;
  final double height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final effectivePadding =
        padding ?? EdgeInsets.symmetric(horizontal: theme.spacing.lg);

    return Semantics(
      header: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor ?? theme.colors.surface,
          border: Border(
            bottom: BorderSide(
              color: theme.colors.outlineVariant,
              width: theme.strokes.thick,
            ),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: height,
            child: Padding(
              padding: effectivePadding,
              child: Row(
                children: [
                  ?leading,
                  if (title != null)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: theme.spacing.sm,
                        ),
                        child: DefaultTextStyle.merge(
                          style: theme.typography.titleLarge.copyWith(
                            color: theme.colors.onSurface,
                          ),
                          child: title!,
                        ),
                      ),
                    )
                  else
                    const Spacer(),
                  ?trailing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
