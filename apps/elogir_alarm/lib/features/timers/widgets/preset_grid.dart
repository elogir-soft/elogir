import 'package:elogir_alarm/features/timers/providers/timer_presets_provider.dart';
import 'package:elogir_alarm/routing/routes.dart';
import 'package:elogir_alarm/shared/extensions/duration_extensions.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Grid of quick-start timer preset chips.
class PresetGrid extends ConsumerWidget {
  const PresetGrid({required this.onPresetSelected, super.key});

  /// Called with the preset duration in milliseconds.
  final ValueChanged<int> onPresetSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ElogirTheme.of(context);
    final presets = ref.watch(timerPresetsProvider);

    return Wrap(
      spacing: theme.spacing.sm,
      runSpacing: theme.spacing.sm,
      children: [
        ...presets.map((seconds) {
          final duration = Duration(seconds: seconds);
          return ElogirButton(
            onPressed: () => onPresetSelected(seconds * 1000),
            variant: ElogirButtonVariant.tonal,
            size: ElogirButtonSize.md,
            child: Text(duration.presetLabel),
          );
        }),
        ElogirIconButton(
          onPressed: () => const EditPresetsRoute().push(context),
          variant: ElogirIconButtonVariant.ghost,
          size: ElogirIconButtonSize.sm,
          icon: FaIcon(
            FontAwesomeIcons.penToSquare,
            size: 14,
            color: theme.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
