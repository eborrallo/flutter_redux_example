import 'package:firebase_auth/firebase_auth.dart' as f;
import 'package:flutter_redux_boilerplate/core/models/user.dart';
import 'package:injectable/injectable.dart';

@lazySingleton 
class FirebaseUserMapper {
  User toDomain(f.User _) {
    return _ == null
        ? null
        : new User(
            _.email,
            _.uid,
          );
  }
}
