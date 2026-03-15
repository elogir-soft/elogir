import 'dart:convert';

import 'package:elogir_calc/features/history/models/calculation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculation', () {
    final testDate = DateTime(2026, 3, 15, 10, 30);
    final calculation = Calculation(
      id: 'test-id',
      expression: '2+3',
      result: '5',
      createdAt: testDate,
    );

    test('JSON round-trip', () {
      final json = calculation.toJson();
      final fromJson = Calculation.fromJson(json);
      expect(fromJson, calculation);
    });

    test('JSON serialization produces valid JSON string', () {
      final jsonString = jsonEncode(calculation.toJson());
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      final restored = Calculation.fromJson(decoded);
      expect(restored, calculation);
    });

    test('equality', () {
      final same = Calculation(
        id: 'test-id',
        expression: '2+3',
        result: '5',
        createdAt: testDate,
      );
      expect(calculation, same);
    });

    test('inequality with different id', () {
      final different = calculation.copyWith(id: 'other-id');
      expect(calculation, isNot(different));
    });

    test('copyWith preserves unchanged fields', () {
      final copied = calculation.copyWith(result: '10');
      expect(copied.id, calculation.id);
      expect(copied.expression, calculation.expression);
      expect(copied.result, '10');
      expect(copied.createdAt, calculation.createdAt);
    });
  });
}
