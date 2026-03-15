import 'package:elogir_home/features/settings/models/app_settings.dart';
import 'package:elogir_home/features/settings/providers/settings_provider.dart';
import 'package:elogir_home/features/settings/providers/settings_repository_provider.dart';
import 'package:elogir_home/features/setup/providers/credentials_service_provider.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App settings screen.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);

    return settingsAsync.when(
      loading: () => const ElogirScaffold(
        appBar: ElogirAppBar(
          title: ElogirText('Settings', variant: ElogirTextVariant.titleLarge),
        ),
        body: SizedBox.shrink(),
      ),
      error: (e, _) => ElogirScaffold(
        appBar: const ElogirAppBar(
          title:
              ElogirText('Settings', variant: ElogirTextVariant.titleLarge),
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ElogirTheme.of(context);
    final credentialsService = ref.watch(credentialsServiceProvider);

    return ElogirScaffold(
      appBar: const ElogirAppBar(
        title: ElogirText('Settings', variant: ElogirTextVariant.titleLarge),
      ),
      body: ListView(
        padding: EdgeInsets.all(theme.spacing.md),
        children: [
          // ── Appearance ───────────────────────────────────────────────────
          _SectionLabel('Appearance'),
          SizedBox(height: theme.spacing.xs),
          ElogirCard(
            padding: EdgeInsets.zero,
            child: ElogirListTile(
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
          ),

          SizedBox(height: theme.spacing.lg),

          // ── Tuya Credentials ─────────────────────────────────────────────
          _SectionLabel('Tuya Credentials'),
          SizedBox(height: theme.spacing.xs),
          ElogirCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                FutureBuilder<bool>(
                  future: credentialsService.hasTuyaCredentials(),
                  builder: (context, snapshot) {
                    final hasCreds = snapshot.data ?? false;
                    return ElogirListTile(
                      title: ElogirText(
                        hasCreds ? 'Credentials saved' : 'No credentials',
                        variant: ElogirTextVariant.bodyMedium,
                      ),
                      trailing: hasCreds
                          ? ElogirButton(
                              variant: ElogirButtonVariant.outlined,
                              size: ElogirButtonSize.sm,
                              onPressed: () async {
                                await credentialsService
                                    .deleteTuyaCredentials();
                                // Force rebuild to show updated state.
                                if (context.mounted) {
                                  (context as Element).markNeedsBuild();
                                }
                              },
                              child: const Text('Clear'),
                            )
                          : const ElogirText(
                              'Set up in Add Device',
                              variant: ElogirTextVariant.bodySmall,
                            ),
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: theme.spacing.lg),

          // ── About ────────────────────────────────────────────────────────
          _SectionLabel('About'),
          SizedBox(height: theme.spacing.xs),
          ElogirCard(
            padding: EdgeInsets.zero,
            child: const ElogirListTile(
              title: ElogirText(
                'Version',
                variant: ElogirTextVariant.bodyMedium,
              ),
              trailing: ElogirText(
                '0.1.0',
                variant: ElogirTextVariant.bodyMedium,
              ),
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
