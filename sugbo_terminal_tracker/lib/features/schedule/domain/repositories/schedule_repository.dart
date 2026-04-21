import '../models/schedule_model.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleModel>> getAllSchedules();
  Future<List<ScheduleModel>> getSchedulesByProvider(String provider);
}
