import 'package:elogir_alarm/shared/widgets/nav_icons.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Three-dot overflow menu with a Settings entry.
class AppOverflowMenu extends StatelessWidget {
  const AppOverflowMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ElogirPopupMenu(
      items: [
        ElogirPopupMenuItem(
          icon: const SettingsIcon(size: 16),
          label: 'Settings',
          onPressed: () => context.push('/settings'),
        ),
      ],
    );
  }
}
