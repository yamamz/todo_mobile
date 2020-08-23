// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:todo_mobile/service/api_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  //Register prod Dependencies --------
  if (environment == 'prod') {
    g.registerFactory<ApiService>(() => ApiService());
  }
}
