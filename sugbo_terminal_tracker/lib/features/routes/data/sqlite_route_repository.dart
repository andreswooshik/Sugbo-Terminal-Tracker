import '../../../core/data/database_service.dart';
import '../models/route_model.dart';
import 'brt_fare_calculator.dart';
import 'route_repository.dart';

/// Concrete [RouteRepository] backed by the shared [DatabaseService].
///
/// Uses the centralized SQLite database instead of managing its own
/// connection, ensuring consistency across all features.
class SqliteRouteRepository implements RouteRepository {
  final DatabaseService _databaseService;
  final BrtFareCalculator _fareCalculator;

  SqliteRouteRepository({
    required DatabaseService databaseService,
    BrtFareCalculator fareCalculator = const BrtFareCalculator(),
  })  : _databaseService = databaseService,
        _fareCalculator = fareCalculator;

  @override
  Future<List<RouteModel>> getRoutes(
    String origin,
    String destination,
  ) async {
    final db = await _databaseService.database;

    // Check if both origin and destination are BRT stations
    final brtOrigin = await db.query(
      'brt_stations',
      where: 'station_name = ?',
      whereArgs: [origin],
    );

    final brtDest = await db.query(
      'brt_stations',
      where: 'station_name = ?',
      whereArgs: [destination],
    );

    List<RouteModel> brtRoutes = [];
    if (brtOrigin.isNotEmpty && brtDest.isNotEmpty) {
      final double kmOrigin = brtOrigin.first['km_marker'] as double;
      final double kmDest = brtDest.first['km_marker'] as double;
      final double distance = (kmOrigin - kmDest).abs();

      brtRoutes = [
        _fareCalculator.calculate(
          origin: origin,
          destination: destination,
          distance: distance,
        ),
      ];
    }

    // Query standard routes from the DB
    final maps = await db.query(
      'routes',
      where: 'origin = ? AND destination = ?',
      whereArgs: [origin, destination],
    );

    List<RouteModel> standardRoutes = [];
    if (maps.isNotEmpty) {
      standardRoutes = maps.map((map) => RouteModel.fromMap(map)).toList();
    } else if (brtRoutes.isEmpty) {
      standardRoutes = [
        RouteModel(
          title: 'GENERIC BUS',
          subtitle: 'Regular operations',
          path: '$origin → $destination',
        ),
      ];
    }

    return [...brtRoutes, ...standardRoutes];
  }

  @override
  Future<List<Map<String, String>>> getLocations() async {
    // Return the well-known locations for the dropdowns.
    // In a future iteration these could come from the DB.
    return const [
      {'title': 'SM City Cebu', 'subtitle': 'North Reclamation Area, Cebu City'},
      {'title': 'IT Park', 'subtitle': 'Lahug, Cebu City'},
      {'title': 'Capitol', 'subtitle': 'Capitol Site / Escario St.'},
      {'title': 'Fuente', 'subtitle': 'Fuente Osmeña Circle'},
      {'title': 'CSBT', 'subtitle': 'Cebu South Bus Terminal / N. Bacalso'},
      {'title': 'SM Seaside', 'subtitle': 'SRP, Cebu City'},
      {'title': 'Il Corso', 'subtitle': 'South Road Properties (SRP)'},
      {'title': 'Anjo World', 'subtitle': 'Minglanilla, Cebu'},
      {'title': 'Airport', 'subtitle': 'Mactan Cebu International Airport'},
      {'title': 'J Mall', 'subtitle': 'Mandaue City'},
      {'title': 'Talisay City', 'subtitle': 'Talisay City Hall / Lawaan'},
      {'title': 'Cebu City (SRP)', 'subtitle': 'South Road Properties'},
    ];
  }
}
