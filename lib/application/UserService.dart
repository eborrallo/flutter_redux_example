import 'package:flutter_redux_boilerplate/domain/services/Auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserService {
  final Auth authService;

  UserService({Auth authService}) : authService = authService;
}
