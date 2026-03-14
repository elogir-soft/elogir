import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

import 'sections/buttons_section.dart';
import 'sections/data_display_section.dart';
import 'sections/feedback_section.dart';
import 'sections/forms_section.dart';
import 'sections/navigation_section.dart';
import 'sections/theme_section.dart';
import 'sections/typography_section.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
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
      title: 'elogir_ui Example',
      theme: ElogirThemeData.light(),
      darkTheme: ElogirThemeData.dark(),
      themeMode: _themeMode,
      home: HomePage(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirScaffold(
      appBar: ElogirAppBar(
        title: ElogirText(
          'elogir_ui Demo',
          variant: ElogirTextVariant.titleLarge,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElogirThemeModeSwitch(
              isDark: isDark,
              onChanged: (_) => onToggleTheme(),
            ),
            SizedBox(width: theme.spacing.sm),
            ElogirAvatar(
              initials: 'EU',
              size: ElogirAvatarSize.sm,
              showStatus: true,
              isOnline: true,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TypographySection(),
            SizedBox(height: theme.spacing.xl),
            const ButtonsSection(),
            SizedBox(height: theme.spacing.xl),
            const FormsSection(),
            SizedBox(height: theme.spacing.xl),
            const DataDisplaySection(),
            SizedBox(height: theme.spacing.xl),
            const FeedbackSection(),
            SizedBox(height: theme.spacing.xl),
            const NavigationSection(),
            SizedBox(height: theme.spacing.xl),
            const ThemeSection(),
            SizedBox(height: theme.spacing.xxl),
          ],
        ),
      ),
    );
  }
}
