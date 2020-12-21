import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';

class SubjectProgress {
  final String title;
  final Subject subject;
  double progress = 0;
  List<Task> _listTask = [];

  SubjectProgress(Subject subject)
      : title = subject.title,
        subject = subject;

  addTask(Task task) {
    _listTask.add(task);
    _updateProgress();
  }

  _updateProgress() {
    progress = (_listTask.where((Task element) => element.done).length * 100) /
        _listTask.length;
  }
}
