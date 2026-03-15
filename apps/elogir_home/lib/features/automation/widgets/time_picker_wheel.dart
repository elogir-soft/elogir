import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// A dual-drum time picker for selecting hours and minutes.
///
/// When [use24HourFormat] is false, shows a 12-item hour drum with custom
/// labels ("01"–"12") and an AM/PM segmented control below.
class TimePickerWheel extends StatefulWidget {
  /// Creates a time picker wheel.
  const TimePickerWheel({
    required this.hour,
    required this.minute,
    required this.onTimeChanged,
    required this.use24HourFormat,
    super.key,
  });

  /// Current hour (0–23, always 24h internally).
  final int hour;

  /// Current minute (0–59).
  final int minute;

  /// Called when the user changes the time.
  final void Function(int hour, int minute) onTimeChanged;

  /// Whether to show 24-hour or 12-hour format.
  final bool use24HourFormat;

  @override
  State<TimePickerWheel> createState() => _TimePickerWheelState();
}

class _TimePickerWheelState extends State<TimePickerWheel> {
  // 12h state — kept in sync with widget.hour so that changing AM/PM
  // or switching modes produces the right 24h output.
  late int _amPm; // 0 = AM, 1 = PM
  late int _drumHourIndex; // 0 = "1", 1 = "2", …, 11 = "12"

  @override
  void initState() {
    super.initState();
    _amPm = widget.hour < 12 ? 0 : 1;
    _drumHourIndex = _to12hIndex(widget.hour);
  }

  @override
  void didUpdateWidget(TimePickerWheel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hour != oldWidget.hour) {
      _amPm = widget.hour < 12 ? 0 : 1;
      _drumHourIndex = _to12hIndex(widget.hour);
    }
  }

  // Convert 24h hour → 12h drum index.
  int _to12hIndex(int hour) {
    final h = hour % 12;
    return h == 0 ? 11 : h - 1;
  }

  // Convert 12h drum index + amPm → 24h hour.
  int _to24h(int drumIndex, int amPm) {
    final h = drumIndex + 1;
    if (amPm == 0) return h == 12 ? 0 : h;
    return h == 12 ? 12 : h + 12;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    if (widget.use24HourFormat) {
      return ElogirWheelPicker(
        drums: [
          ElogirWheelDrum(
            key: const ValueKey('hour-24'),
            itemCount: 24,
            initialValue: widget.hour,
            onChanged: (h) =>
                widget.onTimeChanged(h, widget.minute),
          ),
          ElogirWheelDrum(
            key: const ValueKey('minute'),
            itemCount: 60,
            initialValue: widget.minute,
            onChanged: (m) =>
                widget.onTimeChanged(widget.hour, m),
          ),
        ],
        separators: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.xs,
            ),
            child: Text(
              ':',
              style: theme.typography.displayMedium.copyWith(
                color: theme.colors.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      );
    }

    // 12h mode: drum for hours + minutes, then AM/PM below.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElogirWheelPicker(
          drums: [
            ElogirWheelDrum(
              key: const ValueKey('hour-12'),
              itemCount: 12,
              initialValue: _drumHourIndex,
              labelBuilder: (i) =>
                  (i + 1).toString().padLeft(2, '0'),
              onChanged: (drumIndex) {
                _drumHourIndex = drumIndex;
                widget.onTimeChanged(
                  _to24h(drumIndex, _amPm),
                  widget.minute,
                );
              },
            ),
            ElogirWheelDrum(
              key: const ValueKey('minute'),
              itemCount: 60,
              initialValue: widget.minute,
              onChanged: (m) => widget.onTimeChanged(
                _to24h(_drumHourIndex, _amPm),
                m,
              ),
            ),
          ],
          separators: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.xs,
              ),
              child: Text(
                ':',
                style: theme.typography.displayMedium.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.sm),
        SizedBox(
          width: 160,
          child: ElogirSegmentedControl<int>(
            selected: _amPm,
            segments: const [
              ElogirSegment(value: 0, label: 'AM'),
              ElogirSegment(value: 1, label: 'PM'),
            ],
            onChanged: (amPm) {
              setState(() => _amPm = amPm);
              widget.onTimeChanged(
                _to24h(_drumHourIndex, amPm),
                widget.minute,
              );
            },
          ),
        ),
      ],
    );
  }
}
