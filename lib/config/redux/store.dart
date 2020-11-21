import 'package:flutter_redux_boilerplate/config/redux/app_reducer.dart';
import 'package:flutter_redux_boilerplate/config/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/config/redux/middleware.dart';
import 'package:redux/redux.dart';


Future<Store<AppState>> createStore(navigatorKey) async{ 

    Store<AppState> store = new Store(
        appReducer,
        initialState: await persistor.load(),
        middleware: createMiddleware(navigatorKey)
    );

    return store;
}