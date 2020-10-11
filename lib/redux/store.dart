import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/redux/middleware.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_boilerplate/redux/app_reducer.dart';

Future<Store<AppState>> createStore() async{ 

    Store<AppState> store = new Store(
        appReducer,
        initialState: await persistor.load(),
        middleware: createMiddleware()
    );

    return store;
}