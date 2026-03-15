import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/features/settings/providers/settings_provider.dart';
import 'package:elogir_alarm/features/settings/providers/settings_repository_provider.dart';
import 'package:elogir_alarm/features/timers/widgets/duration_input.dart';
import 'package:elogir_alarm/shared/extensions/duration_extensions.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// Screen for adding, removing, and reordering timer quickstart presets.
class EditPresetsScreen extends ConsumerStatefulWidget {
  const EditPresetsScreen({super.key});

  @override
  ConsumerState<EditPresetsScreen> createState() => _EditPresetsScreenState();
}

class _EditPresetsScreenState extends ConsumerState<EditPresetsScreen> {
  Duration _newDuration = Duration.zero;
  List<int>? _presets;

  List<int> get _currentPresets =>
      _presets ??
      ref.read(settingsProvider).value?.timerPresets ??
      AppConstants.defaultTimerPresetSeconds;

  void _updatePresets(List<int> presets) {
    setState(() => _presets = presets);
    _persist(presets);
  }

  Future<void> _persist(List<int> presets) async {
    final settings = ref.read(settingsProvider).value;
    if (settings == null) return;
    await ref
        .read(settingsRepositoryProvider)
        .updateSettings(settings.copyWith(timerPresets: presets));
  }

  void _addPreset() {
    final seconds = _newDuration.inSeconds;
    if (seconds <= 0) return;

    final presets = List<int>.from(_currentPresets);
    if (presets.contains(seconds)) return;

    presets
      ..add(seconds)
      ..sort();
    _updatePresets(presets);
  }

  void _removePreset(int seconds) {
    final presets = List<int>.from(_currentPresets)..remove(seconds);
    _updatePresets(presets);
  }

  void _reorder(int oldIndex, int newIndex) {
    final presets = List<int>.from(_currentPresets);
    var adjustedNew = newIndex;
    if (adjustedNew > oldIndex) adjustedNew--;
    final item = presets.removeAt(oldIndex);
    presets.insert(adjustedNew, item);
    _updatePresets(presets);
  }

  void _resetToDefaults() {
    _updatePresets(AppConstants.defaultTimerPresetSeconds);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    // Sync local state from provider only when we don't have local edits.
    final settings = ref.watch(settingsProvider);
    final presets = _presets ??
        settings.value?.timerPresets ??
        AppConstants.defaultTimerPresetSeconds;

    return ElogirScaffold(
      appBar: ElogirAppBar(
        leading: ElogirIconButton(
          onPressed: () => context.pop(),
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 18),
        ),
        title: const ElogirText(
          'Edit Quick Starts',
          variant: ElogirTextVariant.titleLarge,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(theme.spacing.md),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Add new preset
                ElogirText(
                  'Add Preset',
                  variant: ElogirTextVariant.titleSmall,
                  style: TextStyle(color: theme.colors.onSurfaceVariant),
                ),
                SizedBox(height: theme.spacing.sm),
                DurationInput(
                  onDurationChanged: (d) => _newDuration = d,
                ),
                SizedBox(height: theme.spacing.sm),
                ElogirButton(
                  onPressed: _addPreset,
                  expanded: true,
                  child: const Text('Add'),
                ),
                SizedBox(height: theme.spacing.xl),

                // Section label
                ElogirText(
                  'Presets',
                  variant: ElogirTextVariant.titleSmall,
                  style: TextStyle(color: theme.colors.onSurfaceVariant),
                ),
                SizedBox(height: theme.spacing.sm),
              ]),
            ),
          ),

          // Drag-to-reorder list
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
            sliver: SliverReorderableList(
              itemCount: presets.length,
              onReorder: _reorder,
              itemBuilder: (context, index) {
                final seconds = presets[index];
                final label = Duration(seconds: seconds).presetLabel;
                return Dismissible(
                  key: ValueKey(seconds),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => _removePreset(seconds),
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: theme.spacing.md),
                    decoration: BoxDecoration(
                      color: theme.colors.error,
                      borderRadius: theme.radii.md,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.trashCan,
                      size: 16,
                      color: theme.colors.onError,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: theme.spacing.xs),
                    child: ElogirCard(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.spacing.sm,
                        vertical: theme.spacing.xs,
                      ),
                      child: Row(
                        children: [
                          ReorderableDragStartListener(
                            index: index,
                            child: Padding(
                              padding: EdgeInsets.all(theme.spacing.xs),
                              child: FaIcon(
                                FontAwesomeIcons.gripVertical,
                                size: 14,
                                color: theme.colors.onSurfaceVariant,
                              ),
                            ),
                          ),
                          SizedBox(width: theme.spacing.sm),
                          Expanded(
                            child: ElogirText(label),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Reset button
          SliverPadding(
            padding: EdgeInsets.all(theme.spacing.md),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: theme.spacing.sm),
                ElogirButton(
                  onPressed: _resetToDefaults,
                  variant: ElogirButtonVariant.ghost,
                  expanded: true,
                  child: const Text('Reset to Defaults'),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
