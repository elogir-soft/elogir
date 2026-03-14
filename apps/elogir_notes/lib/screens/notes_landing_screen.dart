import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

class NotesLandingScreen extends StatefulWidget {
  const NotesLandingScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<NotesLandingScreen> createState() => _NotesLandingScreenState();
}

class _NotesLandingScreenState extends State<NotesLandingScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  final List<({String title, String body})> _notes = [
    (
      title: 'Welcome to Elogir Notes',
      body: 'This app tests the monorepo setup.',
    ),
    (
      title: 'Soft Industrial',
      body: 'Thick borders, warm neutrals, generous spacing.',
    ),
    (
      title: 'Pure Flutter',
      body: 'Zero Material or Cupertino imports.',
    ),
  ];

  void _addNote() {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();
    if (title.isEmpty) return;

    setState(() {
      _notes.insert(
        0,
        (title: title, body: body.isEmpty ? 'No content' : body),
      );
      _titleController.clear();
      _bodyController.clear();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirScaffold(
      appBar: ElogirAppBar(
        title: ElogirText(
          'Notes',
          variant: ElogirTextVariant.titleLarge,
        ),
        trailing: ElogirThemeModeSwitch(
          isDark: widget.isDark,
          onChanged: (_) => widget.onToggleTheme(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          children: [
            // Input area
            ElogirCard(
              child: Column(
                children: [
                  ElogirTextField(
                    controller: _titleController,
                    label: 'Title',
                    hint: 'Note title...',
                  ),
                  SizedBox(height: theme.spacing.sm),
                  ElogirTextField(
                    controller: _bodyController,
                    label: 'Body',
                    hint: 'Write something...',
                    maxLines: 3,
                  ),
                  SizedBox(height: theme.spacing.md),
                  ElogirButton(
                    onPressed: _addNote,
                    expanded: true,
                    child: ElogirText(
                      'Add Note',
                      variant: ElogirTextVariant.labelLarge,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: theme.spacing.lg),

            // Notes list
            Expanded(
              child: ListView.separated(
                itemCount: _notes.length,
                separatorBuilder: (_, _) =>
                    SizedBox(height: theme.spacing.sm),
                itemBuilder: (context, index) {
                  final note = _notes[index];
                  return ElogirCard(
                    semanticsLabel: 'Note: ${note.title}',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElogirText(
                          note.title,
                          variant: ElogirTextVariant.titleMedium,
                        ),
                        SizedBox(height: theme.spacing.xs),
                        ElogirText(
                          note.body,
                          variant: ElogirTextVariant.bodyMedium,
                          style: TextStyle(
                            color: theme.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
