import 'package:elogir_home/features/automation/models/automation_action.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_automation_state.freezed.dart';

/// State for the multi-step add-automation flow.
@freezed
abstract class AddAutomationState with _$AddAutomationState {
  const factory AddAutomationState({
    @Default(0) int currentStep,

    /// Whether the trigger is recurring or one-time.
    @Default(true) bool isRecurring,

    // -- Recurring trigger fields --
    @Default(8) int hour,
    @Default(0) int minute,
    @Default([]) List<int> repeatDays,

    // -- One-time trigger fields --
    DateTime? scheduledAt,

    // -- Actions --
    @Default([]) List<AutomationAction> actions,

    // -- Name --
    @Default('') String name,
  }) = _AddAutomationState;
}
