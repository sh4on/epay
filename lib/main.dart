import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'epay_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  // lock to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const EPayApp());
}
