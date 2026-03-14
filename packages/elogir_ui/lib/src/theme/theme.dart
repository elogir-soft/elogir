import 'package:flutter/widgets.dart';

import 'theme_data.dart';

/// Distributes [ElogirThemeData] down the widget tree.
///
/// Widgets read it via `ElogirTheme.of(context)`.
class ElogirTheme extends InheritedWidget {
  const ElogirTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final ElogirThemeData data;

  /// Returns the nearest [ElogirThemeData] above [context].
  ///
  /// Throws if no [ElogirTheme] ancestor exists.
  static ElogirThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<ElogirTheme>();
    assert(widget != null, 'No ElogirTheme found in context');
    return widget!.data;
  }

  /// Returns the nearest [ElogirThemeData] or `null` if absent.
  static ElogirThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ElogirTheme>()?.data;
  }

  @override
  bool updateShouldNotify(ElogirTheme oldWidget) => data != oldWidget.data;
}
