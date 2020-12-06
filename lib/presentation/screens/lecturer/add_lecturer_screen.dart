import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/platform_adaptive.dart';

class AddLecturerScreen extends StatefulWidget {
  @override
  _AddLecturerScreenState createState() => _AddLecturerScreenState();
}

class _AddLecturerScreenState extends State<AddLecturerScreen> {
    String _title;

  @override
   Widget build(BuildContext context) {
    return Scaffold(
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
            'Add Lecturer',
            style: TextStyle(color: Colors.black),
          ),
          platform: Theme.of(context).platform,
          backgroundColor: Color.fromRGBO(245, 245, 245, 1),
          leading: BackButton(color: Colors.black),
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
                            'Name',
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
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            hintText: 'Write lecturer name',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (val) => val.isEmpty
                              ? 'Please enter the lecturer name.'
                              : null,
                          onSaved: (val) => _title = val,
                        ),
                      )),
                  ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Email',
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
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            hintText: 'Write email address',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (val) => val.isEmpty
                              ? 'Please enter the lecturer email.'
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
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            hintText: 'Write some description',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (val) => val.isEmpty
                              ? 'Please enter some description'
                              : null,
                          onSaved: (val) => _title = val,
                        ),
                      )),
                  
                ]))));
  }

}
