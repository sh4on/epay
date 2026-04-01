class RemittanceItem {
  final String id;
  final String label;
  final String logo;

  const RemittanceItem({
    required this.id,
    required this.label,
    required this.logo,
  });

  factory RemittanceItem.fromJson(Map<String, dynamic> json) => RemittanceItem(
    id: json['id'] ?? '',
    label: json['label'] ?? '',
    logo: json['logo'] ?? '',
  );
}
