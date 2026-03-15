import 'package:flutter/widgets.dart';

/// Pass-through shell — with only one destination, no navigation chrome
/// is needed.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigator, super.key});

  final Widget navigator;

  @override
  Widget build(BuildContext context) => navigator;
}
