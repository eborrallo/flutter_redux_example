import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/config/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/config/screens.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/login/login_screen.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/sign_up/sign_up_screen.dart';
import 'package:flutter_redux_boilerplate/core/screens/loading/loading_screen.dart';
import 'package:flutter_redux_boilerplate/core/screens/main/main_screen.dart';
import 'package:flutter_redux_boilerplate/core/screens/subject/add_subject_screen.dart';
import 'package:flutter_redux_boilerplate/core/screens/task/add_task_screen.dart';
import 'package:flutter_redux_boilerplate/core/services/navigation/navigation_actions.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
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
    navigatorKey.currentState
        .push(this._navigate(action.destination, type: action.pageTransition));
    next(action);
  }

  Middleware<AppState> _navigateToNextAndReplaceMiddleware(
      Store<AppState> store,
      NavigateToNextAndReplace action,
      NextDispatcher next) {
    this.navigatorKey.currentState.pushReplacement(
        this._navigate(action.destination, type: action.pageTransition));
    next(action);
  }

  Middleware<AppState> _navigateBackMiddleware(
      Store<AppState> store, action, NextDispatcher next) {
    //final currentActivePages = store.state.activePages;
    //if (currentActivePages.length == 1) SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    this.navigatorKey.currentState.pop();
    next(action);
  }

  _navigate(String page,
      {PageTransitionType type = PageTransitionType.leftToRight,
      Alignment alignment = Alignment.bottomCenter,
      Curve curve = Curves.ease,
      Duration duration = duration}) {
    Widget screen;
    switch (page) {
      case LOGIN_SCREEN:
        screen = LoginScreen();
        break;
      case SIGNUP_SCREEN:
        screen = SignUpScreen();
        break;
      case MAIN_SCREEN:
        screen = MainScreen();
        break;
      case ADD_TASK_SCREEN:
        screen = AddTaskScreen();
        break;
      case ADD_SUBJECT_SCREEN:
        screen = AddSubjectScreen();
        break;
      default:
        screen = LoadingScreen();
        break;
    }
    return PageTransition(
        type: type,
        alignment: alignment,
        child: screen,
        curve: curve,
        duration: duration);
  }
}

List<Middleware<AppState>> createNavigationMiddleware(navigationKey) {
  NavigationMiddleware middleware = getIt<NavigationMiddleware>();
  middleware.navigatorKey = navigationKey;
  return middleware.getMiddlewares();
}
