
import 'package:flutter_redux_boilerplate/injections.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;
//  flutter packages pub run build_runner build --delete-conflicting-outputs
//  flutter packages pub run build_runner watch --delete-conflicting-outputs

@InjectableInit(generateForDir: ['test','lib'])
void configureInjection(String env)=>
  $initGetIt(getIt, environment: env);
