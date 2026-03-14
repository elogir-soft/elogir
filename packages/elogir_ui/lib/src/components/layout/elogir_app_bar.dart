import 'dart:ui' show ImageFilter;
import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A top app bar with leading/title/trailing layout.
///
/// Soft Industrial style: Glassmorphism with a thick bottom border.
class ElogirAppBar extends StatelessWidget {
  const ElogirAppBar({
    super.key,
    this.title,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.height = 64.0,
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
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: (backgroundColor ?? theme.colors.surface).withOpacity(0.8),
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
                      if (leading != null) ...[
                        leading!,
                        SizedBox(width: theme.spacing.md),
                      ],
                      if (title != null)
                        Expanded(
                          child: DefaultTextStyle.merge(
                            style: theme.typography.titleLarge.copyWith(
                              color: theme.colors.onSurface,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                            child: title!,
                          ),
                        )
                      else
                        const Spacer(),
                      if (trailing != null) ...[
                        SizedBox(width: theme.spacing.md),
                        trailing!,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
