import 'package:get_storage/get_storage.dart';

class CacheService {
  static CacheService instance = CacheService._internal();

  factory CacheService() {
    return instance;
  }

  CacheService._internal();

  final box = GetStorage();

  void write(String key, String value) {
    box.write(key, value);
  }

  String? read(String key) {
    return box.read(key);
  }
}

class CacheKeys {
  static const String isFirstTime = "First-Time";
}
