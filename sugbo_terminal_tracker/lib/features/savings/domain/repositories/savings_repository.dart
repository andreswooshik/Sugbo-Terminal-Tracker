import '../models/trip_model.dart';

abstract class SavingsRepository {
  Future<List<TripModel>> getAllTrips();
  Future<List<TripModel>> getTripsByProvider(String provider);
  Future<void> addTrip(TripModel trip);
  Future<Map<String, double>> getTotalSavings();
}
