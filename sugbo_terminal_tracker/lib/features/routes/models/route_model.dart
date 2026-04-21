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
}
