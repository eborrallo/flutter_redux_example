import 'package:flutter_redux_boilerplate/config/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/aut_middleware.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/sign_up/sign_up_midleware.dart';
import 'package:flutter_redux_boilerplate/core/services/navigation/navigation_middleware.dart';

import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

final persistor = new Persistor<AppState>(
    storage: new FlutterStorage(),
    serializer:JsonSerializer<AppState>( AppState.rehydrationJSON));

// Set up middlewares
List<Middleware<AppState>> createMiddleware(navigatorKey) => <Middleware<AppState>>[
      persistor.createMiddleware(),
    //  new LoggingMiddleware.printer(),
    ]
      ..addAll(createStoreAuthMiddleware(navigatorKey))
      ..addAll(createStoreSignUpMiddleware())
      ..addAll(createNavigationMiddleware(navigatorKey));
    
