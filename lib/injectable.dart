import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:tark_test/injectable.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
