import '../models/route_model.dart';

/// Abstract contract for fetching route data.
///
/// Screens depend on this interface, not on any concrete database
/// helper.  This satisfies the Dependency Inversion Principle and
/// makes the data source swappable (SQLite today, API tomorrow).
abstract class RouteRepository {
  /// Returns a list of [RouteModel]s matching the given
  /// [origin] → [destination] pair.
  Future<List<RouteModel>> getRoutes(String origin, String destination);

  /// Returns every distinct location name available in the
  /// data source, suitable for populating dropdown menus.
  Future<List<Map<String, String>>> getLocations();
}
