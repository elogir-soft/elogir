import 'package:elogir_alarm/database/app_database.dart';
import 'package:elogir_alarm/database/daos/alarm_dao.dart';
import 'package:elogir_alarm/database/daos/timer_dao.dart';
import 'package:elogir_alarm/features/alarms/repositories/alarm_repository.dart';
import 'package:elogir_alarm/features/alarms/services/alarm_scheduler.dart';
import 'package:elogir_alarm/features/timers/repositories/timer_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAppDatabase extends Mock implements AppDatabase {}

class MockAlarmDao extends Mock implements AlarmDao {}

class MockTimerDao extends Mock implements TimerDao {}

class MockAlarmRepository extends Mock implements AlarmRepository {}

class MockTimerRepository extends Mock implements TimerRepository {}

class MockAlarmScheduler extends Mock implements AlarmScheduler {}
