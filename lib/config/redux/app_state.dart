import 'package:flutter_redux_boilerplate/core/screens/auth/auth_state.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/sign_up/sign_up.state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final AuthState auth;
  final SignUpState signUp;
  final String route;

  AppState({AuthState auth, SignUpState signUp, String route})
      : auth = auth ?? new AuthState(),
        signUp = signUp ?? new SignUpState(),
        route = route ?? '';

  static AppState rehydrationJSON(dynamic json) {
    json = json ?? (new AppState()).toJson();
    return new AppState(
        auth: new AuthState.fromJSON(json['auth']),
        signUp: new SignUpState.fromJSON(json['signUp']),
        route: json['route']);
  }

  Map<String, dynamic> toJson() =>
      {'auth': auth.toJSON(), 'signUp': signUp.toJSON(), 'route': route};

  AppState copyWith({bool rehydrated, AuthState auth, SignUpState signUp, String route }) {
    return new AppState(
      auth: auth ?? this.auth,
      signUp: signUp ?? this.signUp,
      route: route ?? this.route,
    );
  }

  @override
  String toString() {
    return '''AppState{
            auth: $auth,
            signUp: $signUp,
            route: $route,
        }''';
  }
}
