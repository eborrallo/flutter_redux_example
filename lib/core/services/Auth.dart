import 'package:firebase_auth/firebase_auth.dart' as f;
import 'package:flutter_redux_boilerplate/core/models/user.dart';


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