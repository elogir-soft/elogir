import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/devices/providers/device_controller_provider.dart';
import 'package:elogir_home/features/devices/widgets/device_type_icon.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// A device card for switches that toggles on tap and shows ON/OFF via color.
///
/// Long press navigates to the device detail screen.
class SwitchDeviceCard extends ConsumerStatefulWidget {
  const SwitchDeviceCard({required this.device, super.key});

  final SmartDevice device;

  @override
  ConsumerState<SwitchDeviceCard> createState() => _SwitchDeviceCardState();
}

class _SwitchDeviceCardState extends ConsumerState<SwitchDeviceCard> {
  bool? _pending;
  bool _toggling = false;

  bool _isOn(SwitchState? switchState) {
    if (_pending != null) return _pending!;
    if (switchState == null) return false;
    return switchState.channels[1] ?? false;
  }

  Future<void> _toggle(SwitchState? switchState) async {
    if (_toggling) return;
    final controller = ref
        .read(deviceControllerProvider(widget.device.id).notifier)
        .controller;
    if (controller is! SwitchController) return;

    final newValue = !_isOn(switchState);
    setState(() {
      _pending = newValue;
      _toggling = true;
    });

    try {
      if (newValue) {
        await controller.turnOn();
      } else {
        await controller.turnOff();
      }
    } on Exception {
      if (mounted) {
        setState(() => _pending = null);
        ElogirToast.show(
          context: context,
          message: 'Failed to toggle ${widget.device.name}',
          variant: ElogirToastVariant.error,
        );
      }
    } finally {
      if (mounted) setState(() => _toggling = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controllerAsync =
        ref.watch(deviceControllerProvider(widget.device.id));
    final theme = ElogirTheme.of(context);

    // Clear pending when confirmed state arrives from the controller.
    ref.listen<AsyncValue<dynamic>>(
      deviceControllerProvider(widget.device.id),
      (prev, next) {
        if (!_toggling && _pending != null && next is AsyncData) {
          setState(() => _pending = null);
        }
      },
    );

    final switchState = controllerAsync.value as SwitchState?;
    final isOn = _isOn(switchState);
    final isLoading =
        controllerAsync is AsyncLoading && switchState == null;

    final cardColor = isOn
        ? theme.colors.primaryContainer
        : theme.colors.surface;
    final textColor = isOn
        ? theme.colors.onPrimaryContainer
        : theme.colors.onSurface;
    final subtextColor = isOn
        ? theme.colors.onPrimaryContainer.withValues(alpha: 0.7)
        : theme.colors.onSurfaceVariant;
    final iconColor = isOn
        ? theme.colors.onPrimaryContainer
        : theme.colors.primary;

    return ElogirPressable(
      onPressed: isLoading ? null : () => _toggle(switchState),
      onLongPress: () => context.go('/devices/${widget.device.id}'),
      pressScale: 0.98,
      child: ElogirCard(
        backgroundColor: cardColor,
        child: Row(
          children: [
            DeviceTypeIcon(
              type: widget.device.type,
              size: 24,
              color: iconColor,
            ),
            SizedBox(width: theme.spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElogirText(
                    widget.device.name,
                    variant: ElogirTextVariant.bodyLarge,
                    style: TextStyle(color: textColor),
                  ),
                  SizedBox(height: theme.spacing.xxs),
                  ElogirText(
                    isOn ? 'On' : 'Off',
                    variant: ElogirTextVariant.bodySmall,
                    style: TextStyle(color: subtextColor),
                  ),
                ],
              ),
            ),
            if (isLoading)
              ElogirSpinner(size: 16, color: subtextColor)
            else if (controllerAsync is AsyncError)
              FaIcon(
                FontAwesomeIcons.triangleExclamation,
                size: 14,
                color: theme.colors.error,
              )
            else
              FaIcon(
                FontAwesomeIcons.powerOff,
                size: 14,
                color: isOn ? iconColor : subtextColor,
              ),
          ],
        ),
      ),
    );
  }
}
