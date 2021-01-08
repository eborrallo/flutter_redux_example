import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/class/classCollection.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subjectCollection.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/SubjectRepository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubjectNotifier extends ChangeNotifier {
  final SubjectRepository repository;
  Subject subjectToEdit;
  SubjectCollection _collection;
  SubjectNotifier(this.repository) {
    _updateList();
  }

  List<Subject> get allSubjects =>
      _collection?.list == null ? null : List.unmodifiable(_collection.list);

  void addSubject(Subject subject) {
    _collection.list.add(subject);
    _collection.sort();

    notifyListeners();
  }

  void toggleTask(String uuid) {
    // _collection.toggelTask(uuid);

    notifyListeners();
  }

  List<TodayClass> get classes {
    List<TodayClass> _classes = [];
    _collection.list.forEach((Subject _subject) {
      ClassCollection classCollection = ClassCollection(list: _subject.classes);
      _classes.addAll(classCollection.classes(_subject));
    });
    return _classes.toList();
  }

  List<TodayClass> _todayClasses(List<Subject> subjects) {
    List<TodayClass> todayClasses = [];
    subjects.forEach((Subject subject) {
      ClassCollection classCollection =
          new ClassCollection(list: subject.classes);
      todayClasses.addAll(classCollection.todayClasses(subject));
    });
    return todayClasses;
  }

  List<TodayClass> get todayClasses => _collection?.list == null
      ? null
      : List.unmodifiable(_todayClasses(_collection?.list));

  void updateSubject(Subject _subject) {
    _collection.list.removeWhere((element) => element.uuid == _subject.uuid);
    _collection.list.add(_subject);
    _collection.sort();
    notifyListeners();
  }

  void edit(Subject subject) {
    subjectToEdit = subject;
    notifyListeners();
  }

  void delete(uuid) {
    _collection.list.removeWhere((element) => element.uuid == uuid);
    _collection = SubjectCollection(list: _collection.list);
    notifyListeners();
  }

  void _updateList() {
    repository.findAll().then((list) {
      _collection = SubjectCollection(list: list);
      _collection.sort();

      notifyListeners();
    });
  }
}
