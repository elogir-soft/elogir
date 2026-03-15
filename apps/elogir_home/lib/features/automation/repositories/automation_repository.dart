import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:elogir_home/database/app_database.dart';
import 'package:elogir_home/database/daos/automation_dao.dart';
import 'package:elogir_home/features/automation/models/automation.dart';
import 'package:elogir_home/features/automation/models/automation_action.dart';
import 'package:elogir_home/features/automation/models/automation_trigger.dart';

/// Wraps [AutomationDao] and maps between Drift rows and Freezed domain models.
class AutomationRepository {
  const AutomationRepository(this._dao);

  final AutomationDao _dao;

  /// Watch all automations.
  Stream<List<Automation>> watchAll() {
    return _dao.watchAll().map((rows) => rows.map(_toModel).toList());
  }

  /// Watch only recurring automations.
  Stream<List<Automation>> watchRecurring() {
    return watchAll().map(
      (list) => list.where((a) => a.isRecurring).toList(),
    );
  }

  /// Watch only one-time automations.
  Stream<List<Automation>> watchOneTime() {
    return watchAll().map(
      (list) => list.where((a) => a.isOneTime).toList(),
    );
  }

  /// Save (insert or update) an automation.
  Future<void> save(Automation automation) {
    return _dao.upsert(_toCompanion(automation));
  }

  /// Delete an automation by ID.
  Future<void> delete(String id) {
    return _dao.deleteById(id);
  }

  /// Toggle the enabled state of an automation.
  Future<void> toggle({required String id, required bool isEnabled}) {
    return _dao.toggleEnabled(id: id, isEnabled: isEnabled);
  }

  // -- Mapping --

  Automation _toModel(AutomationTableData row) {
    final triggerJson =
        jsonDecode(row.trigger) as Map<String, dynamic>;
    final actionsJson = jsonDecode(row.actions) as List<dynamic>;

    return Automation(
      id: row.id,
      name: row.name,
      trigger: AutomationTrigger.fromJson(triggerJson),
      actions: actionsJson
          .map((e) => AutomationAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      isEnabled: row.isEnabled,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  AutomationTableCompanion _toCompanion(Automation automation) {
    return AutomationTableCompanion(
      id: Value(automation.id),
      name: Value(automation.name),
      isEnabled: Value(automation.isEnabled),
      trigger: Value(jsonEncode(automation.trigger.toJson())),
      actions: Value(
        jsonEncode(automation.actions.map((a) => a.toJson()).toList()),
      ),
      createdAt: Value(automation.createdAt),
      updatedAt: Value(automation.updatedAt),
    );
  }
}
