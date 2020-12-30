import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/platform_adaptive.dart';

class FormSubject extends StatefulWidget {
  String title;
  String description;

  final Function(Map<String, String>) callback;
  FormSubject({this.callback, this.title, this.description});
  @override
  _FormSubjectState createState() => _FormSubjectState();
}

class _FormSubjectState extends State<FormSubject> {
  @override
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    TextEditingController _title = TextEditingController(text: widget.title);
    TextEditingController _description =
        TextEditingController(text: widget.description);
    return Form(
        key: _formKey,
        onChanged: () {
          // Form.of(primaryFocus.context).save();
        },
        child: Scaffold(
            appBar: new PlatformAdaptiveAppBar(
              actions: ([
                InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        widget.callback({
                          'title': widget.title,
                          'description': widget.description,
                        });
                      }
                    },
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
                          controller: _title,
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide.none),
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            hintText: 'Write subject title',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (val) => val.isEmpty
                              ? 'Please enter your subject title.'
                              : null,
                          onSaved: (val) => widget.title = val,
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
                          controller: _description,
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide.none),
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            hintText: 'Write some description',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (val) => val.isEmpty
                              ? 'Please enter your subject title.'
                              : null,
                          onSaved: (val) => widget.description = val,
                        ),
                      )),
                ]))));
  }
}
