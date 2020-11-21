import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_boilerplate/config/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/config/redux/store.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/login/login_screen.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/sign_up/sign_up_screen.dart';
import 'package:flutter_redux_boilerplate/core/screens/loading/loading_screen.dart';
import 'package:flutter_redux_boilerplate/core/screens/main/main_screen.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: new MaterialApp(
            title: 'ReduxApp',
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('es', 'ES'),
            ],
            theme: new ThemeData(
              primarySwatch: Colors.grey,
            ),
            // theme: defaultTargetPlatform == TargetPlatform.iOS? kIOSTheme                : kDefaultTheme,
            navigatorKey: navigatorKey,
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => new LoadingScreen(),
              '/login': (BuildContext context) => new LoginScreen(),
              '/main': (BuildContext context) => new MainScreen(),
              '/signUp': (BuildContext context) => new SignUpScreen(),
            }));
  }
}
