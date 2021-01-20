import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/expandable_text.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/platform_adaptive.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/reactive_animated_list.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/task_card.dart';
import 'package:flutter_redux_boilerplate/config/i18n.dart';

class DetailClassScreen extends StatefulWidget {
  final TodayClass todayClass;
  final ScrollController scrollController;

  DetailClassScreen(this.todayClass, {this.scrollController});
  @override
  _DetailClassScreenState createState() => _DetailClassScreenState();
}

class _DetailClassScreenState extends State<DetailClassScreen> {
  @override
  Widget build(BuildContext context) {
    //Color background = Color.fromRGBO(245, 245, 245, 1);
    Color background = Colors.white;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Scaffold(
          backgroundColor: background,
          appBar: new PlatformAdaptiveAppBar(
            actions: [],
            platform: Theme.of(context).platform,
            backgroundColor: background,
            leading: CloseButton(
              color: Colors.black,
            ),
          ),
          body: SingleChildScrollView(
              controller: widget.scrollController,
              child: Container(
                  color: background,
                  padding: EdgeInsets.only(bottom: 20),
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      widget.todayClass.location,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ))),
                            Container(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  widget.todayClass.timeIn +
                                      ' '+'to'.i18n+' ' +
                                      widget.todayClass.timeOut,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ))
                          ],
                        ),
                        ListTile(
                            title: Container(
                                margin: EdgeInsets.only(bottom: 30),
                                child: Column(children: [
                                  Text(
                                    widget.todayClass.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ])),
                            subtitle: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: ExpandableText(
                                  widget.todayClass.description ?? '',
                                  textStyle: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ))),
                        ListTile(
                          title: Container(
                              margin: EdgeInsets.only(
                                top: 30,
                              ),
                              child: Column(children: [
                                Text(
                                  'tasks'.i18n.inCaps,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ])),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 21.0),
                            padding: EdgeInsets.symmetric(horizontal: 21.0),
                            height: 500,
                            child: ReactiveAnimatedList(
                              widget.todayClass.tasks,
                              (context, element) => TaskCard(
                                element,
                                blockEdit: false,
                                callback:(){
                                  setState(() {
                                  });
                                }
                              ),
                              length: widget.todayClass.tasks.length,
                            ))
                      ]))))),
    );
  }
}
