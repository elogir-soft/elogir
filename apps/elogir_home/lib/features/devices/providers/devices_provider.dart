import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/devices/providers/device_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'devices_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<List<SmartDevice>> devices(Ref ref) {
  return ref.watch(deviceRepositoryProvider).watchAll();
}
