import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// Three-dot overflow menu with a Settings item.
class AppOverflowMenu extends StatelessWidget {
  const AppOverflowMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ElogirPopupMenu(
      items: [
        ElogirPopupMenuItem(
          icon: const FaIcon(FontAwesomeIcons.gear, size: 16),
          label: 'Settings',
          onPressed: () => context.push('/settings'),
        ),
      ],
    );
  }
}
