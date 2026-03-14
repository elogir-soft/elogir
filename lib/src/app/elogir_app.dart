import 'dart:ui' show Brightness, PlatformDispatcher;

import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import '../theme/theme_data.dart';

/// Top-level app widget wrapping [WidgetsApp].
///
/// Provides theme injection (light/dark + auto), navigation, localization
/// hooks, and a default text style — without pulling in Material or Cupertino.
class ElogirApp extends StatefulWidget {
  const ElogirApp({
    super.key,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.home,
    this.navigatorKey,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.initialRoute,
    this.navigatorObservers = const [],
    this.routes = const {},
    this.title = '',
    this.locale,
    this.localizationsDelegates,
    this.supportedLocales = const [Locale('en', 'US')],
    this.debugShowCheckedModeBanner = true,
  });

  final ElogirThemeData? theme;
  final ElogirThemeData? darkTheme;
  final ThemeMode themeMode;

  final Widget? home;
  final GlobalKey<NavigatorState>? navigatorKey;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;
  final String? initialRoute;
  final List<NavigatorObserver> navigatorObservers;
  final Map<String, WidgetBuilder> routes;
  final String title;

  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;
  final bool debugShowCheckedModeBanner;

  @override
  State<ElogirApp> createState() => _ElogirAppState();
}

/// Theme mode selector — mirrors Material's enum.
enum ThemeMode { system, light, dark }

class _ElogirAppState extends State<ElogirApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    // Rebuild when system brightness changes.
    setState(() {});
  }

  ElogirThemeData _resolveTheme() {
    final light = widget.theme ?? ElogirThemeData.light();
    final dark = widget.darkTheme ?? ElogirThemeData.dark();

    switch (widget.themeMode) {
      case ThemeMode.light:
        return light;
      case ThemeMode.dark:
        return dark;
      case ThemeMode.system:
        final platformBrightness =
            PlatformDispatcher.instance.platformBrightness;
        return platformBrightness == Brightness.dark ? dark : light;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = _resolveTheme();

    return ElogirTheme(
      data: themeData,
      child: WidgetsApp(
        key: GlobalObjectKey(this),
        navigatorKey: widget.navigatorKey,
        title: widget.title,
        color: themeData.colors.primary,
        initialRoute: widget.initialRoute,
        routes: widget.routes,
        navigatorObservers: widget.navigatorObservers,
        locale: widget.locale,
        supportedLocales: widget.supportedLocales,
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        onGenerateRoute: widget.onGenerateRoute ??
            (widget.home != null
                ? (settings) {
                    if (settings.name == Navigator.defaultRouteName) {
                      return PageRouteBuilder(
                        settings: settings,
                        pageBuilder: (context, animation, secondaryAnimation) => widget.home!,
                      );
                    }
                    return null;
                  }
                : null),
        onUnknownRoute: widget.onUnknownRoute,
        builder: (context, child) {
          return DefaultTextStyle(
            style: themeData.typography.bodyMedium.copyWith(
              color: themeData.colors.onBackground,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(color: themeData.colors.background),
              child: child ?? const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
