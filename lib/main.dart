import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_boilerplate/containers/platform_adaptive.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/login/login_screen.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/sign_up/sign_up_screen.dart';
import 'package:flutter_redux_boilerplate/contexts/loading/loading_screen.dart';
import 'package:flutter_redux_boilerplate/contexts/main/main_screen.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/redux/store.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';

Store<AppState> store;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection(Environment.dev);
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  store = await createStore(navigatorKey);
  return runApp(new ReduxApp(store: store, navigatorKey: navigatorKey));
}

class ReduxApp extends StatelessWidget {
  final Store<AppState> store;
  final GlobalKey<NavigatorState> navigatorKey;
  const ReduxApp({Key key, this.store, this.navigatorKey}) : super(key: key);

  onGenerateRoutes(settings) {
    print(settings);
    if (settings.name == "/main") {
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => LoadingScreen(),
        transitionsBuilder: (_, anim, __, child) {
          return FadeTransition(opacity: anim, child: child);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: new MaterialApp(
            title: 'ReduxApp',
            theme: defaultTargetPlatform == TargetPlatform.iOS
                ? kIOSTheme
                : kDefaultTheme,
            navigatorKey: navigatorKey,
           // onGenerateRoute: (settings) => onGenerateRoutes(settings),
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => new LoadingScreen(),

              /* (BuildContext context) =>
                  new StoreConnector<AppState, dynamic>(
                      converter: (store) => store.state.auth.isAuthenticated,
                      builder: (BuildContext context, isAuthenticated) =>
                          isAuthenticated
                              ? new MainScreen()
                              : new LoginScreen()),
              */
              '/login': (BuildContext context) => new LoginScreen(),
              '/main': (BuildContext context) => new MainScreen(),
              '/signUp': (BuildContext context) => new SignUpScreen(),
            }));
  }
}
