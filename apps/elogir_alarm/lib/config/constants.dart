/// App-wide constants for elogir_alarm.
abstract final class AppConstants {
  /// Database file name.
  static const String databaseName = 'elogir_alarm.db';

  /// Default snooze duration in minutes.
  static const int defaultSnoozeDurationMinutes = 5;

  /// Minimum snooze duration in minutes.
  static const int minSnoozeDurationMinutes = 1;

  /// Maximum snooze duration in minutes.
  static const int maxSnoozeDurationMinutes = 30;

  /// How often to persist running timer state to Drift (milliseconds).
  static const int timerPersistIntervalMs = 5000;

  /// Timer tick interval (milliseconds).
  static const int timerTickIntervalMs = 100;

  /// Stopwatch tick interval (milliseconds).
  static const int stopwatchTickIntervalMs = 16; // ~60fps

  /// Default timer preset durations in seconds.
  static const List<int> defaultTimerPresetSeconds = [
    60, // 1 min
    180, // 3 min
    300, // 5 min
    600, // 10 min
    900, // 15 min
    1800, // 30 min
    3600, // 1 hour
  ];

  /// Available alarm sounds mapped to display names.
  /// Keys are asset filenames (without extension).
  static const Map<String, String> alarmSounds = {
    'marimba': 'Marimba',
    'mozart': 'Mozart',
    'nokia': 'Nokia',
    'one_piece': 'One Piece',
    'star_wars': 'Star Wars',
  };

  /// Returns the asset path for a given sound ID, with fallback to marimba.
  static String soundAssetPath(String soundId) {
    final id = alarmSounds.containsKey(soundId) ? soundId : 'marimba';
    return 'assets/$id.mp3';
  }
}
