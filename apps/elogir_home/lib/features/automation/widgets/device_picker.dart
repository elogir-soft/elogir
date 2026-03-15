import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/devices/providers/devices_provider.dart';
import 'package:elogir_home/features/devices/widgets/device_type_icon.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Displays a selectable list of registered devices.
class DevicePicker extends ConsumerWidget {
  const DevicePicker({required this.onDeviceSelected, super.key});

  final ValueChanged<SmartDevice> onDeviceSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicesAsync = ref.watch(devicesProvider);
    final theme = ElogirTheme.of(context);

    return devicesAsync.when(
      loading: () => const Center(child: ElogirSpinner()),
      error: (e, _) => Center(
        child: ElogirText(
          'Failed to load devices',
          style: TextStyle(color: theme.colors.error),
        ),
      ),
      data: (devices) {
        if (devices.isEmpty) {
          return Center(
            child: ElogirText(
              'No devices registered',
              style: TextStyle(color: theme.colors.onSurfaceVariant),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          itemCount: devices.length,
          separatorBuilder: (_, _) => SizedBox(height: theme.spacing.sm),
          itemBuilder: (context, index) {
            final device = devices[index];
            return ElogirPressable(
              onPressed: () => onDeviceSelected(device),
              pressScale: 0.98,
              child: ElogirCard(
                child: Row(
                  children: [
                    DeviceTypeIcon(
                      type: device.type,
                      size: 20,
                      color: theme.colors.primary,
                    ),
                    SizedBox(width: theme.spacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElogirText(
                            device.name,
                            variant: ElogirTextVariant.bodyLarge,
                          ),
                          ElogirText(
                            DeviceTypeIcon.labelFor(device.type),
                            variant: ElogirTextVariant.bodySmall,
                            style: TextStyle(
                              color: theme.colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
