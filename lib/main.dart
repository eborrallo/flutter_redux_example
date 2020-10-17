import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_boilerplate/containers/platform_adaptive.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/login/login_screen.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/sign_up/sign_up_screen.dart';
import 'package:flutter_redux_boilerplate/contexts/main/main_screen.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/redux/store.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection(Environment.dev);
  final store = await createStore();
  return runApp(new ReduxApp(store: store));
}

class ReduxApp extends StatelessWidget {
  final Store<AppState> store;

  const ReduxApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: new MaterialApp(
            title: 'ReduxApp',
            theme: defaultTargetPlatform == TargetPlatform.iOS
                ? kIOSTheme
                : kDefaultTheme,
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) =>
                  new StoreConnector<AppState, dynamic>(
                      converter: (store) => store.state.auth.isAuthenticated,
                      builder: (BuildContext context, isAuthenticated) =>
                          isAuthenticated
                              ? new MainScreen()
                              : new LoginScreen()),
              '/login': (BuildContext context) => new LoginScreen(),
              '/main': (BuildContext context) => new MainScreen(),
              '/signUp': (BuildContext context) => new SignUpScreen(),
            }));
  }
}
