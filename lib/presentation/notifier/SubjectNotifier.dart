import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/SubjectService.dart';
import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubjectNotifier extends ChangeNotifier {
  bool isLoading = false;
  List<SubjectProgress> _subjectsProgress;
  final SubjectService _app;

  SubjectNotifier(this._app);

  List<SubjectProgress> progress({List<Task> listTask = null}) {
    return listTask == null ? null : _app.subjectProgress(listTask);
  
  }
}
