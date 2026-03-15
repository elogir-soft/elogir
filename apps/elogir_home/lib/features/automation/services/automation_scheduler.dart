import 'dart:async';

import 'package:elogir_home/features/automation/models/automation.dart';
import 'package:elogir_home/features/automation/models/automation_trigger.dart';
import 'package:elogir_home/features/automation/repositories/automation_repository.dart';
import 'package:elogir_home/features/automation/services/automation_executor.dart';
import 'package:talker/talker.dart';

/// Periodically checks automations against the current time and executes
/// matching ones.
///
/// - Recurring: matches hour + minute + day-of-week.
/// - One-time: matches exact date + hour + minute, auto-disables after firing.
class AutomationScheduler {
  AutomationScheduler({
    required AutomationRepository repository,
    required AutomationExecutor executor,
    required Talker talker,
  })  : _repository = repository,
        _executor = executor,
        _talker = talker;

  final AutomationRepository _repository;
  final AutomationExecutor _executor;
  final Talker _talker;

  Timer? _timer;
  StreamSubscription<List<Automation>>? _subscription;
  List<Automation> _automations = [];

  /// Set of one-time automation IDs already fired this session to prevent
  /// double-execution within the 30-second check window.
  final Set<String> _firedOneTimeIds = {};

  /// Start the scheduler: subscribes to the automation stream and ticks
  /// every 30 seconds.
  void start() {
    _subscription = _repository.watchAll().listen((automations) {
      _automations = automations;
    });

    _timer = Timer.periodic(const Duration(seconds: 30), (_) => _tick());
    _talker.info('AutomationScheduler started');
  }

  /// Stop the scheduler and clean up resources.
  void dispose() {
    _timer?.cancel();
    unawaited(_subscription?.cancel());
    _talker.info('AutomationScheduler stopped');
  }

  void _tick() {
    final now = DateTime.now();

    for (final automation in _automations) {
      if (!automation.isEnabled) continue;

      final shouldFire = switch (automation.trigger) {
        RecurringTrigger(:final hour, :final minute, :final repeatDays) =>
          _matchesRecurring(now, hour, minute, repeatDays),
        OneTimeTrigger(:final scheduledAt) =>
          _matchesOneTime(now, scheduledAt, automation.id),
        _ => false,
      };

      if (shouldFire) {
        _talker.info('Automation "${automation.name}" triggered');
        unawaited(_fire(automation));
      }
    }
  }

  bool _matchesRecurring(
    DateTime now,
    int hour,
    int minute,
    List<int> repeatDays,
  ) {
    if (now.hour != hour || now.minute != minute) return false;

    // Empty repeatDays means every day.
    if (repeatDays.isEmpty) return true;

    // DateTime.weekday: 1 = Monday … 7 = Sunday (matches our model).
    return repeatDays.contains(now.weekday);
  }

  bool _matchesOneTime(DateTime now, DateTime scheduledAt, String id) {
    if (_firedOneTimeIds.contains(id)) return false;

    return now.year == scheduledAt.year &&
        now.month == scheduledAt.month &&
        now.day == scheduledAt.day &&
        now.hour == scheduledAt.hour &&
        now.minute == scheduledAt.minute;
  }

  Future<void> _fire(Automation automation) async {
    await _executor.executeAll(automation.actions);

    // One-time automations get disabled after firing.
    if (automation.isOneTime) {
      _firedOneTimeIds.add(automation.id);
      await _repository.toggle(id: automation.id, isEnabled: false);
      _talker.info(
        'One-time automation "${automation.name}" auto-disabled after firing',
      );
    }
  }
}
