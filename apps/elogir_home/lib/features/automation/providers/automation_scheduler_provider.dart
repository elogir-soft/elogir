import 'package:elogir_home/features/automation/providers/automation_repository_provider.dart';
import 'package:elogir_home/features/automation/services/automation_executor.dart';
import 'package:elogir_home/features/automation/services/automation_scheduler.dart';
import 'package:elogir_home/shared/providers/elogir_auto_provider.dart';
import 'package:elogir_home/shared/providers/talker_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'automation_scheduler_provider.g.dart';

@Riverpod(keepAlive: true)
AutomationScheduler automationScheduler(Ref ref) {
  final elogirAuto = ref.watch(elogirAutoProvider);
  final talker = ref.watch(talkerProvider);
  final repository = ref.watch(automationRepositoryProvider);

  final executor = AutomationExecutor(
    elogirAuto: elogirAuto,
    deviceDao: elogirAuto.deviceDao,
    talker: talker,
  );

  final scheduler = AutomationScheduler(
    repository: repository,
    executor: executor,
    talker: talker,
  )..start();
  ref.onDispose(scheduler.dispose);

  return scheduler;
}
