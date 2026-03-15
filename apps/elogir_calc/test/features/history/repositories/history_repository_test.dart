import 'package:drift/native.dart';
import 'package:elogir_calc/database/app_database.dart';
import 'package:elogir_calc/features/history/models/calculation.dart';
import 'package:elogir_calc/features/history/repositories/history_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HistoryRepository (integration)', () {
    late AppDatabase db;
    late HistoryRepository repo;

    setUp(() {
      db = AppDatabase.forTesting(NativeDatabase.memory());
      repo = HistoryRepository(db.historyDao);
    });

    tearDown(() async {
      await db.close();
    });

    Calculation _makeCalculation({
      String id = 'test-1',
      String expression = '2+3',
      String result = '5',
    }) =>
        Calculation(
          id: id,
          expression: expression,
          result: result,
          createdAt: DateTime(2026, 3, 15),
        );

    test('insert and watch returns entries', () async {
      final calculation = _makeCalculation();
      await repo.insert(calculation);

      final entries = await repo.watchAll().first;
      expect(entries, hasLength(1));
      expect(entries.first.id, 'test-1');
      expect(entries.first.expression, '2+3');
      expect(entries.first.result, '5');
    });

    test('multiple inserts appear in order', () async {
      await repo.insert(
        _makeCalculation(
          id: 'a',
          expression: '1+1',
          result: '2',
        ),
      );
      await repo.insert(
        _makeCalculation(
          id: 'b',
          expression: '2+2',
          result: '4',
        ),
      );

      final entries = await repo.watchAll().first;
      expect(entries, hasLength(2));
    });

    test('delete removes entry', () async {
      await repo.insert(_makeCalculation());
      await repo.delete('test-1');

      final entries = await repo.watchAll().first;
      expect(entries, isEmpty);
    });

    test('deleteAll clears all entries', () async {
      await repo.insert(_makeCalculation(id: 'a'));
      await repo.insert(_makeCalculation(id: 'b'));
      await repo.deleteAll();

      final entries = await repo.watchAll().first;
      expect(entries, isEmpty);
    });
  });
}
