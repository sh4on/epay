class BankModel {
  final String id;
  final String name;
  final String branchName;
  final String? imageUrl;

  const BankModel({
    required this.id,
    required this.name,
    required this.branchName,
    this.imageUrl,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      branchName: json['branch_name'] ?? '',
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'branch_name': branchName,
    'image_url': imageUrl,
  };
}