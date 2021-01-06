import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/application/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/class/detail_class_screen.dart';
import 'package:provider/provider.dart';

class ClassCard extends StatefulWidget {
  final TodayClass todayClass;

  ClassCard(this.todayClass);

  @override
  _ClassCardState createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  void _displayBottomSheet(BuildContext context) {
    context.read<AppNotifier>().selectTodayClass(widget.todayClass);
    context.read<AppNotifier>().floatActionButtonKey.currentState.close();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return Stack(
            children: [
              GestureDetector(
                  child: Column(children: [
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                      ),
                    )
                  ]),
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
              DraggableScrollableSheet(
                  minChildSize: 0,
                  initialChildSize: 0.4,
                  maxChildSize: 0.9,
                  expand: true,
                  builder: (sheetContext, scrollController) {
                    
                    return DetailClassScreen(
                        context.read<AppNotifier>().todayClassSelected,
                        scrollController: scrollController);
                    // call this when a user taps etc.
                  })
            ],
          );
          // return DetailClassScreen(widget.todayClass);
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _displayBottomSheet(context);
        },
        child: Container(
            width: 300,
            margin: EdgeInsets.only(bottom: 10.0, left: 10),
            child: Center(
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: new ListTile(
                                  title: Text(
                                    widget.todayClass.title,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.grey,
                                          size: 18,
                                        ),
                                        Expanded(
                                            child: Text(
                                          widget.todayClass.location,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        )),
                                        Expanded(
                                            child: Text(
                                                widget.todayClass.timeIn +
                                                    ' - ' +
                                                    widget.todayClass.timeOut,
                                                textAlign: TextAlign.right))
                                      ])),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          new Icon(
                                            widget.todayClass.message != null
                                                ? Icons.error_outline
                                                : Icons.check,
                                            color: widget.todayClass.message !=
                                                    null
                                                ? Colors.orange
                                                : Colors.green,
                                            size: 18,
                                          ),
                                          Expanded(
                                              child: Text(
                                            widget.todayClass.message ??
                                                "No hay tareas pendientes",
                                            textAlign: TextAlign.right,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color:
                                                    widget.todayClass.message !=
                                                            null
                                                        ? Colors.orange
                                                        : Colors.green),
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                        ],
                                      ))),
                            ]))))));
  }
}
