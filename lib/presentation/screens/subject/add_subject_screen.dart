import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/infraestructure/NavigationService.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/subject/form_subject.dart';
import 'package:flutter_redux_boilerplate/stubs/SubjectStub.dart';
import 'package:provider/provider.dart';

class AddSubjectScreen extends StatefulWidget {
  String title;
  String description;
  @override
  _AddSubjectScreenState createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  void save(params) {
  
    context
        .read<SubjectNotifier>()
        .addSubject(SubjectStub.create(params: params));
    getIt<NavigationService>().navigateBack();
  }

  @override
  Widget build(BuildContext context) {
    return FormSubject(
      callback: save,
    );
  }
}
