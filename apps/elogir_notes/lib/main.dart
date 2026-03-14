import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

import 'screens/notes_landing_screen.dart';

void main() {
  runApp(const ElogirNotesApp());
}

class ElogirNotesApp extends StatefulWidget {
  const ElogirNotesApp({super.key});

  @override
  State<ElogirNotesApp> createState() => _ElogirNotesAppState();
}

class _ElogirNotesAppState extends State<ElogirNotesApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElogirApp(
      title: 'Elogir Notes',
      theme: ElogirThemeData.light(),
      darkTheme: ElogirThemeData.dark(),
      themeMode: _themeMode,
      home: NotesLandingScreen(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}
