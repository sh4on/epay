class MoneySourceItem {
  final String id;
  final String label;
  final String icon;

  const MoneySourceItem({
    required this.id,
    required this.label,
    required this.icon,
  });

  factory MoneySourceItem.fromJson(Map<String, dynamic> json) =>
      MoneySourceItem(
        id: json['id'] ?? '',
        label: json['label'] ?? '',
        icon: json['icon'] ?? '',
      );
}
