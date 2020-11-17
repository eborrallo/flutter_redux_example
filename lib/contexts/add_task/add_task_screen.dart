import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/containers/platform_adaptive.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskStateScreen createState() => _AddTaskStateScreen();
}

class _AddTaskStateScreen extends State<AddTaskScreen> {
  String _title, _setTime, _setDate, _subject;
  File _file;
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _fileController = TextEditingController();
  String _hour, _minute, _time;

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _timeController = TextEditingController();
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
            'Add Task',
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
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            hintText: 'Write subject title',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            hintText: 'Write some description',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (val) => val.isEmpty
                              ? 'Please enter your subject title.'
                              : null,
                          onSaved: (val) => _title = val,
                        ),
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        'Date & Time',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20, bottom: 20),
                      child: Row(children: [datePicker(), dateTimePicker()])),
                  ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Subject',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      subtitle: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: DropdownButtonFormField(
                            items: [
                              DropdownMenuItem(
                                child: new Text('Male'),
                                value: 0,
                              ),
                              DropdownMenuItem(
                                child: new Text('asasd'),
                                value: 1,
                              )
                            ],
                            value: _subject,
                            onChanged: (value) {
                              setState(() {
                                _subject = value;
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide.none),
                            )),
                      )),
                  ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Attachment',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      subtitle: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: new TextFormField(
                          onTap: () {
                            try {
                              _selectFile();
                            } catch (e) {}
                          },
                          readOnly: true,
                          enableInteractiveSelection: true,
                          controller: _fileController,
                          decoration: new InputDecoration(
                            suffixIcon: Icon(
                              Icons.file_upload,
                              color: Colors.blue,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide.none),
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (val) => val.isEmpty
                              ? 'Please enter your subject title.'
                              : null,
                          onSaved: (val) => _title = val,
                        ),
                      )),
                ]))));
  }

  void _selectFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _fileController.text = result.files.single.name;
      _file = File(result.files.single.path);
    }
  }

  Widget datePicker() {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        width: 180,
        height: 50,
        margin: EdgeInsets.only(
          top: 10,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: TextFormField(
            textAlign: TextAlign.left,
            enabled: false,
            keyboardType: TextInputType.text,
            controller: _dateController,
            onSaved: (String val) {
              _setDate = val;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.calendar_today,
                color: Colors.grey,
              ),
              hintText: 'Pick date',
              disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            )),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
      });
  }

  Widget dateTimePicker() {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 20),
        width: 150,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: TextFormField(
          textAlign: TextAlign.left,
          onSaved: (String val) {
            _setTime = val;
          },
          enabled: false,
          keyboardType: TextInputType.text,
          controller: _timeController,
          decoration: InputDecoration(
            hintText: 'Set time',
            prefixIcon: Icon(
              Icons.access_time,
              color: Colors.grey,
            ),
            disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
