import '../models/route_model.dart';

/// Pure helper that computes BRT fares based on distance and
/// current time‐of‐day.
///
/// Extracted from [RouteDatabaseHelper] so the database helper
/// only handles data access (Single Responsibility Principle).
class BrtFareCalculator {
  const BrtFareCalculator();

  /// Returns a [RouteModel] for a BRT trip between two stations
  /// that are [distance] km apart.
  ///
  /// During Libreng Sakay hours (6‑9 AM, 5‑8 PM) the fare is ₱0.
  RouteModel calculate({
    required String origin,
    required String destination,
    required double distance,
    DateTime? now,
  }) {
    final currentTime = now ?? DateTime.now();
    final hour = currentTime.hour;

    final bool isLibrengSakay =
        (hour >= 6 && hour < 9) || (hour >= 17 && hour < 20);

    double regularFare = 0.0;
    double studentFare = 0.0;

    if (!isLibrengSakay) {
      regularFare = 18.0;
      studentFare = 14.40;

      if (distance > 5.0) {
        final double extraKm = (distance - 5.0).ceilToDouble();
        regularFare += (2.97 * extraKm);
        studentFare += (2.38 * extraKm);
      }
    }

    return RouteModel(
      title: 'BRT',
      subtitle: isLibrengSakay
          ? 'Libreng Sakay Time!'
          : 'CBRT Standard Route (${distance.toStringAsFixed(1)} km)',
      path: '$origin → CBRT Stops → $destination',
      duration: '${(distance * 4).toStringAsFixed(0)} mins',
      price: isLibrengSakay
          ? '₱0.00'
          : '₱${regularFare.toStringAsFixed(2)}',
      comparison: isLibrengSakay
          ? 'Save ₱${regularFare.toStringAsFixed(2)}!'
          : 'Student: ₱${studentFare.toStringAsFixed(2)}',
      status: 'Every 10-15 mins',
      isFree: isLibrengSakay,
    );
  }
}
