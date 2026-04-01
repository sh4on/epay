import '../providers/send_money_provider.dart';
import '../../core/services/network_service.dart';

// send money repository
class SendMoneyRepository {
  final SendMoneyProvider _provider;

  SendMoneyRepository(this._provider);

  Future<NetworkResult<dynamic>> fetchRecentContacts() =>
      _provider.fetchRecentContacts();

  Future<NetworkResult<dynamic>> fetchAllContacts() =>
      _provider.fetchAllContacts();

  Future<NetworkResult<dynamic>> processSendMoney({
    required String recipientPhone,
    required double amount,
  }) => _provider.processSendMoney(
    recipientPhone: recipientPhone,
    amount: amount,
  );
}
