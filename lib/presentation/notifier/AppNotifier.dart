import 'package:flutter/material.dart';

import 'package:flutter_redux_boilerplate/presentation/notifier/TaskNotifier.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class AppNotifier extends ChangeNotifier {
  final TaskNotifier tasks;

  AppNotifier(this.tasks);
}
