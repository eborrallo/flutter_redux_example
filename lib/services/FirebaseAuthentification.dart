import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as f;
import 'package:flutter/services.dart';
import 'package:flutter_redux_boilerplate/models/user.dart';
import 'package:flutter_redux_boilerplate/services/FirebaseUserMapper.dart';
import 'package:injectable/injectable.dart';

abstract class Auth{
   Future<Either<String, Unit>> registerWithEmailAndPassword({
     String emailAddress,
     String password,
  });
}

@LazySingleton(as: Auth)
class FirebaseAuthentification implements Auth{
  final f.FirebaseAuth _firebaseAuth;
  final FirebaseUserMapper _firebaseUserMapper;

  FirebaseAuthentification(
    this._firebaseAuth,
    this._firebaseUserMapper,
  );

  Future<Either<String, Unit>> registerWithEmailAndPassword({
     String emailAddress,
     String password,
  }) async {
    final emailAddressStr = emailAddress;
    final passwordStr = password;
    try {
      return await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: emailAddressStr,
            password: passwordStr,
          )
          .then((_) => right(unit));
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return left( 'cacaaaa');
      } else {
        return left( 'aaaa');
      }
    }
  }



  @override
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }
}


