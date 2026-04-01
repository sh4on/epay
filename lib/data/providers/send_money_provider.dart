import '../../core/services/network_service.dart';

// mock send money provider — replace endpoints with real ones later
class SendMoneyProvider {
  // mock: fetch recent contacts
  Future<NetworkResult<dynamic>> fetchRecentContacts() async {
    return NetworkResult.success(
      [
        {'name': 'Samantha', 'phone': '0987 3422 8756', 'avatar_url': null},
        {'name': 'Rose Hope', 'phone': '0987 3422 8756', 'avatar_url': null},
      ],
      200,
      'Success',
    );
  }

  // mock: fetch all contacts
  Future<NetworkResult<dynamic>> fetchAllContacts() async {
    return NetworkResult.success(
      [
        {
          'name': 'Andrea Summer',
          'phone': '0987 3422 8756',
          'avatar_url': null,
        },
        {
          'name': 'Karen William',
          'phone': '0987 3422 8756',
          'avatar_url': null,
        },
        {'name': 'John Doe', 'phone': '0987 3422 8756', 'avatar_url': null},
        {'name': 'Jane Smith', 'phone': '0987 3422 8756', 'avatar_url': null},
      ],
      200,
      'Success',
    );
  }

  // mock: process send money transaction
  Future<NetworkResult<dynamic>> processSendMoney({
    required String recipientPhone,
    required double amount,
  }) async {
    // simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return NetworkResult.success(
      {
        'transaction_id': 'TXN${DateTime.now().millisecondsSinceEpoch}',
        'recipient_phone': recipientPhone,
        'amount': amount,
        'status': 'success',
      },
      200,
      'Send money successful',
    );
  }
}
