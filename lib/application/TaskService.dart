import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/TaskRepository.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

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

  String timeLeft(DateTime deliveryTime) {
    DateTime now = new DateTime.now();
    Duration difference = deliveryTime.difference(now);
    String hours = difference.inHours.toString();
    var formatter = new DateFormat('m');

    String minutes =
        formatter.format(now.subtract(new Duration(hours: difference.inHours)));
    return hours + "h " + minutes + "m ";
  }

  Future<List<TodayClass>> todayClasses() {}
}
