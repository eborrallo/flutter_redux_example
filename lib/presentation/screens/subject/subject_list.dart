import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/animated_list_item.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/platform_adaptive.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/subject_card.dart';
import 'package:provider/provider.dart';

class SubjectListScreen extends StatefulWidget {
  @override
  _SubjectListScreenState createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  @override
  Widget build(BuildContext context) {
    var list = context.watch<SubjectNotifier>().allSubjects;

    return Scaffold(
        appBar: new PlatformAdaptiveAppBar(
          actions: [],
          title: Text(
            'Subjects',
            style: TextStyle(color: Colors.black),
          ),
          platform: Theme.of(context).platform,
          backgroundColor: Color.fromRGBO(245, 245, 245, 1),
          leading: CloseButton(color: Colors.black),
        ),
        body: Container(
            color: Color.fromRGBO(245, 245, 245, 1),
            padding: EdgeInsets.only(left: 21.0, top: 21, right: 21),
            child: ListView(
                children: List.generate(
                    list.length ?? 0,
                    (i) => AnimatedListItem(
                          i,
                          SubjectCard(subject: list[i]),
                          duration: Duration(milliseconds: 400),
                        )))));
  }
}
