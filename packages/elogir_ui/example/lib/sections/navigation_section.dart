import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

class NavigationSection extends StatefulWidget {
  const NavigationSection({super.key});

  @override
  State<NavigationSection> createState() => _NavigationSectionState();
}

class _NavigationSectionState extends State<NavigationSection> {
  int _selectedTab = 0;
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElogirDivider(label: ElogirText('Tab Bar')),
        SizedBox(height: theme.spacing.md),
        ElogirTabBar(
          tabs: const [
            ElogirTab(label: 'Overview'),
            ElogirTab(label: 'Activity'),
            ElogirTab(label: 'Settings'),
          ],
          selectedIndex: _selectedTab,
          onChanged: (i) => setState(() => _selectedTab = i),
        ),
        SizedBox(height: theme.spacing.md),
        ElogirTabBar(
          tabs: const [
            ElogirTab(label: 'Day'),
            ElogirTab(label: 'Week'),
            ElogirTab(label: 'Month'),
          ],
          selectedIndex: _selectedTab.clamp(0, 2),
          onChanged: (i) => setState(() => _selectedTab = i),
          indicatorStyle: ElogirTabIndicatorStyle.pill,
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Bottom Nav')),
        SizedBox(height: theme.spacing.md),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colors.outlineVariant,
              width: theme.strokes.thick,
            ),
            borderRadius: theme.radii.md,
          ),
          clipBehavior: Clip.antiAlias,
          child: ElogirBottomNav(
            items: const [
              ElogirBottomNavItem(icon: _NavIcon(icon: 0x1F3E0), label: 'Home'),
              ElogirBottomNavItem(
                  icon: _NavIcon(icon: 0x1F50D), label: 'Search'),
              ElogirBottomNavItem(
                  icon: _NavIcon(icon: 0x1F464), label: 'Profile'),
            ],
            selectedIndex: _bottomNavIndex,
            onChanged: (i) => setState(() => _bottomNavIndex = i),
          ),
        ),
      ],
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.icon});

  final int icon;

  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(icon),
      style: const TextStyle(fontSize: 20),
    );
  }
}
