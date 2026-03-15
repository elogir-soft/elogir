import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/config/constants.dart';
import 'package:elogir_home/shared/providers/elogir_auto_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_results_provider.g.dart';

@riverpod
Future<List<ScanResult>> scanResults(Ref ref) {
  final elogirAuto = ref.watch(elogirAutoProvider);
  return elogirAuto.scan(timeout: AppConstants.scanTimeout);
}
