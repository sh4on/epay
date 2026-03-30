class TransactionModel {
  final String id;
  final String type;
  final double amount;
  final String recipientPhone;
  final String status;
  final DateTime createdAt;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.recipientPhone,
    required this.status,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      recipientPhone: json['recipient_phone'] ?? '',
      status: json['status'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'amount': amount,
    'recipient_phone': recipientPhone,
    'status': status,
    'created_at': createdAt.toIso8601String(),
  };
}