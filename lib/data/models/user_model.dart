// user model for logged-in user data
class UserModel {
  final String id;
  final String name;
  final String phone;
  final double balance;
  final int points;
  final String? avatarUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.balance,
    required this.points,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      balance: (json['balance'] ?? 0).toDouble(),
      points: json['points'] ?? 0,
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'balance': balance,
    'points': points,
    'avatar_url': avatarUrl,
  };
}
