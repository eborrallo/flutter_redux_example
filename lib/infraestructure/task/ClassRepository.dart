import 'package:flutter_redux_boilerplate/domain/class/class.dart';
import 'package:flutter_redux_boilerplate/stubs/ClassStub.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ClassRepository {
  @override
  Future<Class> find(id) async {
    final list = await Future.delayed(Duration(milliseconds: 100), () {
      List _list;
      Class clas = ClassStub.random();
      _list.add(clas);
      return _list;
    });
    return list.isEmpty ? null : Class.fromJson(list[0]);
  }

  @override
  Future<List<Class>> findAll() async {
    List<Class> _list = [];
    await Future.delayed(Duration(milliseconds: 1300), () {
      List<void>.generate(7, (i) => _list.add(ClassStub.random()));
       _list.sort((Class a, Class b) => a.startTime.compareTo(b.startTime));
    });

    if (_list.isEmpty) {
      return <Class>[];
    }

    return _list;
  }

  @override
  Future<void> save(Class cls) async {}

  @override
  Future<void> remove(Class cls) async {}
}
