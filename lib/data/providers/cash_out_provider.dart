import '../../core/services/network_service.dart';

// mock cash out provider — replace endpoints with real ones later
class CashOutProvider {
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
        {'name': 'Andrea Summer', 'phone': '0987 3422 8756', 'avatar_url': null},
        {'name': 'Karen William', 'phone': '0987 3422 8756', 'avatar_url': null},
        {'name': 'John Doe', 'phone': '0987 3422 8756', 'avatar_url': null},
        {'name': 'Jane Smith', 'phone': '0987 3422 8756', 'avatar_url': null},
      ],
      200,
      'Success',
    );
  }

  // mock: fetch partner banks for atm
  Future<NetworkResult<dynamic>> fetchPartnerBanks() async {
    return NetworkResult.success(
      [
        {
          'id': '1',
          'name': 'Basic Bank',
          'branch_name': 'Mirpur 11',
          'image_url': null,
        },
        {
          'id': '2',
          'name': 'Brak Bank',
          'branch_name': 'Banani',
          'image_url': null,
        },
        {
          'id': '3',
          'name': 'Islamic Bank',
          'branch_name': 'Gulshan 1',
          'image_url': null,
        },
        {
          'id': '4',
          'name': 'Dutch Bangla Bank',
          'branch_name': 'Dhanmondi',
          'image_url': null,
        },
      ],
      200,
      'Success',
    );
  }

  // mock: process cash out
  Future<NetworkResult<dynamic>> processCashOut({
    required String agentPhone,
    required double amount,
  }) async {
    // simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return NetworkResult.success(
      {
        'transaction_id': 'TXN${DateTime.now().millisecondsSinceEpoch}',
        'amount': amount,
        'agent_phone': agentPhone,
        'status': 'success',
      },
      200,
      'Cash out successful',
    );
  }
}