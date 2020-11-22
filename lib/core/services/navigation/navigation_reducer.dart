import 'package:flutter_redux_boilerplate/config/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/core/services/navigation/navigation_actions.dart';
import 'package:redux/redux.dart';

Reducer<String> navigationReducer = combineReducers([
  new TypedReducer<String, NavigateToNext>(saveRoute),
  new TypedReducer<String, NavigateToNextAndReplace>(saveRoute),
  new TypedReducer<String, NavigateBack>(saveRoute),
]);

String saveRoute(String state,  action) {
  return  action.destination;
}

