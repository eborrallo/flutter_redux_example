import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/UserService.dart';
import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/CalendarNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/ClassNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/TaskNotifier.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class AppNotifier extends ChangeNotifier {
  final TaskNotifier tasksNotifier;
  final SubjectNotifier subjectsNotifier;
  final ClassNotifier classNotifier;
  final CalendarNotifier calendarNotifier;
  final UserService userService;

  List<SubjectProgress> get onProgress {
    var list = subjectsNotifier.progress(listTask: tasksNotifier.tasks);
    return list == null ? null : List.unmodifiable(list);
  }

  void toggleTask(String uuid) {
    tasksNotifier.toggleTask(uuid);
    classNotifier.toggleTask(uuid);

    notifyListeners();
  }

  double get weekCompletation {
    List<Task> tasksWeek = tasksNotifier.tasksThisWeek ?? [];
    if (tasksWeek.length == 0) {
      return 0;
    }
    List<Task> tasksWeekDone =
        tasksWeek.where((Task _taks) => _taks.done).toList();
    return ((tasksWeekDone.length * 100) / tasksWeek.length);
  }

  String get totalTasksThisWeek =>
      tasksNotifier.tasksThisWeek?.length.toString();

  Map<DateTime, List<Task>> get calendarEvents =>
      calendarNotifier.taskByDay(tasksNotifier.allTasks);

  List<Task> get almostDue => tasksNotifier.tasks == null
      ? null
      : List.unmodifiable(
          tasksNotifier.tasks.where((Task element) => !element.done));

  List<TodayClass> get todayClasses => classNotifier.todayClasses == null
      ? null
      : List.unmodifiable(classNotifier.todayClasses);

  AppNotifier(this.tasksNotifier, this.subjectsNotifier, this.classNotifier,
      this.calendarNotifier, this.userService);


}
