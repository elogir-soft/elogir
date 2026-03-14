import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// A dual-drum time picker for selecting hours (0-23) and minutes (0-59).
///
/// Delegates to the shared [WheelPicker] / [WheelDrum] widgets.
class TimePickerWheel extends StatefulWidget {
  const TimePickerWheel({
    required this.hour,
    required this.minute,
    required this.onTimeChanged,
    super.key,
  });

  final int hour;
  final int minute;
  final void Function(int hour, int minute) onTimeChanged;

  @override
  State<TimePickerWheel> createState() => _TimePickerWheelState();
}

class _TimePickerWheelState extends State<TimePickerWheel> {
  final _hourKey = GlobalKey<ElogirWheelDrumState>();
  final _minuteKey = GlobalKey<ElogirWheelDrumState>();

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirWheelPicker(
      drums: [
        ElogirWheelDrum(
          key: _hourKey,
          itemCount: 24,
          initialValue: widget.hour,
          onChanged: (h) => widget.onTimeChanged(h, widget.minute),
        ),
        ElogirWheelDrum(
          key: _minuteKey,
          itemCount: 60,
          initialValue: widget.minute,
          onChanged: (m) => widget.onTimeChanged(widget.hour, m),
        ),
      ],
      separators: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.xs),
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
}
