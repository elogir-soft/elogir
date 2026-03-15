import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/devices/widgets/power_button.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Controls for a switch device: prominent power button + per-channel toggles.
///
/// Uses optimistic local state so taps give immediate visual feedback,
/// then syncs with the controller's reported state on the next update.
class SwitchControls extends StatefulWidget {
  const SwitchControls({
    required this.state,
    required this.controller,
    super.key,
  });

  final SwitchState state;
  final SwitchController controller;

  @override
  State<SwitchControls> createState() => _SwitchControlsState();
}

class _SwitchControlsState extends State<SwitchControls> {
  final Map<int, bool> _pending = {};
  final Set<int> _toggling = {};

  Future<void> _toggle(int channel, {required bool on}) async {
    if (_toggling.contains(channel)) return;
    setState(() {
      _pending[channel] = on;
      _toggling.add(channel);
    });

    try {
      if (on) {
        await widget.controller.turnOn(channel: channel);
      } else {
        await widget.controller.turnOff(channel: channel);
      }
    } on Exception {
      if (mounted) {
        setState(() => _pending.remove(channel));
        ElogirToast.show(
          context: context,
          message: 'Failed to toggle',
          variant: ElogirToastVariant.error,
        );
      }
    } finally {
      if (mounted) setState(() => _toggling.remove(channel));
    }
  }

  bool _valueFor(int channel) {
    if (_pending.containsKey(channel)) return _pending[channel]!;
    return widget.state.channels[channel] ?? false;
  }

  @override
  void didUpdateWidget(SwitchControls oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state != oldWidget.state) {
      // Only clear pending for channels not mid-toggle.
      _pending.removeWhere((ch, _) => !_toggling.contains(ch));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final channels = widget.state.channels.keys.toList()..sort();

    if (channels.isEmpty) {
      channels.add(1);
    }

    final primaryChannel = channels.first;
    final extraChannels = channels.length > 1 ? channels.sublist(1) : <int>[];

    return Column(
      children: [
        // Primary power button
        SizedBox(height: theme.spacing.lg),
        Center(
          child: PowerButton(
            isOn: _valueFor(primaryChannel),
            onChanged: (on) => _toggle(primaryChannel, on: on),
          ),
        ),
        SizedBox(height: theme.spacing.sm),
        Center(
          child: ElogirText(
            _valueFor(primaryChannel) ? 'On' : 'Off',
            variant: ElogirTextVariant.titleMedium,
            style: TextStyle(
              color: _valueFor(primaryChannel)
                  ? theme.colors.primary
                  : theme.colors.onSurfaceVariant,
            ),
          ),
        ),
        SizedBox(height: theme.spacing.lg),

        // Extra channels (multi-channel devices)
        if (extraChannels.isNotEmpty)
          ElogirCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (var i = 0; i < extraChannels.length; i++) ...[
                  if (i > 0) ElogirDivider(),
                  ElogirListTile(
                    title: ElogirText(
                      'Channel ${extraChannels[i]}',
                      variant: ElogirTextVariant.bodyMedium,
                    ),
                    trailing: ElogirSwitch(
                      value: _valueFor(extraChannels[i]),
                      onChanged: (on) =>
                          _toggle(extraChannels[i], on: on),
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
