import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/features/alarms/screens/sound_picker_screen.dart';
import 'package:elogir_alarm/features/settings/models/app_settings.dart';
import 'package:elogir_alarm/features/settings/providers/settings_provider.dart';
import 'package:elogir_alarm/features/settings/providers/settings_repository_provider.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// App settings screen.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);

    return settingsAsync.when(
      loading: () => ElogirScaffold(
        appBar: ElogirAppBar(
          leading: ElogirIconButton(
            onPressed: () => context.pop(),
            icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 18),
          ),
          title: const ElogirText(
            'Settings',
            variant: ElogirTextVariant.titleLarge,
          ),
        ),
        body: const SizedBox.shrink(),
      ),
      error: (e, _) => ElogirScaffold(
        appBar: ElogirAppBar(
          leading: ElogirIconButton(
            onPressed: () => context.pop(),
            icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 18),
          ),
          title: const ElogirText(
            'Settings',
            variant: ElogirTextVariant.titleLarge,
          ),
        ),
        body: Center(
          child: ElogirText('Failed to load settings'),
        ),
      ),
      data: (settings) => _SettingsContent(settings: settings),
    );
  }
}

class _SettingsContent extends ConsumerWidget {
  const _SettingsContent({required this.settings});

  final AppSettings settings;

  void _update(WidgetRef ref, AppSettings updated) {
    ref.read(settingsRepositoryProvider).updateSettings(updated);
  }

  Future<void> _openTimerSoundPicker(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final result = await Navigator.of(context, rootNavigator: true)
        .push<String>(
      PageRouteBuilder<String>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SoundPickerScreen(selectedSoundId: settings.timerSoundId),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
      ),
    );
    if (result != null) {
      _update(ref, settings.copyWith(timerSoundId: result));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ElogirTheme.of(context);

    return ElogirScaffold(
      appBar: ElogirAppBar(
        leading: ElogirIconButton(
          onPressed: () => context.pop(),
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 18),
        ),
        title: const ElogirText(
          'Settings',
          variant: ElogirTextVariant.titleLarge,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(theme.spacing.md),
        children: [
          // ── Alarms ──────────────────────────────────────────────────────
          _SectionLabel('Alarms'),
          SizedBox(height: theme.spacing.xs),
          ElogirCard(
            padding: EdgeInsets.zero,
            child: ElogirListTile(
              title: const ElogirText(
                'Default snooze',
                variant: ElogirTextVariant.bodyMedium,
              ),
              trailing: SizedBox(
                width: 120,
                child: ElogirDropdown<int>(
                  value: settings.defaultSnoozeMinutes,
                  options: const [
                    ElogirDropdownOption(value: 5, label: '5 min'),
                    ElogirDropdownOption(value: 10, label: '10 min'),
                    ElogirDropdownOption(value: 15, label: '15 min'),
                    ElogirDropdownOption(value: 20, label: '20 min'),
                    ElogirDropdownOption(value: 30, label: '30 min'),
                  ],
                  onChanged: (v) =>
                      _update(ref, settings.copyWith(defaultSnoozeMinutes: v)),
                ),
              ),
            ),
          ),

          SizedBox(height: theme.spacing.lg),

          // ── Timers ─────────────────────────────────────────────────────
          _SectionLabel('Timers'),
          SizedBox(height: theme.spacing.xs),
          ElogirCard(
            padding: EdgeInsets.zero,
            child: ElogirListTile(
              title: const ElogirText(
                'Timer sound',
                variant: ElogirTextVariant.bodyMedium,
              ),
              trailing: ElogirPressable(
                onPressed: () => _openTimerSoundPicker(context, ref),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElogirText(
                      AppConstants.alarmSounds[settings.timerSoundId] ??
                          settings.timerSoundId,
                      variant: ElogirTextVariant.bodyMedium,
                      style: TextStyle(
                        color: theme.colors.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: theme.spacing.xs),
                    FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 10,
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: theme.spacing.lg),

          // ── Stopwatch ────────────────────────────────────────────────────
          _SectionLabel('Stopwatch'),
          SizedBox(height: theme.spacing.xs),
          ElogirCard(
            padding: EdgeInsets.zero,
            child: ElogirListTile(
              title: const ElogirText(
                'Keep screen on',
                variant: ElogirTextVariant.bodyMedium,
              ),
              trailing: ElogirSwitch(
                value: settings.keepScreenOnStopwatch,
                onChanged: (v) =>
                    _update(ref, settings.copyWith(keepScreenOnStopwatch: v)),
              ),
            ),
          ),

          SizedBox(height: theme.spacing.lg),

          // ── Appearance ───────────────────────────────────────────────────
          _SectionLabel('Appearance'),
          SizedBox(height: theme.spacing.xs),
          ElogirCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ElogirListTile(
                  title: const ElogirText(
                    'Theme',
                    variant: ElogirTextVariant.bodyMedium,
                  ),
                  trailing: SizedBox(
                    width: 200,
                    child: ElogirSegmentedControl<String>(
                      selected: settings.themeMode,
                      segments: const [
                        ElogirSegment(value: 'system', label: 'System'),
                        ElogirSegment(value: 'light', label: 'Light'),
                        ElogirSegment(value: 'dark', label: 'Dark'),
                      ],
                      onChanged: (v) =>
                          _update(ref, settings.copyWith(themeMode: v)),
                    ),
                  ),
                ),
                ElogirDivider(),
                ElogirListTile(
                  title: const ElogirText(
                    '24-hour clock',
                    variant: ElogirTextVariant.bodyMedium,
                  ),
                  trailing: ElogirSwitch(
                    value: settings.use24HourFormat,
                    onChanged: (v) =>
                        _update(ref, settings.copyWith(use24HourFormat: v)),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: theme.spacing.lg),

          // ── General ──────────────────────────────────────────────────────
          _SectionLabel('General'),
          SizedBox(height: theme.spacing.xs),
          ElogirCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ElogirListTile(
                  title: const ElogirText(
                    'Week starts on',
                    variant: ElogirTextVariant.bodyMedium,
                  ),
                  trailing: SizedBox(
                    width: 180,
                    child: ElogirSegmentedControl<bool>(
                      selected: settings.weekStartsOnMonday,
                      segments: const [
                        ElogirSegment(value: true, label: 'Monday'),
                        ElogirSegment(value: false, label: 'Sunday'),
                      ],
                      onChanged: (v) =>
                          _update(ref, settings.copyWith(weekStartsOnMonday: v)),
                    ),
                  ),
                ),
                ElogirDivider(),
                const ElogirListTile(
                  title: ElogirText(
                    'Version',
                    variant: ElogirTextVariant.bodyMedium,
                  ),
                  trailing: ElogirText(
                    '0.1.0',
                    variant: ElogirTextVariant.bodyMedium,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: theme.spacing.xl),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: theme.spacing.xs),
      child: ElogirText(
        text,
        variant: ElogirTextVariant.labelLarge,
        style: TextStyle(color: theme.colors.onSurfaceVariant),
      ),
    );
  }
}
