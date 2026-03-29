import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'epay_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // lock to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const EPayApp());
}