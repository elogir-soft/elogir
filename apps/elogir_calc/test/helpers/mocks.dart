import 'package:elogir_calc/database/app_database.dart';
import 'package:elogir_calc/database/daos/history_dao.dart';
import 'package:elogir_calc/features/history/repositories/history_repository.dart';
import 'package:mocktail/mocktail.dart';

/// Mock of the app database.
class MockAppDatabase extends Mock implements AppDatabase {}

/// Mock of the history DAO.
class MockHistoryDao extends Mock implements HistoryDao {}

/// Mock of the history repository.
class MockHistoryRepository extends Mock
    implements HistoryRepository {}
