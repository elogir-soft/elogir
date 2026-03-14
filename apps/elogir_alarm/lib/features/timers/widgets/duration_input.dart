import 'package:elogir_alarm/shared/widgets/wheel_picker.dart';
import 'package:flutter/widgets.dart';

/// Three-drum duration picker for hours, minutes, and seconds.
///
/// Delegates to the shared [WheelPicker] / [WheelDrum] widgets.
class DurationInput extends StatefulWidget {
  const DurationInput({
    required this.onDurationChanged,
    this.initialDuration = Duration.zero,
    super.key,
  });

  final ValueChanged<Duration> onDurationChanged;
  final Duration initialDuration;

  @override
  State<DurationInput> createState() => _DurationInputState();
}

class _DurationInputState extends State<DurationInput> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _hours = widget.initialDuration.inHours;
    _minutes = widget.initialDuration.inMinutes.remainder(60);
    _seconds = widget.initialDuration.inSeconds.remainder(60);
  }

  void _notifyChanged() {
    widget.onDurationChanged(
      Duration(hours: _hours, minutes: _minutes, seconds: _seconds),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WheelPicker(
      height: 180,
      drums: [
        WheelDrum(
          itemCount: 24,
          initialValue: _hours,
          label: 'h',
          onChanged: (v) {
            _hours = v;
            _notifyChanged();
          },
        ),
        WheelDrum(
          itemCount: 60,
          initialValue: _minutes,
          label: 'm',
          onChanged: (v) {
            _minutes = v;
            _notifyChanged();
          },
        ),
        WheelDrum(
          itemCount: 60,
          initialValue: _seconds,
          label: 's',
          onChanged: (v) {
            _seconds = v;
            _notifyChanged();
          },
        ),
      ],
    );
  }
}
