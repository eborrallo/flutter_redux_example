import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/platform_adaptive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailsTaskScreen extends StatefulWidget {
  @override
  _DetailsTaskScreenState createState() => _DetailsTaskScreenState();
}

class _DetailsTaskScreenState extends State<DetailsTaskScreen> {
  @override
  Widget build(BuildContext context) {
    AppNotifier app = getIt<AppNotifier>();
    bool done = false;
    return Scaffold(
        appBar: new PlatformAdaptiveAppBar(
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        value: app.taskSelected.done ?? done,
                        activeColor: Color(0xffFFBD11),
                        onChanged: (bool value) async {
                          setState(() {
                            done = !done;
                          });
                          context
                              .read<AppNotifier>()
                              .toggleTask(app.taskSelected.uuid);
                        },
                      ))
                ],
              ),
            )
          ],
          platform: Theme.of(context).platform,
          backgroundColor: Color.fromRGBO(245, 245, 245, 1),
          leading: CloseButton(
            color: Colors.black,
          ),
        ),
        body: Container(
            color: Color.fromRGBO(245, 245, 245, 1),
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
                                app.taskSelected.subject.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ))),
                      Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            DateFormat.yMMMd()
                                    .format(app.taskSelected.deliveryDate) +
                                ' ' +
                                DateFormat.Hm()
                                    .format(app.taskSelected.deliveryDate),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ))
                    ],
                  ),
                  ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: Column(children: [
                            Text(
                              app.taskSelected.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ])),
                      subtitle: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            app.taskSelected.description ?? '',
                            style: TextStyle(fontSize: 16),
                          )))
                ]))));
  }
}
