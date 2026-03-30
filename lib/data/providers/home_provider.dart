import '../../core/services/network_service.dart';

// mock home provider — replace with real endpoints later
class HomeProvider {
  // mock: fetch user balance
  Future<NetworkResult<dynamic>> fetchBalance() async {
    return NetworkResult.success(
      {'balance': 13999.00, 'points': 1972},
      200,
      'Success',
    );
  }

  // mock: fetch service grid items
  Future<NetworkResult<dynamic>> fetchServices() async {
    return NetworkResult.success(
      [
        {'id': '1', 'label': 'Cash In', 'icon': 'cash_in', 'route': '/cash-in'},
        {'id': '2', 'label': 'Cash Out', 'icon': 'cash_out', 'route': '/cash-out'},
        {'id': '3', 'label': 'Add Money', 'icon': 'add_money', 'route': '/add-money'},
        {'id': '4', 'label': 'Send Money', 'icon': 'send_money', 'route': '/send-money'},
        {'id': '5', 'label': 'Mobile Recharge', 'icon': 'mobile', 'route': '/mobile-recharge'},
        {'id': '6', 'label': 'MRT Recharge', 'icon': 'mrt', 'route': '/mrt-recharge'},
        {'id': '7', 'label': 'Make Payment', 'icon': 'payment', 'route': '/make-payment'},
        {'id': '8', 'label': 'Express Card Recharge', 'icon': 'card', 'route': '/card-recharge'},
      ],
      200,
      'Success',
    );
  }

  // mock: fetch pay bill items
  Future<NetworkResult<dynamic>> fetchBillServices() async {
    return NetworkResult.success(
      [
        {'id': '1', 'label': 'Electricity', 'icon': 'electricity'},
        {'id': '2', 'label': 'Gas', 'icon': 'gas'},
        {'id': '3', 'label': 'Water', 'icon': 'water'},
        {'id': '4', 'label': 'Internet', 'icon': 'internet'},
        {'id': '5', 'label': 'Telephone', 'icon': 'telephone'},
        {'id': '6', 'label': 'Credit Card', 'icon': 'credit_card'},
        {'id': '7', 'label': 'Govt. Fees', 'icon': 'govt'},
        {'id': '8', 'label': 'Cable Network', 'icon': 'cable'},
      ],
      200,
      'Success',
    );
  }

  // mock: fetch remittance partners
  Future<NetworkResult<dynamic>> fetchRemittance() async {
    return NetworkResult.success(
      [
        {'id': '1', 'label': 'Payoneer', 'logo': 'payoneer'},
        {'id': '2', 'label': 'PayPal', 'logo': 'paypal'},
        {'id': '3', 'label': 'Wind', 'logo': 'wind'},
        {'id': '4', 'label': 'Wise', 'logo': 'wise'},
      ],
      200,
      'Success',
    );
  }
}