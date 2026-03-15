import 'package:elogir_home/layout/breakpoints.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// Adaptive navigation shell wrapping all top-level destinations.
///
/// - compact: [ElogirBottomNav]
/// - medium: custom navigation rail (64dp)
/// - expanded: persistent sidebar (240dp)
class AppShell extends StatelessWidget {
  const AppShell({required this.navigator, super.key});

  final Widget navigator;

  static const _destinations = [
    _NavDestination(path: '/devices', label: 'Devices'),
    _NavDestination(path: '/automation', label: 'Automation'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (var i = 0; i < _destinations.length; i++) {
      if (location.startsWith(_destinations[i].path)) return i;
    }
    return 0;
  }

  void _onNavigate(BuildContext context, int index) {
    context.go(_destinations[index].path);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final breakpoint = Breakpoint.fromWidth(constraints.maxWidth);
        final currentIndex = _currentIndex(context);

        return switch (breakpoint) {
          Breakpoint.compact => _CompactLayout(
              navigator: navigator,
              currentIndex: currentIndex,
              onNavigate: (i) => _onNavigate(context, i),
            ),
          Breakpoint.medium => _MediumLayout(
              navigator: navigator,
              currentIndex: currentIndex,
              onNavigate: (i) => _onNavigate(context, i),
            ),
          Breakpoint.expanded => _ExpandedLayout(
              navigator: navigator,
              currentIndex: currentIndex,
              onNavigate: (i) => _onNavigate(context, i),
            ),
        };
      },
    );
  }
}

class _NavDestination {
  const _NavDestination({required this.path, required this.label});
  final String path;
  final String label;
}

// -- Compact: Bottom nav --

class _CompactLayout extends StatelessWidget {
  const _CompactLayout({
    required this.navigator,
    required this.currentIndex,
    required this.onNavigate,
  });

  final Widget navigator;
  final int currentIndex;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: navigator),
        ElogirBottomNav(
          selectedIndex: currentIndex,
          onChanged: onNavigate,
          items: const [
            ElogirBottomNavItem(
              icon: FaIcon(FontAwesomeIcons.house, size: 18),
              label: 'Devices',
            ),
            ElogirBottomNavItem(
              icon: FaIcon(FontAwesomeIcons.wandMagicSparkles, size: 18),
              label: 'Automation',
            ),
          ],
        ),
      ],
    );
  }
}

// -- Medium: Navigation rail --

class _MediumLayout extends StatelessWidget {
  const _MediumLayout({
    required this.navigator,
    required this.currentIndex,
    required this.onNavigate,
  });

  final Widget navigator;
  final int currentIndex;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Row(
      children: [
        Container(
          width: 64,
          decoration: BoxDecoration(
            color: theme.colors.surface,
            border: Border(
              right: BorderSide(
                color: theme.colors.outlineVariant,
                width: theme.strokes.thick,
              ),
            ),
          ),
          child: SafeArea(
            right: false,
            child: Column(
              children: [
                SizedBox(height: theme.spacing.md),
                _RailItem(
                  icon: FaIcon(
                    FontAwesomeIcons.house,
                    size: 18,
                    color: currentIndex == 0
                        ? theme.colors.primary
                        : theme.colors.onSurfaceVariant,
                  ),
                  label: 'Devices',
                  isSelected: currentIndex == 0,
                  onPressed: () => onNavigate(0),
                ),
                _RailItem(
                  icon: FaIcon(
                    FontAwesomeIcons.wandMagicSparkles,
                    size: 18,
                    color: currentIndex == 1
                        ? theme.colors.primary
                        : theme.colors.onSurfaceVariant,
                  ),
                  label: 'Automation',
                  isSelected: currentIndex == 1,
                  onPressed: () => onNavigate(1),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: navigator),
      ],
    );
  }
}

class _RailItem extends StatelessWidget {
  const _RailItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final Widget icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirPressable(
      onPressed: onPressed,
      pressScale: 0.95,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(height: theme.spacing.xxs),
            Text(
              label,
              style: theme.typography.labelSmall.copyWith(
                color: isSelected
                    ? theme.colors.primary
                    : theme.colors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -- Expanded: Persistent sidebar --

class _ExpandedLayout extends StatelessWidget {
  const _ExpandedLayout({
    required this.navigator,
    required this.currentIndex,
    required this.onNavigate,
  });

  final Widget navigator;
  final int currentIndex;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Row(
      children: [
        Container(
          width: 240,
          decoration: BoxDecoration(
            color: theme.colors.surface,
            border: Border(
              right: BorderSide(
                color: theme.colors.outlineVariant,
                width: theme.strokes.thick,
              ),
            ),
          ),
          child: SafeArea(
            right: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(theme.spacing.md),
                  child: const ElogirText(
                    'Home',
                    variant: ElogirTextVariant.headlineSmall,
                  ),
                ),
                ElogirDivider(),
                SizedBox(height: theme.spacing.sm),
                _SidebarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.house,
                    size: 18,
                    color: _sidebarIconColor(context, 0),
                  ),
                  label: 'Devices',
                  isSelected: currentIndex == 0,
                  onPressed: () => onNavigate(0),
                ),
                _SidebarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.wandMagicSparkles,
                    size: 18,
                    color: _sidebarIconColor(context, 1),
                  ),
                  label: 'Automation',
                  isSelected: currentIndex == 1,
                  onPressed: () => onNavigate(1),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: navigator),
      ],
    );
  }

  Color _sidebarIconColor(BuildContext context, int index) {
    final theme = ElogirTheme.of(context);
    return currentIndex == index
        ? theme.colors.primary
        : theme.colors.onSurfaceVariant;
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final Widget icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirPressable(
      onPressed: onPressed,
      pressScale: 0.98,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.md,
          vertical: theme.spacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.primaryContainer : null,
          borderRadius: theme.radii.md,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: theme.spacing.sm,
          vertical: theme.spacing.xxs,
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: theme.spacing.sm),
            Text(
              label,
              style: theme.typography.labelLarge.copyWith(
                color: isSelected
                    ? theme.colors.onPrimaryContainer
                    : theme.colors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
