class RouteModel {
  final String title;
  final String subtitle;
  final String path;
  final String duration;
  final String price;
  final String comparison;
  final String status;
  final bool isFree;

  // New fields from updated database schema
  final String routeType; // 'regular' | 'libreng_sakay' | 'free_ride'
  final String? freeTimeStart; // e.g. "06:00" — null if not a free route
  final String? freeTimeEnd; // e.g. "09:00" — null if not a free route
  final String? frequency; // e.g. "Every 20 mins"
  final String? scheduleWeekday; // comma-separated departure times
  final String? scheduleWeekend; // comma-separated departure times

  RouteModel({
    required this.title,
    required this.subtitle,
    required this.path,
    required this.duration,
    required this.price,
    required this.comparison,
    required this.status,
    this.isFree = false,
    this.routeType = 'regular',
    this.freeTimeStart,
    this.freeTimeEnd,
    this.frequency,
    this.scheduleWeekday,
    this.scheduleWeekend,
  });

  factory RouteModel.fromMap(Map<String, dynamic> json) => RouteModel(
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    path: json['path'] as String,
    duration: json['duration'] as String,
    price: json['price'] as String,
    comparison: json['comparison'] as String,
    status: json['status'] as String,
    isFree: (json['isFree'] as int? ?? 0) == 1,
    routeType: json['routeType'] as String? ?? 'regular',
    freeTimeStart: json['freeTimeStart'] as String?,
    freeTimeEnd: json['freeTimeEnd'] as String?,
    frequency: json['frequency'] as String?,
    scheduleWeekday: json['scheduleWeekday'] as String?,
    scheduleWeekend: json['scheduleWeekend'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'title': title,
    'subtitle': subtitle,
    'path': path,
    'duration': duration,
    'price': price,
    'comparison': comparison,
    'status': status,
    'isFree': isFree ? 1 : 0,
    'routeType': routeType,
    'freeTimeStart': freeTimeStart,
    'freeTimeEnd': freeTimeEnd,
    'frequency': frequency,
    'scheduleWeekday': scheduleWeekday,
    'scheduleWeekend': scheduleWeekend,
  };

  // ---------------------------------------------------------------------------
  // Convenience getters — useful in your UI widgets
  // ---------------------------------------------------------------------------

  /// True if this is a Libreng Sakay or Fuente free ride route
  bool get isLibrengSakay =>
      routeType == 'libreng_sakay' || routeType == 'free_ride';

  /// True if this route has a restricted free window (not always free)
  bool get hasFreeWindow => freeTimeStart != null && freeTimeEnd != null;

  /// Human-readable free window label, e.g. "6:00 AM – 9:00 AM"
  String get freeWindowLabel {
    if (!hasFreeWindow) return '';
    return '${_formatTime(freeTimeStart!)} – ${_formatTime(freeTimeEnd!)}';
  }

  /// Badge label shown on route cards
  String get badgeLabel {
    switch (routeType) {
      case 'libreng_sakay':
        return isFree ? 'FREE NOW' : 'LIBRENG SAKAY';
      case 'free_ride':
        return isFree ? 'FREE NOW' : 'FREE RIDE';
      default:
        return title.contains('MyBus')
            ? 'MyBus'
            : title.contains('CBRT')
            ? 'CBRT'
            : title.contains('Jeepney')
            ? 'Jeepney'
            : 'BUS';
    }
  }

  /// Price display — shows ₱0.00 only when actually within the free window
  String get displayPrice => isFree ? '₱0.00' : price;

  // Formats "HH:mm" → "H:MM AM/PM"
  String _formatTime(String hhmm) {
    final parts = hhmm.split(':');
    if (parts.length < 2) return hhmm;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = parts[1];
    final ampm = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $ampm';
  }

  @override
  String toString() =>
      'RouteModel(title: $title, price: $displayPrice, isFree: $isFree, routeType: $routeType)';
}
