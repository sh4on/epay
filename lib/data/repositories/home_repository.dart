import '../providers/home_provider.dart';
import '../../core/services/network_service.dart';

// home repository — mediates between controller and provider
class HomeRepository {
  final HomeProvider _provider;

  HomeRepository(this._provider);

  Future<NetworkResult<dynamic>> fetchBalance() =>
      _provider.fetchBalance();

  Future<NetworkResult<dynamic>> fetchServices() =>
      _provider.fetchServices();

  Future<NetworkResult<dynamic>> fetchBillServices() =>
      _provider.fetchBillServices();

  Future<NetworkResult<dynamic>> fetchRemittance() =>
      _provider.fetchRemittance();
}