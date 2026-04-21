class TransitRoute {
  final String id;
  final String providerName; // e.g., 'BRT', 'MyBus'
  final String origin;
  final String destination;
  final String frequency; // e.g., 'Every 20 min'
  final String price; // e.g., 'FREE', '₱50'

  TransitRoute({
    required this.id,
    required this.providerName,
    required this.origin,
    required this.destination,
    required this.frequency,
    required this.price,
  });
}
