import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/class/class.dart';
import 'package:flutter_redux_boilerplate/domain/extensions/date_time_extension.dart';
import 'package:flutter_redux_boilerplate/domain/extensions/time_of_day_extension.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/platform_adaptive.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/week_day_selector/week_day_selector.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';

class FormSubject extends StatefulWidget {
  Subject subject;
  final Function(Map<String, dynamic>) callback;
  FormSubject({this.callback, this.subject});
  @override
  _FormSubjectState createState() => _FormSubjectState();
}

class _FormSubjectState extends State<FormSubject> {
  @override
  final _formKey = GlobalKey<FormState>();
  final values = <bool>[false, false, false, false, false, false, false];
  String title;
  String description;
  Map<int, String> _setTimeTo = {}, _timeValidatorTo = {};
  Map<int, String> _setTimeFrom = {}, _timeValidatorFrom = {};

  Map<int, TimeOfDay> selectedTimeTo = {}; //TimeOfDay(hour: 00, minute: 00);
  Map<int, TimeOfDay> selectedTimeFrom = {}; //TimeOfDay(hour: 00, minute: 00);
  Map<int, TextEditingController> _timeControllerFrom =
      List.generate(7, (index) => TextEditingController()).asMap();
  Map<int, TextEditingController> _timeControllerTo =
      List.generate(7, (index) => TextEditingController()).asMap();

  void initState() {
    widget.subject?.classes?.forEach((Class element) {
      values[element.dayOfWeek] = true;

      selectedTimeFrom[element.dayOfWeek] = TimeOfDay(
          hour: element.startTime.hour, minute: element.startTime.minute);
      _timeControllerFrom[element.dayOfWeek].text =
          formatHour(selectedTimeFrom[element.dayOfWeek]);

      selectedTimeTo[element.dayOfWeek] =
          TimeOfDay(hour: element.endTime.hour, minute: element.endTime.minute);
      _timeControllerTo[element.dayOfWeek].text =
          formatHour(selectedTimeTo[element.dayOfWeek]);
    });
    super.initState();
  }

  String formatHour(TimeOfDay time) {
    return time.hour.toString() + ':' + time.minute.toString();
  }

  Widget build(BuildContext context) {
    TextEditingController _title =
        TextEditingController(text: widget.subject?.title);
    TextEditingController _description =
        TextEditingController(text: widget.subject?.description);
    final locale = Localizations.localeOf(context);

    final DateSymbols dateSymbols = dateTimeSymbolMap()['$locale'];

    return Form(
        key: _formKey,
        onChanged: () {
          // Form.of(primaryFocus.context).save();
        },
        child: Scaffold(
            backgroundColor: Color.fromRGBO(245, 245, 245, 1),
            appBar: new PlatformAdaptiveAppBar(
              actions: ([
                InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        List<dynamic> listClass = [];
                        values.asMap().entries.forEach((entry) {
                          if (entry.value) {
                            Duration duration = selectedTimeFrom[entry.key]
                                .difference(selectedTimeTo[entry.key]);
                            listClass.add(Class(
                                    //duration: duration,
                                    dayOfWeek: entry.key,
                                    startTime: selectedTimeFrom[entry.key]
                                        .toDateTime(),
                                    endTime:
                                        selectedTimeTo[entry.key].toDateTime())
                                .toJson());
                          }
                        });
                        widget.callback({
                          'title': title,
                          'description': description,
                          'classes': listClass
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
            body: SingleChildScrollView(
                child: Container(
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
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                hintText: 'Write subject title',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Please enter your subject title.'
                                  : null,
                              onSaved: (val) => title = val,
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
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                hintText: 'Write some description',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Please enter your subject title.'
                                  : null,
                              onSaved: (val) => description = val,
                            ),
                          )),
                      WeekdaySelector(
                        shortWeekdays: dateSymbols.SHORTWEEKDAYS,
                        onChanged: (int day) {
                          setState(() {
                            values[day % 7] = !values[day % 7];
                          });
                        },
                        values: values,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: []..addAll(
                              values.asMap().entries.map((entry) => entry.value
                                  ? Column(
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(left: 20),
                                            child: Text(
                                              DateWeekExtensions.dayOfWeek(
                                                  entry.key),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(
                                                left: 20, bottom: 20),
                                            child: Row(children: [
                                              dateTimePickerFrom(entry.key),
                                              dateTimePickerTo(entry.key)
                                            ])),
                                      ],
                                    )
                                  : Container())),
                        ),
                      )
                    ])))));
  }

  Widget dateTimePickerFrom(int index) {
    Function validator = (val) {
      if (val.isEmpty) {
        Future.delayed(Duration.zero, () async {
          setState(() {
            _timeValidatorFrom[index] = 'Please enter your time.';
          });
        });
      }
      return null;
    };
    Function onSave = (String val) {
      _setTimeFrom[index] = val;
    };

    return dateTimePicker(index, _timeControllerFrom[index], validator,
        _selectTimeFrom, onSave, 'From', _timeValidatorTo[index]);
  }

  Widget dateTimePickerTo(int index) {
    Function validator = (val) {
      if (val.isEmpty) {
        Future.delayed(Duration.zero, () async {
          setState(() {
            _timeValidatorTo[index] = 'Please enter your time.';
          });
        });
      }
      return null;
    };
    Function onSave = (String val) {
      _setTimeTo[index] = val;
    };
    return dateTimePicker(index, _timeControllerTo[index], validator,
        _selectTimeTo, onSave, 'To', _timeValidatorTo[index]);
  }

  Future<Null> _selectTimeFrom(BuildContext context, int index) async {
    var selectedTime =
        selectedTimeFrom[index] ?? TimeOfDay(hour: 00, minute: 00);

    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTimeFrom[index] = picked;
        _timeControllerFrom[index].text = formatHour(selectedTimeFrom[index]);
      });
  }

  Future<Null> _selectTimeTo(BuildContext context, int index) async {
    var selectedTime = selectedTimeTo[index] ?? TimeOfDay(hour: 00, minute: 00);
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTimeTo[index] = picked;

        _timeControllerTo[index].text = formatHour(selectedTimeTo[index]);
      });
  }

  Widget dateTimePicker(
    int index,
    TextEditingController controller,
    Function validator,
    Function onTab,
    Function onSave, [
    String placeholder,
    String errorMessage,
  ]) {
    return InkWell(
      onTap: () {
        onTab(context, index);
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 20),
          width: 150,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextFormField(
            textAlign: TextAlign.left,
            onSaved: onSave,
            enabled: false,
            keyboardType: TextInputType.text,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              hintText: placeholder ?? 'Set time',
              prefixIcon: Icon(
                Icons.access_time,
                color: Colors.grey,
              ),
              disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(errorMessage ?? '',
                style: TextStyle(color: Colors.red[600], fontSize: 12)),
          ),
        )
      ]),
    );
  }
}
