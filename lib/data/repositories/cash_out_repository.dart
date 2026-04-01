import '../providers/cash_out_provider.dart';
import '../../core/services/network_service.dart';

// cash out repository
class CashOutRepository {
  final CashOutProvider _provider;

  CashOutRepository(this._provider);

  Future<NetworkResult<dynamic>> fetchRecentContacts() =>
      _provider.fetchRecentContacts();

  Future<NetworkResult<dynamic>> fetchAllContacts() =>
      _provider.fetchAllContacts();

  Future<NetworkResult<dynamic>> fetchPartnerBanks() =>
      _provider.fetchPartnerBanks();

  Future<NetworkResult<dynamic>> processCashOut({
    required String agentPhone,
    required double amount,
  }) => _provider.processCashOut(agentPhone: agentPhone, amount: amount);
}
