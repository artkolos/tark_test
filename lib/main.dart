import 'package:flutter/cupertino.dart';
import 'package:tark_test/injectable.dart';
import 'package:tark_test/presentation/main_screen/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MainScreen());
}
