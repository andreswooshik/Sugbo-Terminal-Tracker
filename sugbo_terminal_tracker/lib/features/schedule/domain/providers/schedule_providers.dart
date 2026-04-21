import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/schedule_database_helper.dart';
import '../repositories/schedule_repository.dart';
import '../repositories/sqlite_schedule_repository_impl.dart';
import '../../models/schedule_model.dart';

// Provide the Database Helper
final scheduleDatabaseHelperProvider = Provider<ScheduleDatabaseHelper>((ref) {
  return ScheduleDatabaseHelper.instance;
});

// Provide the Repository using SQLite
final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  final dbHelper = ref.watch(scheduleDatabaseHelperProvider);
  return SqliteScheduleRepositoryImpl(dbHelper: dbHelper);
});

// Provide a stream of schedules from SQLite
final schedulesStreamProvider = StreamProvider.autoDispose<List<ScheduleModel>>((ref) async* {
  final repository = ref.watch(scheduleRepositoryProvider);
  
  try {
    final schedules = await repository.getAllSchedules();
    yield schedules;
  } catch (e) {
    // Return empty list on error
    yield [];
  }
});
