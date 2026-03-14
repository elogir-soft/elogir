import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A minimal scaffold that provides a [body] area with an optional
/// [appBar] on top, using the theme's background color.
class ElogirScaffold extends StatelessWidget {
  const ElogirScaffold({
    super.key,
    this.appBar,
    this.body,
    this.backgroundColor,
  });

  final Widget? appBar;
  final Widget? body;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colors.background,
      ),
      child: Column(
        children: [
          ?appBar,
          if (body != null) Expanded(child: body!),
        ],
      ),
    );
  }
}
