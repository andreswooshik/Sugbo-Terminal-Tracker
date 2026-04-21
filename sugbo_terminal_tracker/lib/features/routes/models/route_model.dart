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
    required this.duration,
    required this.price,
    required this.comparison,
    required this.status,
    this.isFree = false,
  });

  factory RouteModel.fromMap(Map<String, dynamic> json) => RouteModel(
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    path: json['path'] as String,
    duration: json['duration'] as String,
    price: json['price'] as String,
    comparison: json['comparison'] as String,
    status: json['status'] as String,
    isFree: (json['isFree'] as int) == 1,
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
