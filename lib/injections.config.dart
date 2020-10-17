// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'services/FirebaseAuthentification.dart';
import 'contexts/auth/aut_middleware.dart';
import 'services/FirebaseInjectableModule.dart';
import 'services/FirebaseUserMapper.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<FirebaseAuth>(() => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<FirebaseUserMapper>(() => FirebaseUserMapper());
  gh.lazySingleton<Auth>(() =>
      FirebaseAuthentification(get<FirebaseAuth>(), get<FirebaseUserMapper>()));
  gh.factory<AuthMiddleware>(() => AuthMiddleware(get<Auth>()));
  return get;
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
