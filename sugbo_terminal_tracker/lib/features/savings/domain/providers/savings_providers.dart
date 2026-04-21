import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/savings_database_helper.dart';
import '../repositories/savings_repository.dart';
import '../repositories/sqlite_savings_repository_impl.dart';
import '../../models/trip_model.dart';

// Provide the Database Helper
final savingsDatabaseHelperProvider = Provider<SavingsDatabaseHelper>((ref) {
  return SavingsDatabaseHelper.instance;
});

// Provide the Repository using SQLite
final savingsRepositoryProvider = Provider<SavingsRepository>((ref) {
  final dbHelper = ref.watch(savingsDatabaseHelperProvider);
  return SqliteSavingsRepositoryImpl(dbHelper: dbHelper);
});

// Provide a stream of trips from SQLite
final tripsStreamProvider = StreamProvider.autoDispose<List<TripModel>>((ref) async* {
  final repository = ref.watch(savingsRepositoryProvider);
  
  try {
    final trips = await repository.getAllTrips();
    yield trips;
  } catch (e) {
    // Return empty list on error
    yield [];
  }
});

// Provide total savings
final totalSavingsProvider = FutureProvider<Map<String, double>>((ref) async {
  final repository = ref.watch(savingsRepositoryProvider);
  return await repository.getTotalSavings();
});
