import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux_boilerplate/domain/services/Auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

@Environment("test")
@LazySingleton(as: Auth)
class FirebaseAuthMock extends Mock implements Auth {}
