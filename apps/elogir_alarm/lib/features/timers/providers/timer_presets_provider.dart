import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/features/settings/providers/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_presets_provider.g.dart';

@riverpod
List<int> timerPresets(Ref ref) {
  final settings = ref.watch(settingsProvider);
  return settings.value?.timerPresets ??
      AppConstants.defaultTimerPresetSeconds;
}
