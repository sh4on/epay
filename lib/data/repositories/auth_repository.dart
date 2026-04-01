import '../providers/auth_provider.dart';
import '../../core/services/network_service.dart';

// repository layer — sits between controller and provider
class AuthRepository {
  final AuthProvider _provider;

  AuthRepository(this._provider);

  // login
  Future<NetworkResult<dynamic>> login({
    required String phone,
    required String pin,
  }) {
    return _provider.login(phone: phone, pin: pin);
  }

  // signup
  Future<NetworkResult<dynamic>> signup({
    required String phone,
    required String pin,
  }) {
    return _provider.signup(phone: phone, pin: pin);
  }

  // verify otp
  Future<NetworkResult<dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) {
    return _provider.verifyOtp(phone: phone, otp: otp);
  }
}
