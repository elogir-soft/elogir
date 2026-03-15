import 'package:elogir_home/features/automation/models/automation.dart';
import 'package:elogir_home/features/automation/providers/automation_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'automations_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<List<Automation>> automations(Ref ref) {
  return ref.watch(automationRepositoryProvider).watchAll();
}

@Riverpod(keepAlive: true)
Stream<List<Automation>> recurringAutomations(Ref ref) {
  return ref.watch(automationRepositoryProvider).watchRecurring();
}

@Riverpod(keepAlive: true)
Stream<List<Automation>> oneTimeAutomations(Ref ref) {
  return ref.watch(automationRepositoryProvider).watchOneTime();
}
