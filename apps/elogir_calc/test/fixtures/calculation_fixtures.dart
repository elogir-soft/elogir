import 'package:elogir_calc/features/history/models/calculation.dart';

/// Factory functions for test data.
class CalculationFixtures {
  /// A simple addition calculation.
  static Calculation simple() => Calculation(
        id: 'test-1',
        expression: '2+3',
        result: '5',
        createdAt: DateTime(2026, 3, 15),
      );

  /// A more complex calculation.
  static Calculation complex() => Calculation(
        id: 'test-2',
        expression: 'sin(45)*2',
        result: '1.41421356237',
        createdAt: DateTime(2026, 3, 15, 10),
      );

  /// A list of sample calculations.
  static List<Calculation> sampleList() => [
        simple(),
        complex(),
        Calculation(
          id: 'test-3',
          expression: '100/4',
          result: '25',
          createdAt: DateTime(2026, 3, 15, 12),
        ),
      ];
}
