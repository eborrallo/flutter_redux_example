
import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:injectable/injectable.dart';

@injectable
class TaskService {
  Future<List<Task>> list() {}
  Future<List<SubjectProgress>> subjectProgress(List<Task> tasks) {}
  Future<List<TodayClass>> todayClasses() {}

}
