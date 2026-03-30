import '../../core/services/network_service.dart';

// mock api provider for auth — replace endpoints with real ones later
class AuthProvider {
  // mock base url
  static const String _base = 'https://jsonplaceholder.typicode.com';

  // mock login endpoint
  Future<NetworkResult<dynamic>> login({
    required String phone,
    required String pin,
  }) async {
    // replace with real endpoint
    return NetworkResult.success(
      {
        'id': '1',
        'name': 'RAHUL',
        'phone': phone,
        'balance': 13999.00,
        'points': 1972,
        'avatar_url': null,
      },
      200,
      'Success',
    );
  }

  // mock signup endpoint
  Future<NetworkResult<dynamic>> signup({
    required String phone,
    required String pin,
  }) async {
    // replace with real endpoint
    return NetworkResult.success(
      {'phone': phone, 'otp_sent': true},
      200,
      'OTP sent',
    );
  }

  // mock otp verification endpoint
  Future<NetworkResult<dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    // replace with real endpoint — mock accepts any 4-digit otp
    return NetworkResult.success(
      {
        'id': '1',
        'name': 'RAHUL',
        'phone': phone,
        'balance': 13999.00,
        'points': 1972,
        'avatar_url': null,
      },
      200,
      'Verified',
    );
  }
}