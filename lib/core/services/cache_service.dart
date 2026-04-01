import 'package:get_storage/get_storage.dart';

class CacheService {
  static CacheService instance = CacheService._internal();

  factory CacheService() {
    return instance;
  }

  CacheService._internal();

  final _box = GetStorage();

  void write(String key, String value) {
    _box.write(key, value);
  }

  String? read(String key) {
    return _box.read(key);
  }
}

class CacheKeys {
  static const String isFirstTime = "First-Time";
}
