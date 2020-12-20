import 'package:firebase_auth/firebase_auth.dart' as f;
import 'package:flutter_redux_boilerplate/domain/services/Auth.dart';
import 'package:flutter_redux_boilerplate/domain/user/user.dart';
import 'package:flutter_redux_boilerplate/infraestructure/firebase/FirebaseUserMapper.dart';
import 'package:injectable/injectable.dart';

@Environment("dev")
@LazySingleton(as: Auth)
class FirebaseAuthentification implements Auth {
  final f.FirebaseAuth _firebaseAuth;
  final FirebaseUserMapper _firebaseUserMapper;

  FirebaseAuthentification(
    this._firebaseAuth,
    this._firebaseUserMapper,
  );
  @override
  User getSignedInUser()  =>
      _firebaseUserMapper.toDomain(_firebaseAuth.currentUser);

  @override
  Future<f.UserCredential> registerWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    final emailAddressStr = emailAddress;
    final passwordStr = password;

    return _firebaseAuth
        .createUserWithEmailAndPassword(
          email: emailAddressStr,
          password: passwordStr,
        )
        .then((userCredential) => userCredential)
        .catchError((onError) {
      print(onError);
    });
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
