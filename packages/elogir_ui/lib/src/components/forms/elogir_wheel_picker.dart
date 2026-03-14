import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A single scrollable drum displaying zero-padded numbers.
///
/// Used by both the alarm time picker and the timer duration picker.
/// Each drum shows [itemCount] items (0 to itemCount-1) and notifies
/// [onChanged] when the selected item changes.
class ElogirWheelDrum extends StatefulWidget {
  const ElogirWheelDrum({
    super.key,
    required this.itemCount,
    required this.onChanged,
    this.initialValue = 0,
    this.label,
    this.itemExtent = 44,
  });

  /// Number of items in the wheel (e.g. 24 for hours, 60 for minutes).
  final int itemCount;

  /// Called when the selected value changes.
  final ValueChanged<int> onChanged;

  /// Initial selected value.
  final int initialValue;

  /// Optional label shown below the drum (e.g. 'h', 'm', 's').
  final String? label;

  /// Height of each item in the wheel.
  final double itemExtent;

  @override
  State<ElogirWheelDrum> createState() => ElogirWheelDrumState();
}

class ElogirWheelDrumState extends State<ElogirWheelDrum> {
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Jump to a specific value without animation.
  void jumpTo(int value) {
    if (_controller.hasClients) {
      _controller.jumpToItem(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Expanded(
      child: Column(
        children: [
          if (widget.label != null)
            Padding(
              padding: EdgeInsets.only(top: theme.spacing.xs),
              child: Text(
                widget.label!,
                style: theme.typography.labelSmall.copyWith(
                  color: theme.colors.onSurfaceVariant,
                ),
              ),
            ),
          Expanded(
            child: Stack(
              children: [
                // Selection highlight band.
                Center(
                  child: Container(
                    height: widget.itemExtent,
                    decoration: BoxDecoration(
                      color: theme.colors.primaryContainer.withValues(
                        alpha: 0.3,
                      ),
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: theme.colors.outlineVariant,
                          width: theme.strokes.medium,
                        ),
                      ),
                    ),
                  ),
                ),
                // The scrollable wheel.
                ListWheelScrollView.useDelegate(
                  controller: _controller,
                  itemExtent: widget.itemExtent,
                  physics: const FixedExtentScrollPhysics(),
                  diameterRatio: 1.2,
                  perspective: 0.003,
                  onSelectedItemChanged: widget.onChanged,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: widget.itemCount,
                    builder: (context, index) {
                      return Center(
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          style: theme.typography.headlineLarge.copyWith(
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

/// A multi-drum wheel picker for selecting time or duration values.
///
/// Wraps one or more [ElogirWheelDrum]s in a themed container with optional
/// separator text between drums.
class ElogirWheelPicker extends StatelessWidget {
  const ElogirWheelPicker({
    super.key,
    required this.drums,
    this.separators = const [],
    this.height = 200,
  });

  /// The drums to display side by side.
  final List<Widget> drums;

  /// Separator widgets placed between drums (e.g. ':' text).
  /// Length should be drums.length - 1 or fewer.
  final List<Widget> separators;

  /// Total height of the picker.
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    final children = <Widget>[];
    for (var i = 0; i < drums.length; i++) {
      children.add(drums[i]);
      if (i < separators.length) {
        children.add(separators[i]);
      }
    }

    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colors.outlineVariant,
          width: theme.strokes.thick,
        ),
        borderRadius: theme.radii.lg,
        color: theme.colors.surface,
      ),
      child: Row(children: children),
    );
  }
}
