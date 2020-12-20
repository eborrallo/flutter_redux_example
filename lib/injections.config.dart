// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import 'stubs/ApiStub.dart';
import 'application/notifier/AppNotifier.dart';
import 'domain/services/Auth.dart';
import 'application/notifier/CalendarNotifier.dart';
import 'application/notifier/ClassNotifier.dart';
import 'infraestructure/task/ClassRepository.dart';
import 'infraestructure/firebase/FirebaseAuthentification.dart';
import 'infraestructure/firebase/FirebaseInjectableModule.dart';
import 'infraestructure/firebase/FirebaseUserMapper.dart';
import 'presentation/screens/loading/loading_screen.dart';
import 'infraestructure/NavigationService.dart';
import 'application/notifier/SubjectNotifier.dart';
import 'infraestructure/task/SubjectRepository.dart';
import 'application/notifier/TaskNotifier.dart';
import 'infraestructure/task/TaskRepository.dart';
import 'application/notifier/UserNotifier.dart';

/// Environment names
const _dev = 'dev';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<ApiStub>(() => ApiStub());
  gh.factory<CalendarNotifier>(() => CalendarNotifier());
  gh.lazySingleton<ClassRepository>(() => ClassRepository());
  gh.lazySingleton<FirebaseAuth>(() => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<FirebaseUserMapper>(() => FirebaseUserMapper());
  gh.factory<LoadingScreen>(() => LoadingScreen(key: get<Key>()));
  gh.lazySingleton<NavigationService>(() => NavigationService());
  gh.factory<SubjectNotifier>(() => SubjectNotifier());
  gh.lazySingleton<SubjectRepository>(() => SubjectRepository());
  gh.lazySingleton<TaskRepository>(() => TaskRepository());
  gh.lazySingleton<Auth>(
      () => FirebaseAuthentification(
          get<FirebaseAuth>(), get<FirebaseUserMapper>()),
      registerFor: {_dev});
  gh.factory<ClassNotifier>(() => ClassNotifier(get<ClassRepository>()));
  gh.factory<TaskNotifier>(() => TaskNotifier(get<TaskRepository>()));
  gh.lazySingleton<UserNotifier>(() => UserNotifier(auth: get<Auth>()));
  gh.lazySingleton<AppNotifier>(() => AppNotifier(
        get<TaskNotifier>(),
        get<SubjectNotifier>(),
        get<ClassNotifier>(),
        get<CalendarNotifier>(),
      ));
  return get;
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
