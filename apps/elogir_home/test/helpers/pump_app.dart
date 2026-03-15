// ignore_for_file: always_specify_types, depend_on_referenced_packages

import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/src/framework.dart' show Override;

/// Test helper that wraps a widget in the full app shell with theme
/// and providers.
extension PumpApp on WidgetTester {
  /// Pumps [widget] inside a [ProviderScope] + [ElogirApp] with theme.
  Future<void> pumpApp(
    Widget widget, {
    List<Override> overrides = const [],
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: ElogirApp(
          theme: ElogirThemeData.light(),
          darkTheme: ElogirThemeData.dark(),
          home: widget,
        ),
      ),
    );
  }
}
