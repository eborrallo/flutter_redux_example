import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/application/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/TaskNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/domain/task/taskCollection.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/fab_with_icons.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class AppNotifier extends ChangeNotifier {
  final TaskNotifier tasksNotifier;
  final SubjectNotifier subjectsNotifier;

  final GlobalKey<FabWithIconsState> floatActionButtonKey =
      GlobalKey<FabWithIconsState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Task _taskSelected;
  TodayClass _todayClassSelected;
  List<SubjectProgress> get onProgress {
    var list = tasksNotifier.progress();
    return list == null ? null : List.unmodifiable(list);
  }

  void toggleTask(String uuid) {
    tasksNotifier.toggleTask(uuid);
    notifyListeners();
  }

  void deleteSubject(uuid) {
    subjectsNotifier.delete(uuid);
    tasksNotifier.deleteBy((Task task) => task.subject.uuid == uuid);
  }

  void addTask(Task _task) {
    tasksNotifier.addTask(_task);
    notifyListeners();
  }

  void selectTask(Task _task) {
    this._taskSelected = _task;
    notifyListeners();
  }

  void selectTodayClass(TodayClass _todayClass) {
    this._todayClassSelected = _todayClass;
    notifyListeners();
  }

  void updateSubject(Subject subject) {
    subjectsNotifier.updateSubject(subject);
    tasksNotifier.updateTasksWithSubject(subject);
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

  Task get taskSelected => this._taskSelected;
  TodayClass get todayClassSelected => this._todayClassSelected ?? null;

  String get totalTasksThisWeek =>
      tasksNotifier.tasksThisWeek?.length.toString();

  Map<DateTime, List<Task>> get calendarEvents => tasksNotifier.taskByDay();

  List<Task> get almostDue => tasksNotifier.tasks == null
      ? null
      : List.unmodifiable(
          tasksNotifier.tasks.where((Task element) => !element.done));

  List<TodayClass> get todayClasses => subjectsNotifier.todayClasses == null
      ? null
      : List.unmodifiable(subjectsNotifier.todayClasses);

  AppNotifier(this.tasksNotifier, this.subjectsNotifier);
}
