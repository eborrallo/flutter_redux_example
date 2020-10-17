import 'package:firebase_auth/firebase_auth.dart' as f;
import 'package:flutter_redux_boilerplate/models/user.dart';
import 'package:injectable/injectable.dart';

@lazySingleton 
class FirebaseUserMapper {
  User toDomain(f.FirebaseUser _) {
    return _ == null
        ? null
        : new User(
            _.uid,
            _.uid,
          );
  }
}
