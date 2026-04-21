import '../../data/savings_database_helper.dart';
import '../models/trip_model.dart';
import 'savings_repository.dart';

class SqliteSavingsRepositoryImpl implements SavingsRepository {
  final SavingsDatabaseHelper _dbHelper;

  SqliteSavingsRepositoryImpl({SavingsDatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? SavingsDatabaseHelper.instance;

  @override
  Future<List<TripModel>> getAllTrips() async {
    return await _dbHelper.getAllTrips();
  }

  @override
  Future<List<TripModel>> getTripsByProvider(String provider) async {
    return await _dbHelper.getTripsByProvider(provider);
  }

  @override
  Future<void> addTrip(TripModel trip) async {
    return await _dbHelper.addTrip(trip);
  }

  @override
  Future<Map<String, double>> getTotalSavings() async {
    return await _dbHelper.getTotalSavings();
  }
}
