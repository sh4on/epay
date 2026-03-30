import '../../core/services/network_service.dart';

// mock add money provider — replace endpoints with real ones later
class AddMoneyProvider {
  // mock: fetch add money sources for bank tab
  Future<NetworkResult<dynamic>> fetchBankSources() async {
    return NetworkResult.success(
      [
        {
          'id': '1',
          'label': 'Bank Account',
          'icon': 'bank_account',
          'is_selected': true,
        },
        {
          'id': '2',
          'label': 'Internet Banking',
          'icon': 'internet_banking',
          'is_selected': false,
        },
      ],
      200,
      'Success',
    );
  }

  // mock: fetch card sources for card tab
  Future<NetworkResult<dynamic>> fetchCardSources() async {
    return NetworkResult.success(
      [
        {
          'id': '1',
          'label': 'Debit Card',
          'icon': 'debit_card',
          'is_selected': true,
        },
        {
          'id': '2',
          'label': 'Credit Card',
          'icon': 'credit_card',
          'is_selected': false,
        },
      ],
      200,
      'Success',
    );
  }

  // mock: process add money request
  Future<NetworkResult<dynamic>> processAddMoney({
    required String sourceId,
    required double amount,
    required String type,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return NetworkResult.success(
      {
        'transaction_id': 'TXN${DateTime.now().millisecondsSinceEpoch}',
        'source_id': sourceId,
        'amount': amount,
        'type': type,
        'status': 'success',
      },
      200,
      'Add money successful',
    );
  }
}