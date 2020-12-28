import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subjectCollection.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/SubjectRepository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubjectNotifier extends ChangeNotifier {
  final SubjectRepository repository;

  SubjectCollection _collection;
  SubjectNotifier(this.repository) {
    _updateList();
  }

  List<SubjectProgress> progress({List<Task> listTask}) {
    return listTask == null
        ? null
        : SubjectCollection.subjectProgress(listTask);
  }

  List<Subject> get allSubjects =>
      _collection?.list == null ? null : List.unmodifiable(_collection.list);
      
  void addSubject(Subject subject) {
    _collection.list.add(subject);
    notifyListeners();
  }

  void _updateList() {
    repository.findAll().then((list) {
      _collection = SubjectCollection(list: list);
      notifyListeners();
    });
  }
}
