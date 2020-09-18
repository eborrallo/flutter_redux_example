import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/services/api_client.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> getSomething() =>
   (Store<AppState> store) async {
    String aa= await ApiClient.getSomething();
    print(aa);
  };
