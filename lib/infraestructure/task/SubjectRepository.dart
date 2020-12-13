import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/stubs/SubjectStub.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubjectRepository {
  @override
  Future<Subject> find(id) async {
    final list = await Future.delayed(Duration(milliseconds: 100), () {
      List _list;
      Subject subject = SubjectStub.random();
      _list.add(subject);
      return _list;
    });
    return list.isEmpty ? null : Subject.fromJson(list[0]);
  }

  @override
  Future<List<Subject>> findAll() async {
    List<Subject> _list = [];
    await Future.delayed(Duration(seconds: 1), () {
      List<void>.generate(20, (i) => _list.add(SubjectStub.random()));
      // _list.sort((Subject a, Subject b) => a.deliveryDate.compareTo(b.deliveryDate));
    });

    if (_list.isEmpty) {
      return <Subject>[];
    }

    return _list;
  }

  @override
  Future<void> save(Subject subject) async {}

  @override
  Future<void> remove(Subject subject) async {}
}
