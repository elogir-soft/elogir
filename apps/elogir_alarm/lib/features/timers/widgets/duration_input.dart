import 'dart:ui';

import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Three-drum duration picker for hours, minutes, and seconds.
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
  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;
  late final FixedExtentScrollController _secondController;

  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _hours = widget.initialDuration.inHours;
    _minutes = widget.initialDuration.inMinutes.remainder(60);
    _seconds = widget.initialDuration.inSeconds.remainder(60);

    _hourController = FixedExtentScrollController(initialItem: _hours);
    _minuteController = FixedExtentScrollController(initialItem: _minutes);
    _secondController = FixedExtentScrollController(initialItem: _seconds);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  void _notifyChanged() {
    widget.onDurationChanged(
      Duration(hours: _hours, minutes: _minutes, seconds: _seconds),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Container(
      height: 180,
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
          _LabeledDrum(
            controller: _hourController,
            itemCount: 24,
            label: 'h',
            onChanged: (v) {
              _hours = v;
              _notifyChanged();
            },
          ),
          _LabeledDrum(
            controller: _minuteController,
            itemCount: 60,
            label: 'm',
            onChanged: (v) {
              _minutes = v;
              _notifyChanged();
            },
          ),
          _LabeledDrum(
            controller: _secondController,
            itemCount: 60,
            label: 's',
            onChanged: (v) {
              _seconds = v;
              _notifyChanged();
            },
          ),
        ],
      ),
    );
  }
}

class _LabeledDrum extends StatelessWidget {
  const _LabeledDrum({
    required this.controller,
    required this.itemCount,
    required this.label,
    required this.onChanged,
  });

  final FixedExtentScrollController controller;
  final int itemCount;
  final String label;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: theme.spacing.xs),
            child: Text(
              label,
              style: theme.typography.labelSmall.copyWith(
                color: theme.colors.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 40,
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
                ListWheelScrollView.useDelegate(
                  controller: controller,
                  itemExtent: 40,
                  physics: const FixedExtentScrollPhysics(),
                  diameterRatio: 1.5,
                  onSelectedItemChanged: onChanged,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: itemCount,
                    builder: (context, index) {
                      return Center(
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          style: theme.typography.titleLarge.copyWith(
                            color: theme.colors.onSurface,
                            fontFeatures: const [
                              FontFeature.tabularFigures(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
