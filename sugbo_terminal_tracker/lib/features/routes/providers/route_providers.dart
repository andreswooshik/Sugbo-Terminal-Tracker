import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/data/database_service.dart';
import '../data/route_repository.dart';
import '../data/sqlite_route_repository.dart';

import '../models/route_model.dart';

/// Provides the shared [DatabaseService] singleton.
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService.instance;
});

/// Provides the [RouteRepository] abstraction.
final routeRepositoryProvider = Provider<RouteRepository>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return SqliteRouteRepository(databaseService: dbService);
});

/// Provides the list of all routes.
final routesListProvider = FutureProvider<List<RouteModel>>((ref) {
  final repository = ref.watch(routeRepositoryProvider);
  return repository.getAllRoutes();
});
