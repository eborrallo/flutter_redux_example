// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'core/services/Auth.dart';
import 'core/screens/auth/aut_middleware.dart';
import 'integrations/firebase/FirebaseAuthentification.dart';
import 'integrations/firebase/FirebaseInjectableModule.dart';
import 'integrations/firebase/FirebaseUserMapper.dart';
import 'core/services/navigation/navigation_middleware.dart';
import 'core/screens/auth/sign_up/sign_up_midleware.dart';

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
  gh.factory<NavigationMiddleware>(() => NavigationMiddleware());
  gh.lazySingleton<Auth>(() =>
      FirebaseAuthentification(get<FirebaseAuth>(), get<FirebaseUserMapper>()));
  gh.factory<AuthMiddleware>(() => AuthMiddleware(get<Auth>()));
  gh.factory<SignUpMiddleware>(() => SignUpMiddleware(get<Auth>()));
  return get;
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
