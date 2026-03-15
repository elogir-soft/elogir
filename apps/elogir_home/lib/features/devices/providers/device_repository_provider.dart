import 'package:elogir_home/features/devices/repositories/device_repository.dart';
import 'package:elogir_home/shared/providers/elogir_auto_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_repository_provider.g.dart';

@Riverpod(keepAlive: true)
DeviceRepository deviceRepository(Ref ref) {
  final elogirAuto = ref.watch(elogirAutoProvider);
  return DeviceRepository(elogirAuto.deviceDao);
}
