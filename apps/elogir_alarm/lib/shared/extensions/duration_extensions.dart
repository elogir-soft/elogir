/// Extensions on [Duration] for formatting time displays.
extension DurationFormatting on Duration {
  /// Formats as `HH:MM:SS` or `MM:SS` if under an hour.
  String get formatted {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  /// Formats as `MM:SS.cc` (centiseconds) for stopwatch display.
  String get stopwatchFormatted {
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);
    final centiseconds = (inMilliseconds.remainder(1000) ~/ 10);

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}.'
        '${centiseconds.toString().padLeft(2, '0')}';
  }

  /// Human-readable relative format like "in 6h 32m".
  String get relativeFormatted {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);

    if (hours > 0 && minutes > 0) return 'in ${hours}h ${minutes}m';
    if (hours > 0) return 'in ${hours}h';
    if (minutes > 0) return 'in ${minutes}m';
    return 'in < 1m';
  }

  /// Format preset duration for display (e.g., "5 min", "1 hr").
  String get presetLabel {
    if (inMinutes >= 60) {
      final hours = inHours;
      return '$hours hr';
    }
    return '${inMinutes} min';
  }
}
