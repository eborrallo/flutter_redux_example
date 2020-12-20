import 'package:flutter/foundation.dart';
import 'package:flutter_redux_boilerplate/application/UserService.dart';
import 'package:flutter_redux_boilerplate/domain/user/user.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class UserNotifier extends ChangeNotifier {
  bool isLoading = false;
  User user = new User('aaa', 'asasda');
  final UserService _app;

  UserNotifier({UserService app}) : _app = app {
    /*  _app.authService.getSignedInUser().then((User value) {
      user = value;
      isLoading = false;
      notifyListeners();
    }); */
  }
  init() {
    return Future.delayed(Duration(milliseconds: 1),
        () => this._app.authService.getSignedInUser());
  }

  register(String emailAddress, String password) async {
    await _app.authService.registerWithEmailAndPassword(emailAddress, password);
    user = await _app.authService.getSignedInUser();
    notifyListeners();
  }
}
