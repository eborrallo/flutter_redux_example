import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subjectCollection.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubjectNotifier extends ChangeNotifier {
  List<SubjectProgress> progress({List<Task> listTask}) {
    return listTask == null
        ? null
        : SubjectCollection.subjectProgress(listTask);
  }
}
