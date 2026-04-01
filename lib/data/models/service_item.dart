class ServiceItem {
  final String id;
  final String label;
  final String icon;
  final String route;

  const ServiceItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.route,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) => ServiceItem(
    id: json['id'] ?? '',
    label: json['label'] ?? '',
    icon: json['icon'] ?? '',
    route: json['route'] ?? '',
  );
}
