import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/config/screens.dart';
import 'package:flutter_redux_boilerplate/domain/extensions/color_extension.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/infraestructure/NavigationService.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SubjectCard extends StatefulWidget {
  final Subject subject;
  SubjectCard({this.subject});
  @override
  _SubjectCardState createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  @override
  Widget build(BuildContext context) {
    NavigationService navigatior = getIt<NavigationService>();

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
                              color: HexColor.fromHex(widget.subject.color),
                              width: 5)),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.subject.title,
                                    style: TextStyle(fontSize: 18)),
                                Container(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<SubjectNotifier>()
                                              .edit(widget.subject);
                                          navigatior.navigateToNext(
                                              UPDATE_SUBJECT_SCREEN,
                                              pageTransition: PageTransitionType
                                                  .bottomToTop);
                                        },
                                        icon: Icon(Icons.edit),
                                        iconSize: 18,
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            showAlertDialog(context),
                                        icon: Icon(Icons.delete),
                                        color: Colors.red[800],
                                        iconSize: 18,
                                      )
                                    ],
                                  ),
                                )
                              ]),
                          subtitle: Text(
                            widget.subject.description,
                            style: TextStyle(fontSize: 16),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )))));
  }

  showAlertDialog(BuildContext context) {
    void delete() {
      context.read<AppNotifier>().deleteSubject(widget.subject.uuid);
      Navigator.of(context).pop();
    }

    // set up the buttons
    Widget subjectAndSubtasct = FlatButton(
      child: Text("Subject and subtasks", style: TextStyle(color: Colors.blue)),
      onPressed: () {
        delete();
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete confirmation"),
      content:
          Text("You will delete  this subject , some task may be affected."),
      actions: [
        cancelButton,
        subjectAndSubtasct,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
