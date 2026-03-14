import 'dart:ui';

import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// A dual-drum time picker for selecting hours (0–23) and minutes (0–59).
///
/// Uses [ListWheelScrollView] from `flutter/widgets.dart` — no Material.
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
  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(initialItem: widget.hour);
    _minuteController = FixedExtentScrollController(initialItem: widget.minute);
  }

  @override
  void didUpdateWidget(TimePickerWheel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hour != widget.hour) {
      _hourController.jumpToItem(widget.hour);
    }
    if (oldWidget.minute != widget.minute) {
      _minuteController.jumpToItem(widget.minute);
    }
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colors.outlineVariant,
          width: theme.strokes.thick,
        ),
        borderRadius: theme.radii.lg,
        color: theme.colors.surface,
      ),
      child: Row(
        children: [
          // Hours
          Expanded(
            child: _Drum(
              controller: _hourController,
              itemCount: 24,
              onChanged: (hour) =>
                  widget.onTimeChanged(hour, widget.minute),
            ),
          ),
          // Colon separator
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
          // Minutes
          Expanded(
            child: _Drum(
              controller: _minuteController,
              itemCount: 60,
              onChanged: (minute) =>
                  widget.onTimeChanged(widget.hour, minute),
            ),
          ),
        ],
      ),
    );
  }
}

class _Drum extends StatelessWidget {
  const _Drum({
    required this.controller,
    required this.itemCount,
    required this.onChanged,
  });

  final FixedExtentScrollController controller;
  final int itemCount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Stack(
      children: [
        // Selection highlight
        Center(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: theme.colors.outlineVariant,
                  width: theme.strokes.medium,
                ),
              ),
            ),
          ),
        ),
        // Wheel
        ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: 48,
          physics: const FixedExtentScrollPhysics(),
          diameterRatio: 1.5,
          onSelectedItemChanged: onChanged,
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: itemCount,
            builder: (context, index) {
              return Center(
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: theme.typography.headlineLarge.copyWith(
                    color: theme.colors.onSurface,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
