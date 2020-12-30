import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/infraestructure/NavigationService.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/subject/form_subject.dart';
import 'package:flutter_redux_boilerplate/stubs/SubjectStub.dart';
import 'package:provider/provider.dart';

class UpdateSubjectScreen extends StatefulWidget {
  @override
  _UpdateSubjectScreenState createState() => _UpdateSubjectScreenState();
}

class _UpdateSubjectScreenState extends State<UpdateSubjectScreen> {
  Subject subject;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subject = context.read<SubjectNotifier>().subjectToEdit;
  }

  void save(Map<String, String> params) {
    params['uuid'] = subject.uuid;
    context
        .read<AppNotifier>()
        .updateSubject(SubjectStub.create(params: params));
    getIt<NavigationService>().navigateBack();
  }

  @override
  Widget build(BuildContext context) {
    return FormSubject(
      callback: save,
      title: subject.title,
      description: subject.description,
    );
  }
}
