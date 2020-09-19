import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/redux/middleware.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_boilerplate/redux/app_reducer.dart';

Store<AppState> createStore() { 
    Store<AppState> store = new Store(
        appReducer,
        initialState: new AppState(),
        middleware: createMiddleware()
    );
    persistor.load(store);

    return store;
}