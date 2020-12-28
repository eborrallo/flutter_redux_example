import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/infraestructure/NavigationService.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/platform_adaptive.dart';
import 'package:flutter_redux_boilerplate/stubs/SubjectStub.dart';
import 'package:provider/provider.dart';

class AddSubjectScreen extends StatefulWidget {
  @override
  _AddSubjectScreenState createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  String _title;
  final _formKey = GlobalKey<FormState>();

  void save() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      var params = {
        'title': _title,
      };
      context
          .read<SubjectNotifier>()
          .addSubject(SubjectStub.create(params: params));
      getIt<NavigationService>().navigateBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        onChanged: () {
          // Form.of(primaryFocus.context).save();
        },
        child: Scaffold(
            appBar: new PlatformAdaptiveAppBar(
              actions: ([
                InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              color: Colors.blue,
                              icon: Icon(Icons.save),
                              onPressed: () {}),
                          Text(
                            'SAVE',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )
                        ],
                      ),
                    ))
              ]),
              title: Text(
                'Add Subject',
                style: TextStyle(color: Colors.black),
              ),
              platform: Theme.of(context).platform,
              backgroundColor: Color.fromRGBO(245, 245, 245, 1),
              leading: CloseButton(color: Colors.black),
            ),
            body: Container(
                color: Color.fromRGBO(245, 245, 245, 1),
                padding: EdgeInsets.all(20),
                child: Form(
                    //autovalidate: true,
                    onChanged: () {
                      // Form.of(primaryFocus.context).save();
                    },
                    child: Column(children: [
                      ListTile(
                          title: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Title',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          subtitle: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: new TextFormField(
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide.none),
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                hintText: 'Write subject title',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Please enter your subject title.'
                                  : null,
                              onSaved: (val) => _title = val,
                            ),
                          )),
                      ListTile(
                          title: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Description',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          subtitle: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: new TextFormField(
                              maxLines: 4,
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide.none),
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                hintText: 'Write some description',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Please enter your subject title.'
                                  : null,
                              onSaved: (val) => _title = val,
                            ),
                          )),
                    ])))));
  }
}
