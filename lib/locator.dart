import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.iconfig.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> setupLocator(String enviroment) async =>
    $initGetIt(getIt, environment: enviroment);
