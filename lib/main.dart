import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux_boilerplate/infraestructure/NavigationService.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/UserNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/auth/login/login_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/auth/sign_up/sign_up_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/loading/loading_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/main/main_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection(Environment.dev);

  return runApp(new CalendarApp());
}

class CalendarApp extends StatelessWidget {
  CalendarApp({Key key}) : super(key: key);
  final NavigationService navigationService = getIt<NavigationService>();
  final UserNotifier userNotifier = getIt<UserNotifier>();
  final AppNotifier appNotifier =  getIt<AppNotifier>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => userNotifier),
          ChangeNotifierProvider.value(value: appNotifier),
          ChangeNotifierProvider.value(value: appNotifier.tasksNotifier),
          ChangeNotifierProvider.value(value: appNotifier.subjectsNotifier),
          ChangeNotifierProvider.value(value: appNotifier.classNotifier),
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
            navigatorKey: navigationService.navigatorKey,
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) {
                if (userNotifier.isLoading == false &&
                    userNotifier.user == null) {
                  return new LoginScreen();
                } else if (userNotifier.isLoading == false &&
                    userNotifier.user != null) {
                  return new MainScreen();
                }
                return new LoadingScreen();
              },
              '/login': (BuildContext context) => new LoginScreen(),
              '/main': (BuildContext context) => new MainScreen(),
              '/signUp': (BuildContext context) => new SignUpScreen(),
            }));
  }
}
