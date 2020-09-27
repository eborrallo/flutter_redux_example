import 'package:flutter_redux_boilerplate/contexts/auth/auth_state.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/sign_up/sign_up.state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
    final AuthState auth;
    final SignUpState signUp;

    AppState({AuthState auth, SignUpState signUp}):
        auth = auth ?? new AuthState(),
        signUp = signUp ?? new SignUpState();

    static AppState rehydrationJSON(dynamic json) => new AppState(
        auth: new AuthState.fromJSON(json['auth']),
        signUp: new SignUpState.fromJSON(json['signUp'])
    );

    Map<String, dynamic> toJson() => {
        'auth': auth.toJSON(),
        'signUp': signUp.toJSON()
    };

    AppState copyWith({
        bool rehydrated,
        AuthState auth,
        SignUpState signUp
    }) {
        return new AppState(
            auth: auth ?? this.auth,
            signUp: signUp ?? this.signUp
        );
    }

    @override
    String toString() {
        return '''AppState{
            auth: $auth,
            signUp: $signUp,
        }''';
    }
}