import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/data/database_service.dart';
import '../../routes/providers/route_providers.dart';
import '../models/schedule_model.dart';

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return ScheduleRepository(dbService);
});

final scheduleListProvider = FutureProvider<List<ScheduleModel>>((ref) {
  final repository = ref.watch(scheduleRepositoryProvider);
  return repository.getSchedules();
});

class ScheduleRepository {
  final DatabaseService _dbService;

  ScheduleRepository(this._dbService);

  Future<List<ScheduleModel>> getSchedules() async {
    final db = await _dbService.database;
    final List<Map<String, dynamic>> maps = await db.query('schedules');
    return maps.map((map) => ScheduleModel.fromMap(map)).toList();
  }
}
