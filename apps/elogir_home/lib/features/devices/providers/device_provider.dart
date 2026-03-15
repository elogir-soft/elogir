import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/devices/providers/device_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_provider.g.dart';

@riverpod
Future<SmartDevice?> device(Ref ref, String deviceId) {
  return ref.watch(deviceRepositoryProvider).getById(deviceId);
}
