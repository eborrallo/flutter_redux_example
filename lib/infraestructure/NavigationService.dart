import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/config/screens.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/auth/login/login_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/auth/sign_up/sign_up_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/lecturer/add_lecturer_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/loading/loading_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/main/main_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/subject/add_subject_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/subject/subject_list.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/task/add_task_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/task/details_task_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/timetable/list_timetable_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:page_transition/page_transition.dart';

const int DEFAULT_TIME = 300;
const Duration duration = Duration(milliseconds: DEFAULT_TIME);

@lazySingleton
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  navigateToNext(destination,
      {pageTransition: PageTransitionType.leftToRight}) {
    Future.delayed(Duration.zero, () {
      navigatorKey.currentState
          .push(this._navigate(destination, type: pageTransition));
    });
  }

  navigateToNextAndReplace(destination, pageTransition) {
    this
        .navigatorKey
        .currentState
        .pushReplacement(this._navigate(destination, type: pageTransition));
  }

  navigateBack() {
    this.navigatorKey.currentState.pop();
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
      case ADD_LECTURER_SCREEN:
        screen = AddLecturerScreen();
        break;
      case ADD_SUBJECT_SCREEN:
        screen = AddSubjectScreen();
        break;
      case LIST_SUBJECT_SCREEN:
        screen = SubjectListScreen();
        break;
      case LIST_TIMETABLE_SCREEN:
        screen = ListTimetableScreen();
        break;
      case DETAILS_TASK_SCREEN:
        screen = DetailsTaskScreen();
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
