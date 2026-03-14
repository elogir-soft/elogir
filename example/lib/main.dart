import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _checkboxValue = false;
  String _selectedSegment = 'all';

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
              isDark: widget.isDark,
              onChanged: (_) => widget.onToggleTheme(),
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
            // Typography
            ElogirText('Typography',
                variant: ElogirTextVariant.headlineMedium),
            SizedBox(height: theme.spacing.sm),
            ElogirText('Display Small',
                variant: ElogirTextVariant.displaySmall),
            ElogirText('Headline Small',
                variant: ElogirTextVariant.headlineSmall),
            ElogirText('Title Medium',
                variant: ElogirTextVariant.titleMedium),
            ElogirText('Body Medium (default)'),
            ElogirText('Label Large',
                variant: ElogirTextVariant.labelLarge),
            ElogirText('Caption text',
                variant: ElogirTextVariant.caption),

            SizedBox(height: theme.spacing.xl),
            ElogirDivider(label: ElogirText('Buttons')),
            SizedBox(height: theme.spacing.md),

            // Buttons
            Wrap(
              spacing: theme.spacing.sm,
              runSpacing: theme.spacing.sm,
              children: [
                ElogirButton(
                  onPressed: () {},
                  child: const Text('Filled'),
                ),
                ElogirButton(
                  variant: ElogirButtonVariant.outlined,
                  onPressed: () {},
                  child: const Text('Outlined'),
                ),
                ElogirButton(
                  variant: ElogirButtonVariant.ghost,
                  onPressed: () {},
                  child: const Text('Ghost'),
                ),
                ElogirButton(
                  onPressed: null,
                  child: const Text('Disabled'),
                ),
              ],
            ),
            SizedBox(height: theme.spacing.md),

            // Sizes
            Wrap(
              spacing: theme.spacing.sm,
              runSpacing: theme.spacing.sm,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ElogirButton(
                  size: ElogirButtonSize.sm,
                  onPressed: () {},
                  child: const Text('Small'),
                ),
                ElogirButton(
                  size: ElogirButtonSize.md,
                  onPressed: () {},
                  child: const Text('Medium'),
                ),
                ElogirButton(
                  size: ElogirButtonSize.lg,
                  onPressed: () {},
                  child: const Text('Large'),
                ),
              ],
            ),

            SizedBox(height: theme.spacing.xl),
            ElogirDivider(label: ElogirText('Forms')),
            SizedBox(height: theme.spacing.md),

            // Text fields
            ElogirTextField(
              label: 'Email address',
              hint: 'you@example.com',
              helperText: 'We\'ll never share your email.',
            ),
            SizedBox(height: theme.spacing.md),
            ElogirTextField(
              label: 'Password',
              obscureText: true,
              errorText: 'Password must be at least 8 characters',
            ),

            SizedBox(height: theme.spacing.md),
            // Checkbox & Switch
            Row(
              children: [
                ElogirCheckbox(
                  value: _checkboxValue,
                  onChanged: (v) => setState(() => _checkboxValue = v),
                  label: ElogirText('Accept terms'),
                ),
              ],
            ),

            SizedBox(height: theme.spacing.xl),
            ElogirDivider(label: ElogirText('Segmented Control')),
            SizedBox(height: theme.spacing.md),

            ElogirSegmentedControl<String>(
              segments: const [
                ElogirSegment(value: 'all', label: 'All'),
                ElogirSegment(value: 'active', label: 'Active'),
                ElogirSegment(value: 'archived', label: 'Archived'),
              ],
              selected: _selectedSegment,
              onChanged: (v) => setState(() => _selectedSegment = v),
            ),

            SizedBox(height: theme.spacing.xl),
            ElogirDivider(label: ElogirText('Data Display')),
            SizedBox(height: theme.spacing.md),

            // Avatars
            Wrap(
              spacing: theme.spacing.sm,
              runSpacing: theme.spacing.sm,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ElogirAvatar(initials: 'AB', size: ElogirAvatarSize.sm),
                ElogirAvatar(
                  initials: 'CD',
                  size: ElogirAvatarSize.md,
                  showStatus: true,
                  isOnline: true,
                ),
                ElogirAvatar(initials: 'EF', size: ElogirAvatarSize.lg),
                ElogirBadge(
                  count: 5,
                  child: ElogirAvatar(
                      initials: 'GH', size: ElogirAvatarSize.md),
                ),
              ],
            ),

            SizedBox(height: theme.spacing.md),

            // Tags
            Wrap(
              spacing: theme.spacing.sm,
              runSpacing: theme.spacing.sm,
              children: [
                ElogirTag(label: 'Default'),
                ElogirTag(
                    label: 'Primary', variant: ElogirTagVariant.primary),
                ElogirTag(
                  label: 'Success',
                  variant: ElogirTagVariant.success,
                  selected: true,
                ),
                ElogirTag(
                    label: 'Warning', variant: ElogirTagVariant.warning),
                ElogirTag(
                  label: 'Removable',
                  variant: ElogirTagVariant.error,
                  onRemoved: () {},
                ),
              ],
            ),

            SizedBox(height: theme.spacing.xl),
            ElogirDivider(label: ElogirText('Search')),
            SizedBox(height: theme.spacing.md),

            ElogirSearchField(
              hint: 'Search components…',
              onChanged: (v) {},
            ),

            SizedBox(height: theme.spacing.xl),
            ElogirDivider(label: ElogirText('Progress & Loading')),
            SizedBox(height: theme.spacing.md),

            // Progress bars
            ElogirProgressBar(
              value: 0.65,
              label: const Text('Uploading files'),
              showPercentage: true,
            ),
            SizedBox(height: theme.spacing.md),
            const ElogirProgressBar(
              value: null, // indeterminate
              height: 6,
            ),
            SizedBox(height: theme.spacing.md),

            // Spinner
            Row(
              children: [
                const ElogirSpinner(size: 20),
                SizedBox(width: theme.spacing.sm),
                const ElogirSpinner(size: 32),
                SizedBox(width: theme.spacing.sm),
                const ElogirSpinner(size: 44),
              ],
            ),

            SizedBox(height: theme.spacing.xl),
            ElogirDivider(label: ElogirText('Accordion')),
            SizedBox(height: theme.spacing.md),

            ElogirAccordionGroup(
              children: [
                ElogirAccordion(
                  title: const Text('What is Soft Industrial?'),
                  body: const Text(
                    'A design language defined by thick borders, warm neutrals, '
                    'generous spacing, and measured typography. Depth comes from '
                    'borders and layering rather than shadows.',
                  ),
                  initiallyExpanded: true,
                ),
                ElogirAccordion(
                  title: const Text('Why no Material imports?'),
                  body: const Text(
                    'Every widget is built from Flutter primitives — '
                    'GestureDetector, FocusableActionDetector, AnimatedContainer, '
                    'EditableText. This gives full control over styling and behavior.',
                  ),
                ),
                ElogirAccordion(
                  title: const Text('How do I use it?'),
                  body: const Text(
                    'Add elogir_ui as a dependency, wrap your app in ElogirApp, '
                    'and use the widgets. Customize via ElogirThemeData.',
                  ),
                ),
              ],
            ),

            SizedBox(height: theme.spacing.xl),
            ElogirDivider(label: ElogirText('Tooltip')),
            SizedBox(height: theme.spacing.md),

            Wrap(
              spacing: theme.spacing.md,
              runSpacing: theme.spacing.sm,
              children: [
                ElogirTooltip(
                  message: 'This is a tooltip above',
                  child: ElogirButton(
                    variant: ElogirButtonVariant.outlined,
                    size: ElogirButtonSize.sm,
                    onPressed: () {},
                    child: const Text('Hover me'),
                  ),
                ),
                ElogirTooltip(
                  message: 'Tooltip below the button',
                  position: ElogirTooltipPosition.below,
                  child: ElogirButton(
                    variant: ElogirButtonVariant.ghost,
                    size: ElogirButtonSize.sm,
                    onPressed: () {},
                    child: const Text('Below tooltip'),
                  ),
                ),
              ],
            ),

            SizedBox(height: theme.spacing.xl),
            ElogirDivider(label: ElogirText('Toast & Card & Dialog')),
            SizedBox(height: theme.spacing.md),

            // Toast triggers
            Wrap(
              spacing: theme.spacing.sm,
              runSpacing: theme.spacing.sm,
              children: [
                ElogirButton(
                  size: ElogirButtonSize.sm,
                  onPressed: () {
                    ElogirToast.show(
                      context: context,
                      message: 'This is an info toast',
                    );
                  },
                  child: const Text('Info Toast'),
                ),
                ElogirButton(
                  size: ElogirButtonSize.sm,
                  variant: ElogirButtonVariant.outlined,
                  onPressed: () {
                    ElogirToast.show(
                      context: context,
                      message: 'Operation completed!',
                      variant: ElogirToastVariant.success,
                    );
                  },
                  child: const Text('Success Toast'),
                ),
                ElogirButton(
                  size: ElogirButtonSize.sm,
                  variant: ElogirButtonVariant.outlined,
                  onPressed: () {
                    ElogirToast.show(
                      context: context,
                      message: 'Check your input',
                      variant: ElogirToastVariant.warning,
                    );
                  },
                  child: const Text('Warning Toast'),
                ),
                ElogirButton(
                  size: ElogirButtonSize.sm,
                  variant: ElogirButtonVariant.ghost,
                  onPressed: () {
                    ElogirToast.show(
                      context: context,
                      message: 'Something went wrong',
                      variant: ElogirToastVariant.error,
                    );
                  },
                  child: const Text('Error Toast'),
                ),
              ],
            ),

            SizedBox(height: theme.spacing.md),

            // Card
            ElogirCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElogirText('Card Title',
                      variant: ElogirTextVariant.titleMedium),
                  SizedBox(height: theme.spacing.xs),
                  ElogirText(
                    'This is a card built entirely from Flutter primitives. '
                    'No Material, no Cupertino — just the Soft Industrial style.',
                  ),
                  SizedBox(height: theme.spacing.md),
                  ElogirButton(
                    variant: ElogirButtonVariant.outlined,
                    size: ElogirButtonSize.sm,
                    onPressed: () {
                      ElogirDialog.show(
                        context: context,
                        builder: (_) => ElogirDialog(
                          title: const Text('Hello'),
                          content: const Text(
                            'This dialog is built from Flutter primitives with '
                            'the Soft Industrial style.',
                          ),
                          actions: [
                            ElogirButton(
                              variant: ElogirButtonVariant.ghost,
                              size: ElogirButtonSize.sm,
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            ElogirButton(
                              size: ElogirButtonSize.sm,
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Show Dialog'),
                  ),
                ],
              ),
            ),

            SizedBox(height: theme.spacing.xl),
            ElogirDivider(label: ElogirText('Theme Colors')),
            SizedBox(height: theme.spacing.md),

            // Theme color showcase
            const ElogirThemeShowcase(),

            SizedBox(height: theme.spacing.xxl),
          ],
        ),
      ),
    );
  }
}
