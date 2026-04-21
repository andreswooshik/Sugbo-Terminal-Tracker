import '../../data/schedule_database_helper.dart';
import '../models/schedule_model.dart';
import 'schedule_repository.dart';

class SqliteScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleDatabaseHelper _dbHelper;

  SqliteScheduleRepositoryImpl({ScheduleDatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? ScheduleDatabaseHelper.instance;

  @override
  Future<List<ScheduleModel>> getAllSchedules() async {
    return await _dbHelper.getAllSchedules();
  }

  @override
  Future<List<ScheduleModel>> getSchedulesByProvider(String provider) async {
    return await _dbHelper.getSchedulesByProvider(provider);
  }
}
