import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/data/database_service.dart';
import '../../routes/providers/route_providers.dart';
import '../models/trip_model.dart';

final savingsRepositoryProvider = Provider<SavingsRepository>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return SavingsRepository(dbService);
});

final tripsListProvider = FutureProvider<List<TripModel>>((ref) {
  final repository = ref.watch(savingsRepositoryProvider);
  return repository.getTrips();
});

class SavingsRepository {
  final DatabaseService _dbService;

  SavingsRepository(this._dbService);

  Future<List<TripModel>> getTrips() async {
    final db = await _dbService.database;
    final List<Map<String, dynamic>> maps = await db.query('trips');
    return maps.map((map) => TripModel.fromMap(map)).toList();
  }
}
