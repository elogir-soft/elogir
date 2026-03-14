import 'package:freezed_annotation/freezed_annotation.dart';

part 'lap.freezed.dart';
part 'lap.g.dart';

/// A single lap recorded by the stopwatch.
@freezed
abstract class Lap with _$Lap {
  const factory Lap({
    /// Lap number (1-indexed).
    required int number,

    /// Absolute elapsed time at the moment this lap was recorded.
    @_DurationConverter() required Duration elapsed,

    /// Time since the previous lap (or from start for lap 1).
    @_DurationConverter() required Duration delta,
  }) = _Lap;

  factory Lap.fromJson(Map<String, dynamic> json) => _$LapFromJson(json);
}

/// Converts Duration to/from microseconds for JSON serialization.
class _DurationConverter implements JsonConverter<Duration, int> {
  const _DurationConverter();

  @override
  Duration fromJson(int json) => Duration(microseconds: json);

  @override
  int toJson(Duration object) => object.inMicroseconds;
}
