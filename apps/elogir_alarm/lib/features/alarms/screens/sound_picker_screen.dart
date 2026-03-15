import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Full-screen picker for alarm sounds with a search toolbar.
///
/// Pops with the selected sound ID string, or null if the user goes back
/// without changing.
class SoundPickerScreen extends StatefulWidget {
  const SoundPickerScreen({required this.selectedSoundId, super.key});

  final String selectedSoundId;

  @override
  State<SoundPickerScreen> createState() => _SoundPickerScreenState();
}

class _SoundPickerScreenState extends State<SoundPickerScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  List<MapEntry<String, String>> get _filtered {
    final entries = AppConstants.alarmSounds.entries.toList();
    if (_query.isEmpty) return entries;
    final q = _query.toLowerCase();
    return entries.where((e) => e.value.toLowerCase().contains(q)).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final filtered = _filtered;

    return ElogirScaffold(
      appBar: ElogirAppBar(
        leading: ElogirIconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            size: 18,
            color: theme.colors.onSurface,
          ),
        ),
        title: const ElogirText(
          'Alarm Sound',
          variant: ElogirTextVariant.titleLarge,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.md,
              vertical: theme.spacing.sm,
            ),
            child: ElogirSearchField(
              controller: _searchController,
              hint: 'Search sounds…',
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: ElogirText(
                      'No sounds found',
                      variant: ElogirTextVariant.bodyMedium,
                      style: TextStyle(
                        color: theme.colors.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: theme.spacing.sm,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final entry = filtered[index];
                      final isSelected =
                          entry.key == widget.selectedSoundId;
                      return _SoundTile(
                        label: entry.value,
                        isSelected: isSelected,
                        onTap: () =>
                            Navigator.of(context).pop(entry.key),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _SoundTile extends StatelessWidget {
  const _SoundTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.xxs),
      child: ElogirPressable(
        onPressed: onTap,
        child: AnimatedContainer(
          duration: theme.durations.fast,
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.md,
            vertical: theme.spacing.sm + theme.spacing.xs,
          ),
          decoration: BoxDecoration(
            color: isSelected ? theme.colors.primaryContainer : null,
            borderRadius: theme.radii.md,
          ),
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.music,
                size: 14,
                color: isSelected
                    ? theme.colors.onPrimaryContainer
                    : theme.colors.onSurfaceVariant,
              ),
              SizedBox(width: theme.spacing.md),
              Expanded(
                child: ElogirText(
                  label,
                  variant: ElogirTextVariant.bodyMedium,
                  style: TextStyle(
                    color: isSelected
                        ? theme.colors.onPrimaryContainer
                        : theme.colors.onSurface,
                  ),
                ),
              ),
              if (isSelected)
                FaIcon(
                  FontAwesomeIcons.check,
                  size: 14,
                  color: theme.colors.onPrimaryContainer,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
