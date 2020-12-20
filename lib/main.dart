import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux_boilerplate/application/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/UserNotifier.dart';
import 'package:flutter_redux_boilerplate/infraestructure/NavigationService.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
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

  return runApp(new CalendarApp(
    navigationService: getIt<NavigationService>(),
    userNotifier: getIt<UserNotifier>(),
    appNotifier: getIt<AppNotifier>(),
  ));
}

class CalendarApp extends StatelessWidget {
  final NavigationService navigationService;
  final UserNotifier userNotifier;
  final AppNotifier appNotifier;
  CalendarApp(
      {Key key, this.navigationService, this.userNotifier, this.appNotifier})
      : super(key: key){
      }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => userNotifier),
          ChangeNotifierProvider.value(value: appNotifier),
          ChangeNotifierProvider.value(value: appNotifier.tasksNotifier),
          ChangeNotifierProvider.value(value: appNotifier.subjectsNotifier),
          ChangeNotifierProvider.value(value: appNotifier.classNotifier),
          ChangeNotifierProvider.value(value: appNotifier.calendarNotifier),
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
            home: FutureBuilder(
              future: userNotifier.init(),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.data != null
                    ? MainScreen()
                    : MainScreen(); //LoadingScreen();
              },
            ),
            routes: <String, WidgetBuilder>{
              'home': (BuildContext context) => new LoadingScreen(),
              'login': (BuildContext context) => new LoginScreen(),
              'main': (BuildContext context) => new MainScreen(),
              'signUp': (BuildContext context) => new SignUpScreen(),
              'addTask': (BuildContext context) => new SignUpScreen(),
            }));
  }
}
