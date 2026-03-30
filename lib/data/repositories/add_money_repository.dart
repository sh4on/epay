import '../providers/add_money_provider.dart';
import '../../core/services/network_service.dart';

// add money repository
class AddMoneyRepository {
  final AddMoneyProvider _provider;

  AddMoneyRepository(this._provider);

  Future<NetworkResult<dynamic>> fetchBankSources() =>
      _provider.fetchBankSources();

  Future<NetworkResult<dynamic>> fetchCardSources() =>
      _provider.fetchCardSources();

  Future<NetworkResult<dynamic>> processAddMoney({
    required String sourceId,
    required double amount,
    required String type,
  }) =>
      _provider.processAddMoney(
        sourceId: sourceId,
        amount: amount,
        type: type,
      );
}