import 'package:injectable/injectable.dart';

@dev
@lazySingleton
class Clock {
  DateTime now() {
    return DateTime.now();
  }
}
