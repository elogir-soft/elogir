import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(5) int defaultSnoozeMinutes,
    @Default(false) bool keepScreenOnStopwatch,
    @Default('marimba') String timerSoundId,
    /// One of 'system', 'light', 'dark'.
    @Default('system') String themeMode,
    @Default(false) bool use24HourFormat,
    @Default(true) bool weekStartsOnMonday,
    @Default([60, 180, 300, 600, 900, 1800, 3600]) List<int> timerPresets,
  }) = _AppSettings;
}
