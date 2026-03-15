import 'package:elogir_calc/features/history/repositories/history_repository.dart';
import 'package:elogir_calc/shared/providers/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_repository_provider.g.dart';

@Riverpod(keepAlive: true)
HistoryRepository historyRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return HistoryRepository(db.historyDao);
}
