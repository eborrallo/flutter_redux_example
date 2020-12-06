// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'domain/Auth.dart';
import 'infraestructure/firebase/FirebaseAuthentification.dart';
import 'infraestructure/firebase/FirebaseInjectableModule.dart';
import 'infraestructure/firebase/FirebaseUserMapper.dart';

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
  return get;
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
