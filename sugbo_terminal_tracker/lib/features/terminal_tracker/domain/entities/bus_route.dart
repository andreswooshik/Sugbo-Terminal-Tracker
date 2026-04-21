import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_route.freezed.dart';
part 'bus_route.g.dart';

enum Operator { brt, myBus, loveBus }

@freezed
abstract class BusRoute with _$BusRoute {
  const factory BusRoute({
    required String id,
    required String name, // "IT Park ↔ Il Corso"
    required Operator operator,
    required String fare, // "FREE" or "₱30"
    required String scheduleSummary, // "Daily", "Weekdays every 30 min", etc.
    required List<String> southboundStops,
    required List<String> northboundStops,
  }) = _BusRoute;

  factory BusRoute.fromJson(Map<String, dynamic> json) => _$BusRouteFromJson(json);
}