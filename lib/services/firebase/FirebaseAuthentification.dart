import 'package:firebase_auth/firebase_auth.dart' as f;
import 'package:flutter_redux_boilerplate/models/user.dart';
import 'package:flutter_redux_boilerplate/services/firebase/FirebaseUserMapper.dart';
import 'package:injectable/injectable.dart';

abstract class Auth {
  Future<f.UserCredential> registerWithEmailAndPassword(
    String emailAddress,
    String password,
  );
  Future<User> signInWithEmailAndPassword(
    String emailAddress,
    String password,
  );
  Future<User> getSignedInUser();
}

@LazySingleton(as: Auth)
class FirebaseAuthentification implements Auth {
  final f.FirebaseAuth _firebaseAuth;
  final FirebaseUserMapper _firebaseUserMapper;

  FirebaseAuthentification(
    this._firebaseAuth,
    this._firebaseUserMapper,
  );
  @override
  Future<User> getSignedInUser() async =>
      _firebaseUserMapper.toDomain(_firebaseAuth.currentUser);

  @override
  Future<f.UserCredential> registerWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    final emailAddressStr = emailAddress;
    final passwordStr = password;

    return await _firebaseAuth
        .createUserWithEmailAndPassword(
          email: emailAddressStr,
          password: passwordStr,
        )
        .then((userCredential) => userCredential);
  }

  @override
  Future<User> signInWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    final emailAddressStr = emailAddress;
    final passwordStr = password;
    try {
       await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );
      return this.getSignedInUser();
    } on f.FirebaseAuthException catch (e) {
     throw new Exception(e.message);
    }
  }

  @override
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }
}
