import 'package:elogir_home/features/automation/models/automation_action.dart';
import 'package:elogir_home/features/automation/models/automation_trigger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'automation.freezed.dart';
part 'automation.g.dart';

/// A scheduled automation that executes a list of device actions
/// when its trigger condition is met.
@freezed
abstract class Automation with _$Automation {
  const factory Automation({
    required String id,
    @Default('') String name,
    required AutomationTrigger trigger,
    required List<AutomationAction> actions,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(true) bool isEnabled,
  }) = _Automation;

  const Automation._();

  factory Automation.fromJson(Map<String, dynamic> json) =>
      _$AutomationFromJson(json);

  /// Whether this is a recurring automation.
  bool get isRecurring => trigger is RecurringTrigger;

  /// Whether this is a one-time automation.
  bool get isOneTime => trigger is OneTimeTrigger;
}
