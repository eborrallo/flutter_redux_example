import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/UserNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/auth/login/login_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/auth/sign_up/sign_up_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/main/main_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection(Environment.dev);
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  return runApp(new CalendarApp(navigatorKey: navigatorKey));
}

class CalendarApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const CalendarApp({Key key, this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => getIt<UserNotifier>()),
        ],
        child: new MaterialApp(
            title: 'CalendarApp',
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
              '/': (BuildContext context) => new MainScreen(),
              '/login': (BuildContext context) => new LoginScreen(),
              '/main': (BuildContext context) => new MainScreen(),
              '/signUp': (BuildContext context) => new SignUpScreen(),
            }));
  }
}
