import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/devices/providers/devices_provider.dart';
import 'package:elogir_home/features/devices/widgets/device_card.dart';
import 'package:elogir_home/features/devices/widgets/switch_device_card.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// Dashboard screen listing all registered devices.
class DevicesScreen extends ConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicesAsync = ref.watch(devicesProvider);
    final theme = ElogirTheme.of(context);

    return ElogirScaffold(
      appBar: ElogirAppBar(
        title: const ElogirText(
          'Devices',
          variant: ElogirTextVariant.titleLarge,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElogirIconButton(
              icon: FaIcon(
                FontAwesomeIcons.plus,
                size: 18,
                color: theme.colors.primary,
              ),
              onPressed: () => context.go('/add-device'),
            ),
            ElogirPopupMenu(
              items: [
                ElogirPopupMenuItem(
                  icon: const FaIcon(FontAwesomeIcons.gear, size: 16),
                  label: 'Settings',
                  onPressed: () => context.push('/settings'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: devicesAsync.when(
        loading: () => const Center(child: ElogirSpinner()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.triangleExclamation,
                size: 40,
                color: theme.colors.error,
              ),
              SizedBox(height: theme.spacing.md),
              const ElogirText(
                'Something went wrong',
                variant: ElogirTextVariant.titleMedium,
              ),
              SizedBox(height: theme.spacing.xs),
              ElogirText(
                '$e',
                variant: ElogirTextVariant.bodySmall,
                style: TextStyle(color: theme.colors.onSurfaceVariant),
              ),
              SizedBox(height: theme.spacing.lg),
              ElogirButton(
                variant: ElogirButtonVariant.outlined,
                onPressed: () => ref.invalidate(devicesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (devices) {
          if (devices.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.house,
                    size: 48,
                    color: theme.colors.onSurfaceVariant,
                  ),
                  SizedBox(height: theme.spacing.md),
                  const ElogirText(
                    'No devices yet',
                    variant: ElogirTextVariant.titleMedium,
                  ),
                  SizedBox(height: theme.spacing.sm),
                  ElogirText(
                    'Tap + to add your first smart device',
                    variant: ElogirTextVariant.bodyMedium,
                    style: TextStyle(color: theme.colors.onSurfaceVariant),
                  ),
                  SizedBox(height: theme.spacing.lg),
                  ElogirButton(
                    onPressed: () => context.go('/add-device'),
                    child: const Text('Add Device'),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(theme.spacing.md),
            itemCount: devices.length,
            separatorBuilder: (_, __) =>
                SizedBox(height: theme.spacing.sm),
            itemBuilder: (context, index) {
              final device = devices[index];
              if (device.type == DeviceType.switchDevice) {
                return SwitchDeviceCard(device: device);
              }
              return DeviceCard(
                device: device,
                onTap: () => context.go('/devices/${device.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
