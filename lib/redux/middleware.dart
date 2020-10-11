import 'package:flutter_redux_boilerplate/contexts/auth/aut_middleware.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/sign_up/sign_up_midleware.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

final persistor = new Persistor<AppState>(
    storage: new FlutterStorage('redux-app'),
    decoder: AppState.rehydrationJSON);

// Set up middlewares
List<Middleware<AppState>> createMiddleware() => <Middleware<AppState>>[
      //thunkMiddleware,
      persistor.createMiddleware(),
      new LoggingMiddleware.printer()
    ]
      ..addAll(createStoreAuthMiddleware())
      ..addAll(createStoreSignUpMiddleware());
