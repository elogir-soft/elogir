import 'package:freezed_annotation/freezed_annotation.dart';

part 'automation_trigger.freezed.dart';
part 'automation_trigger.g.dart';

/// When an automation should fire.
///
/// - recurring: repeats at a given time on selected days of the week.
/// - oneTime: fires once at an exact date and time.
@Freezed(unionKey: 'type')
abstract class AutomationTrigger with _$AutomationTrigger {
  const factory AutomationTrigger.recurring({
    required int hour,
    required int minute,

    /// Days of the week (1 = Monday … 7 = Sunday). Empty means every day.
    @Default([]) List<int> repeatDays,
  }) = RecurringTrigger;

  const factory AutomationTrigger.oneTime({
    required DateTime scheduledAt,
  }) = OneTimeTrigger;

  factory AutomationTrigger.fromJson(Map<String, dynamic> json) =>
      _$AutomationTriggerFromJson(json);
}
