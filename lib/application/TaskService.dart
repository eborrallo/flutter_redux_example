import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/TaskRepository.dart';
import 'package:injectable/injectable.dart';

@injectable
class TaskService {
  final TaskRepository taskRepository;
  TaskService(this.taskRepository);

  Future<List<Task>> list() {
    return taskRepository.findAll();
  }

  Future<List<SubjectProgress>> subjectProgress(List<Task> tasks) {}
  Future<List<TodayClass>> todayClasses() {}
}
