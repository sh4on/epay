class ContactModel {
  final String name;
  final String phone;
  final String? avatarUrl;

  const ContactModel({required this.name, required this.phone, this.avatarUrl});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'avatar_url': avatarUrl,
  };
}
