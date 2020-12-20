import 'package:flutter/foundation.dart';
import 'package:flutter_redux_boilerplate/domain/services/Auth.dart';
import 'package:flutter_redux_boilerplate/domain/user/user.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class UserNotifier extends ChangeNotifier {
  bool isLoading = false;
  User user = new User('aaa', 'asasda');
  final Auth _auth;

  UserNotifier({Auth auth}) : _auth = auth {
    /*  _auth.authService.getSignedInUser().then((User value) {
      user = value;
      isLoading = false;
      notifyListeners();
    }); */
  }
  init() {
    return Future.delayed(Duration(milliseconds: 1),
        () => this._auth.getSignedInUser());
  }

  register(String emailAddress, String password) async {
    await _auth.registerWithEmailAndPassword(emailAddress, password);
    user = await _auth.getSignedInUser();
    notifyListeners();
  }
}
