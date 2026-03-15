import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/devices/providers/device_controller_provider.dart';
import 'package:elogir_home/features/devices/providers/device_provider.dart';
import 'package:elogir_home/features/devices/providers/device_repository_provider.dart';
import 'package:elogir_home/features/devices/widgets/cover_controls.dart';
import 'package:elogir_home/features/devices/widgets/device_info_section.dart';
import 'package:elogir_home/features/devices/widgets/device_type_icon.dart';
import 'package:elogir_home/features/devices/widgets/light_controls.dart';
import 'package:elogir_home/features/devices/widgets/switch_controls.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// Full-screen device detail with type-specific controls.
class DeviceDetailScreen extends ConsumerWidget {
  /// Creates a device detail screen for the given [deviceId].
  const DeviceDetailScreen({required this.deviceId, super.key});

  /// The ID of the device to display.
  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceAsync = ref.watch(deviceProvider(deviceId));
    final controllerAsync =
        ref.watch(deviceControllerProvider(deviceId));
    final theme = ElogirTheme.of(context);

    return deviceAsync.when(
      loading: () => const ElogirScaffold(
        appBar: ElogirAppBar(
          title: ElogirText('Device', variant: ElogirTextVariant.titleLarge),
        ),
        body: Center(child: ElogirSpinner()),
      ),
      error: (e, _) => ElogirScaffold(
        appBar: ElogirAppBar(
          title:
              const ElogirText('Device', variant: ElogirTextVariant.titleLarge),
          leading: ElogirIconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 18),
            onPressed: () => context.go('/devices'),
          ),
        ),
        body: Center(child: ElogirText('Error: $e')),
      ),
      data: (device) {
        if (device == null) {
          return ElogirScaffold(
            appBar: ElogirAppBar(
              title: const ElogirText(
                'Device',
                variant: ElogirTextVariant.titleLarge,
              ),
              leading: ElogirIconButton(
                icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 18),
                onPressed: () => context.go('/devices'),
              ),
            ),
            body: const Center(child: ElogirText('Device not found')),
          );
        }

        return ElogirScaffold(
          appBar: ElogirAppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DeviceTypeIcon(
                  type: device.type,
                  size: 16,
                  color: theme.colors.onSurfaceVariant,
                ),
                SizedBox(width: theme.spacing.sm),
                Flexible(
                  child: ElogirText(
                    device.name,
                    variant: ElogirTextVariant.titleLarge,
                  ),
                ),
              ],
            ),
            leading: ElogirIconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 18),
              onPressed: () => context.go('/devices'),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElogirIconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.arrowsRotate,
                    size: 18,
                    color: theme.colors.onSurfaceVariant,
                  ),
                  onPressed: () => ref
                      .read(deviceControllerProvider(deviceId).notifier)
                      .refreshState(),
                ),
                ElogirIconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.trash,
                    size: 18,
                    color: theme.colors.error,
                  ),
                  onPressed: () async {
                    await ref
                        .read(deviceRepositoryProvider)
                        .delete(deviceId);
                    if (context.mounted) {
                      context.go('/devices');
                    }
                  },
                ),
              ],
            ),
          ),
          body: ListView(
            padding: EdgeInsets.all(theme.spacing.md),
            children: [
              // Controller state / controls
              controllerAsync.when(
                loading: () => Padding(
                  padding: EdgeInsets.only(top: theme.spacing.xl),
                  child: const Center(child: ElogirSpinner()),
                ),
                error: (e, _) => ElogirCard(
                  border: Border.all(
                    color: theme.colors.error,
                    width: theme.strokes.medium,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.triangleExclamation,
                            size: 16,
                            color: theme.colors.error,
                          ),
                          SizedBox(width: theme.spacing.sm),
                          const ElogirText(
                            'Connection error',
                            variant: ElogirTextVariant.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing.xs),
                      ElogirText(
                        '$e',
                        variant: ElogirTextVariant.bodySmall,
                        style: TextStyle(
                          color: theme.colors.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: theme.spacing.md),
                      ElogirButton(
                        variant: ElogirButtonVariant.outlined,
                        size: ElogirButtonSize.sm,
                        onPressed: () => ref
                            .read(
                              deviceControllerProvider(deviceId).notifier,
                            )
                            .refreshState(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
                data: (deviceState) {
                  if (deviceState == null) {
                    return const Center(child: ElogirSpinner());
                  }
                  return _buildControls(device, deviceState, ref);
                },
              ),

              // Device info
              SizedBox(height: theme.spacing.lg),
              DeviceInfoSection(device: device),
            ],
          ),
        );
      },
    );
  }

  Widget _buildControls(
    SmartDevice device,
    dynamic deviceState,
    WidgetRef ref,
  ) {
    final notifier =
        ref.read(deviceControllerProvider(deviceId).notifier);
    final controller = notifier.controller;

    if (controller == null) {
      return const ElogirCard(
        child: ElogirText('Controller not available'),
      );
    }

    return switch (device.type) {
      DeviceType.light => LightControls(
          state: deviceState as LightState,
          controller: controller as LightController,
        ),
      DeviceType.switchDevice => SwitchControls(
          state: deviceState as SwitchState,
          controller: controller as SwitchController,
        ),
      DeviceType.cover => CoverControls(
          state: deviceState as CoverState,
          controller: controller as CoverController,
        ),
    };
  }
}
