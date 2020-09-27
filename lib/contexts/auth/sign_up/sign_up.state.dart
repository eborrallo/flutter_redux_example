import 'package:meta/meta.dart';

import 'package:flutter_redux_boilerplate/models/user.dart';

@immutable
class SignUpState {
  // properties
  final String username;
  final String password;

  // constructor with default
  SignUpState({
    this.username,
    this.password
  });

  // allows to modify AuthState parameters while cloning previous ones
  SignUpState copyWith(
      {String username, String password}) {
    return new SignUpState(
      password: password ?? this.password,
      username: username ?? this.username,
    );
  }

  factory SignUpState.fromJSON(Map<String, dynamic> json) => new SignUpState(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJSON() => <String, dynamic>{
        "password" : this.password,
        "username" : this.username,
      };

  @override
  String toString() {
    return '''{
                username: $username,
                password: $password
            }''';
  }
}
