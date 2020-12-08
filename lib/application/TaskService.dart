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

  List<SubjectProgress> subjectProgress(List<Task> tasks) {
    List<SubjectProgress> listSubjectProgress = [];
    tasks.forEach((Task element) {
      SubjectProgress newSubjectProgress = new SubjectProgress(element.subject);
      SubjectProgress subjectProgress = listSubjectProgress.firstWhere(
          (SubjectProgress sub_element) =>
              sub_element.title == element.subject.title,
          orElse: () => null);

      if (subjectProgress != null) {
        subjectProgress.addTask(element);
      } else {
        newSubjectProgress.addTask(element);
        listSubjectProgress.add(newSubjectProgress);
      }
    });

    return listSubjectProgress;
  }

  Future<List<TodayClass>> todayClasses() {}
}
