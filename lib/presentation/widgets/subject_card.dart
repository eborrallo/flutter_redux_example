import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/extensions/color_extension.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';

class SubjectCard extends StatefulWidget {
  final Subject subject;
  SubjectCard({this.subject});
  @override
  _SubjectCardState createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  @override
  Widget build(BuildContext context) {
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
                                        onPressed: () => print('caca'),
                                        icon: Icon(Icons.edit),
                                        iconSize: 18,
                                      ),
                                      IconButton(
                                        onPressed: () => print('caca'),
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
}
