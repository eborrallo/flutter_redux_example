import 'package:flutter/foundation.dart';
import 'package:flutter_redux_boilerplate/application/UserService.dart';
import 'package:flutter_redux_boilerplate/domain/user/user.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class UserNotifier extends ChangeNotifier {
  User user;
  final UserService _app;

  UserNotifier({UserService app}) : _app = app {
    _app.authService.getSignedInUser().then((User value) {
      user = value;
      print(user);

      notifyListeners();
    });
    print(1);
    print(user);
  }
}
