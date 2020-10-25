import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/login/login_screen.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/sign_up/sign_up_screen.dart';
import 'package:flutter_redux_boilerplate/contexts/loading/loading_screen.dart';
import 'package:flutter_redux_boilerplate/contexts/main/main_screen.dart';
import 'package:flutter_redux_boilerplate/contexts/navigation/navigation_actions.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:injectable/injectable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:redux/redux.dart';

const int DEFAULT_TIME = 300;
const Duration duration = Duration(milliseconds: DEFAULT_TIME);

@injectable
class NavigationMiddleware {
  GlobalKey<NavigatorState> navigatorKey;

  List<Middleware<AppState>> getMiddlewares() {
    return [
      TypedMiddleware<AppState, NavigateToNext>(_navigateToNextMiddleware),
      TypedMiddleware<AppState, NavigateToNextAndReplace>(
          _navigateToNextAndReplaceMiddleware),
      TypedMiddleware<AppState, NavigateBack>(_navigateBackMiddleware)
    ];
  }

  Middleware<AppState> _navigateToNextMiddleware(
      Store<AppState> store, NavigateToNext action, NextDispatcher next) {
    navigatorKey.currentState.push(this._navigate(action.destination));
    next(action);
  }

  Middleware<AppState> _navigateToNextAndReplaceMiddleware(
      Store<AppState> store,
      NavigateToNextAndReplace action,
      NextDispatcher next) {
    this.navigatorKey.currentState.pushReplacement(this._navigate(action.destination));
    next(action);
  }

  Middleware<AppState> _navigateBackMiddleware(
      Store<AppState> store, action, NextDispatcher next ) {
    //final currentActivePages = store.state.activePages;
    //if (currentActivePages.length == 1) SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    this.navigatorKey.currentState.pop();
    next(action);
  }

  _navigate( String page, 
  {PageTransitionType type = PageTransitionType.leftToRight,
  Alignment alignment = Alignment.bottomCenter ,
  Curve curve= Curves.ease ,
  Duration duration= duration }) {
    Widget screen;
    switch (page) {
      case 'login':
        screen=  LoginScreen();
        break;
      case 'signUp':
        screen=  SignUpScreen();
        break;
      case 'main':
        screen=   MainScreen();
        break;
      default:
        screen=  LoadingScreen();
        break;
    }
    return PageTransition(
                type:type,
                alignment:alignment,
                child: screen,
                curve: curve,
                duration:duration);
  }
}

List<Middleware<AppState>> createNavigationMiddleware(navigationKey) {
  NavigationMiddleware middleware = getIt<NavigationMiddleware>();
  middleware.navigatorKey = navigationKey;
  return middleware.getMiddlewares();
}
