/// Data model representing a single transit route result.
///
/// Fields that may be absent (e.g. for a generic fallback route)
/// have sensible defaults so callers don't need to supply every
/// value.
class RouteModel {
  final String title;
  final String subtitle;
  final String path;
  final String duration;
  final String price;
  final String comparison;
  final String status;
  final bool isFree;

  RouteModel({
    required this.title,
    required this.subtitle,
    required this.path,
    this.duration = '',
    this.price = '',
    this.comparison = '',
    this.status = '',
    this.isFree = false,
  });

  factory RouteModel.fromMap(Map<String, dynamic> map) => RouteModel(
    title: map['title'] as String,
    subtitle: map['subtitle'] as String,
    path: map['path'] as String,
    duration: map['duration'] as String,
    price: map['price'] as String,
    comparison: map['comparison'] as String,
    status: map['status'] as String,
    isFree: (map['isFree'] as int) == 1,
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
  };
}
