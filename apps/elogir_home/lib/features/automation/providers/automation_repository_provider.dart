import 'package:elogir_home/features/automation/repositories/automation_repository.dart';
import 'package:elogir_home/shared/providers/app_database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'automation_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AutomationRepository automationRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return AutomationRepository(db.automationDao);
}
