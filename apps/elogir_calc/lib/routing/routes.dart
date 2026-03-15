import 'package:elogir_calc/features/calculator/screens/calculator_screen.dart';
import 'package:elogir_calc/features/history/screens/history_screen.dart';
import 'package:elogir_calc/layout/app_shell.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedShellRoute<AppShellRoute>(
  routes: [
    TypedGoRoute<CalculatorRoute>(path: '/calculator'),
    TypedGoRoute<HistoryRoute>(path: '/history'),
  ],
)
class AppShellRoute extends ShellRouteData {
  const AppShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    return AppShell(navigator: navigator);
  }
}

class CalculatorRoute extends GoRouteData with $CalculatorRoute {
  const CalculatorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CalculatorScreen();
  }
}

class HistoryRoute extends GoRouteData with $HistoryRoute {
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HistoryScreen();
  }
}
