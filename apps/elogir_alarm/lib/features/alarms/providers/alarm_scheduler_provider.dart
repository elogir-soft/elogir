import 'package:elogir_alarm/features/alarms/services/alarm_scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarm_scheduler_provider.g.dart';

/// The platform-appropriate native alarm scheduler.
///
/// Overridden in bootstrap with [AlarmScheduler.create()] after [init()].
@Riverpod(keepAlive: true)
AlarmScheduler alarmScheduler(Ref ref) => throw UnimplementedError();
