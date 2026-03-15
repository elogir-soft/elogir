import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/shared/providers/elogir_auto_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cloud_devices_provider.g.dart';

@riverpod
Future<List<Map<String, dynamic>>> cloudDevices(
  Ref ref,
  TuyaCredentials credentials,
) async {
  final elogirAuto = ref.watch(elogirAutoProvider);
  final cloudService = elogirAuto.createTuyaCloudService(credentials);
  await cloudService.init();
  return cloudService.getDevices();
}
