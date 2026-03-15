import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Controls for a switch device: one toggle per channel.
///
/// Uses optimistic local state so taps give immediate visual feedback,
/// then syncs with the controller's reported state on the next update.
class SwitchControls extends StatefulWidget {
  /// Creates switch controls.
  const SwitchControls({
    required this.state,
    required this.controller,
    super.key,
  });

  /// The current switch state from the device.
  final SwitchState state;

  /// The controller for sending commands.
  final SwitchController controller;

  @override
  State<SwitchControls> createState() => _SwitchControlsState();
}

class _SwitchControlsState extends State<SwitchControls> {
  /// Local optimistic state — tracks what we've toggled before the
  /// controller confirms. Null entries mean "use controller state".
  final Map<int, bool> _pending = {};

  Future<void> _toggle(int channel, {required bool on}) async {
    // Optimistic update — show the new value immediately.
    setState(() => _pending[channel] = on);

    try {
      if (on) {
        await widget.controller.turnOn(channel: channel);
      } else {
        await widget.controller.turnOff(channel: channel);
      }
      // On success, _pending is cleared by didUpdateWidget when the
      // controller's confirmed state arrives via the provider rebuild.
    } on Exception catch (e) {
      debugPrint('Toggle failed for channel $channel: $e');
      // Revert on failure.
      if (mounted) {
        setState(() => _pending.remove(channel));
      }
    }
  }

  bool _valueFor(int channel) {
    // Prefer pending optimistic value, then controller state.
    if (_pending.containsKey(channel)) return _pending[channel]!;
    return widget.state.channels[channel] ?? false;
  }

  @override
  void didUpdateWidget(SwitchControls oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When the controller confirms new state, clear any matching
    // pending values so we track the real state again.
    if (widget.state != oldWidget.state) {
      _pending.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final channels = widget.state.channels.keys.toList()..sort();

    // If no channels reported, default to a single channel 1.
    if (channels.isEmpty) {
      channels.add(1);
    }

    return ElogirCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < channels.length; i++) ...[
            if (i > 0) ElogirDivider(),
            ElogirListTile(
              title: ElogirText(
                channels.length == 1
                    ? 'Power'
                    : 'Channel ${channels[i]}',
                variant: ElogirTextVariant.bodyMedium,
              ),
              trailing: ElogirSwitch(
                value: _valueFor(channels[i]),
                onChanged: (on) => _toggle(channels[i], on: on),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
