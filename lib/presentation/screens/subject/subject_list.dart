import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/extensions/color_extension.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/animated_list_item.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/platform_adaptive.dart';
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
                          subjectCard(list[i]),
                          duration: Duration(milliseconds: 400),
                        )))));
  }

  Widget subjectCard(Subject subject) {
    return Container(
        height: 200,
        margin: EdgeInsets.only(bottom: 10.0),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipPath(
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          left: BorderSide(
                              color: HexColor.fromHex(subject.color),
                              width: 5)),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(subject.title,
                                    style: TextStyle(fontSize: 18)),
                                IconButton(
                                  onPressed: () => print('caca'),
                                  icon: Icon(Icons.more_vert),
                                )
                              ]),
                          subtitle: Text(
                            subject.description,
                            style: TextStyle(fontSize: 16),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )))));
  }
}
