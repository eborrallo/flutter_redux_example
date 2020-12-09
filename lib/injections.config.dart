// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import 'presentation/notifier/AppNotifier.dart';
import 'domain/services/Auth.dart';
import 'application/CircularProgresItemFactory.dart';
import 'infraestructure/firebase/FirebaseAuthentification.dart';
import 'infraestructure/firebase/FirebaseInjectableModule.dart';
import 'infraestructure/firebase/FirebaseUserMapper.dart';
import 'presentation/screens/loading/loading_screen.dart';
import 'infraestructure/NavigationService.dart';
import 'application/TaskCardFactory.dart';
import 'presentation/notifier/TaskNotifier.dart';
import 'infraestructure/task/TaskRepository.dart';
import 'application/TaskService.dart';
import 'presentation/notifier/UserNotifier.dart';
import 'application/UserService.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<CircularProgresItemFactory>(
      () => CircularProgresItemFactory());
  gh.lazySingleton<FirebaseAuth>(() => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<FirebaseUserMapper>(() => FirebaseUserMapper());
  gh.factory<LoadingScreen>(() => LoadingScreen(key: get<Key>()));
  gh.lazySingleton<NavigationService>(() => NavigationService());
  gh.lazySingleton<TaskRepository>(() => TaskRepository());
  gh.factory<TaskService>(() => TaskService(get<TaskRepository>()));
  gh.lazySingleton<Auth>(() =>
      FirebaseAuthentification(get<FirebaseAuth>(), get<FirebaseUserMapper>()));
  gh.factory<TasckCardFactroy>(() => TasckCardFactroy(get<TaskService>()));
  gh.factory<TaskNotifier>(() => TaskNotifier(get<TaskService>()));
  gh.factory<UserService>(() => UserService(authService: get<Auth>()));
  gh.lazySingleton<AppNotifier>(() => AppNotifier(get<TaskNotifier>()));
  gh.lazySingleton<UserNotifier>(() => UserNotifier(app: get<UserService>()));
  return get;
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
