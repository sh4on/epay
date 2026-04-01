class BillItem {
  final String id;
  final String label;
  final String icon;

  const BillItem({required this.id, required this.label, required this.icon});

  factory BillItem.fromJson(Map<String, dynamic> json) => BillItem(
    id: json['id'] ?? '',
    label: json['label'] ?? '',
    icon: json['icon'] ?? '',
  );
}