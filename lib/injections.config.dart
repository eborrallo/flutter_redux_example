// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import 'stubs/ApiStub.dart';
import 'presentation/notifier/AppNotifier.dart';
import 'domain/services/Auth.dart';
import 'presentation/notifier/ClassNotifier.dart';
import 'infraestructure/task/ClassRepository.dart';
import 'application/ClassService.dart';
import 'mocks/FirebaseAuthMock.dart';
import 'infraestructure/firebase/FirebaseAuthentification.dart';
import 'infraestructure/firebase/FirebaseInjectableModule.dart';
import 'infraestructure/firebase/FirebaseUserMapper.dart';
import 'presentation/screens/loading/loading_screen.dart';
import 'infraestructure/NavigationService.dart';
import 'presentation/notifier/SubjectNotifier.dart';
import 'infraestructure/task/SubjectRepository.dart';
import 'application/SubjectService.dart';
import 'presentation/notifier/TaskNotifier.dart';
import 'infraestructure/task/TaskRepository.dart';
import 'application/TaskService.dart';
import 'presentation/notifier/UserNotifier.dart';
import 'application/UserService.dart';

/// Environment names
const _test = 'test';
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
  gh.lazySingleton<Auth>(() => FirebaseAuthMock(), registerFor: {_test});
  gh.lazySingleton<ClassRepository>(() => ClassRepository());
  gh.factory<ClassService>(() => ClassService(get<ClassRepository>()));
  gh.lazySingleton<FirebaseAuth>(() => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<FirebaseUserMapper>(() => FirebaseUserMapper());
  gh.factory<LoadingScreen>(() => LoadingScreen(key: get<Key>()));
  gh.lazySingleton<NavigationService>(() => NavigationService());
  gh.lazySingleton<SubjectRepository>(() => SubjectRepository());
  gh.factory<SubjectService>(() => SubjectService(get<SubjectRepository>()));
  gh.lazySingleton<TaskRepository>(() => TaskRepository());
  gh.factory<TaskService>(() => TaskService(get<TaskRepository>()));
  gh.factory<UserService>(() => UserService(authService: get<Auth>()));
  gh.lazySingleton<Auth>(
      () => FirebaseAuthentification(
          get<FirebaseAuth>(), get<FirebaseUserMapper>()),
      registerFor: {_dev});
  gh.factory<ClassNotifier>(() => ClassNotifier(get<ClassService>()));
  gh.factory<SubjectNotifier>(() => SubjectNotifier(get<SubjectService>()));
  gh.factory<TaskNotifier>(() => TaskNotifier(get<TaskService>()));
  gh.lazySingleton<UserNotifier>(() => UserNotifier(app: get<UserService>()));
  gh.lazySingleton<AppNotifier>(() => AppNotifier(
        get<TaskNotifier>(),
        get<SubjectNotifier>(),
        get<ClassNotifier>(),
      ));
  return get;
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
