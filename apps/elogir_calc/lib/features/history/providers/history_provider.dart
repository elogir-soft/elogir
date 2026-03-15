import 'package:elogir_calc/features/history/models/calculation.dart';
import 'package:elogir_calc/features/history/providers/history_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<List<Calculation>> history(Ref ref) {
  return ref.watch(historyRepositoryProvider).watchAll();
}
