import 'dart:ffi';
import 'package:intl/intl.dart';

import 'package:date_format/date_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meeting_scheduler_app/data/meetings-info.dart';
import 'package:meeting_scheduler_app/globals.dart';
import 'package:meeting_scheduler_app/helpers/db_helper.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:meeting_scheduler_app/models/user.dart';
import 'package:meeting_scheduler_app/ui/widges/TextFeildWidget.dart';
import 'package:meeting_scheduler_app/ui/widges/color_picker.dart';

class AddMeeting extends StatefulWidget {
  // const AddMeeting({ Key? key }) : super(key: key);

  @override
  _AddMeetingState createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeeting> {
  DatabaseHelper helper = DatabaseHelper();
  DateTime _selectedDate;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  Meeting meeting;

// TextEditingController subject = TextEditingController();
  String subject;
  bool isAllDay;
  DateTime _startDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  DateTime _endDate;
  TimeOfDay _endTime;
  String _setTime, _setDate;

  String _hour, _minute, _time;
  String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  int _value = 1;
  List<String> typeNames = types.keys.toList();

  // create some values
  Color currentColor = Colors.blue;
  Color currentBorderColor = Colors.black;
  List<Color> currentColors = [Colors.blue, Colors.green];

  void changeColor(Color color) => setState(() {
        currentColor = color;
        meeting.backgroundColor = color;
      });
  void changeBorderColor(Color color) => setState(() {
        currentBorderColor = color;
        meeting.borderColor = color;
      });
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);

// ValueChanged<Color> callback
  // void changeColor(Color color) {
  //   setState(() => pickerColor = color);
  // }

  @override
  void initState() {
    startDateController.text = DateFormat.yMd().format(DateTime.now());
    endDateController.text = DateFormat.yMd().format(DateTime.now());

    startTimeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    endTimeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 10,
        ),
        child: Form(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              ListTile(
                // contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                // leading: const Text(''),
                title: TextFormField(
                  controller: titleController,
                  // onChanged: (String value) {
                  //   subject = value;
                  //   meeting.title = titleController.text;
                  // },
                  onSaved: (String value) {
                    subject = value;
                    meeting.eventTitle = titleController.text;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    // border: InputBorder.none,
                    border: const OutlineInputBorder(),
                    hintText: 'Add title',
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: Icon(
                  Icons.access_time,
                  color: Colors.black54,
                ),
                title: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text('All-day'),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          value: isAllDay,
                          onChanged: (bool value) {
                            setState(() {
                              isAllDay = value;
                              meeting.isAllDay = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'start date',
                        ),
                        controller: startDateController,
                        onTap: () {
                          _selectDate(context, true);
                        },
                        onChanged: (value) {
                          setState(() {
                            meeting.fromDate = startDateController.text;
                          });
                        },
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 2,
                    )),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'end date',
                        ),
                        controller: endDateController,
                        onTap: () {
                          _selectDate(context, false);
                        },
                        onChanged: (value) {
                          setState(() {
                            meeting.toDate = startDateController.text;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'start time',
                        ),
                        controller: startTimeController,
                        onTap: () {
                          _selectTime(context, true);
                        },
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 2,
                    )),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'end time',
                        ),
                        controller: endTimeController,
                        onTap: () {
                          _selectTime(context, false);
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Meeting Type: '),
                  Container(
                    width: width * 0.5,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0, style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: DropdownButton(
                      value: _value,
                      selectedItemBuilder: (BuildContext context) {
                        return typeNames.map<Widget>((String item) {
                          return Text('$item');
                        }).toList();
                      },
                      items: typeNames.map((String item) {
                        return DropdownMenuItem<int>(
                          child: Text('$item'),
                          value: typeNames.indexOf(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          meeting.meetingType = value;
                        });
                      },
                      hint: Text("Select meeting type"),
                      // isExpanded: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: RaisedButton(
                      elevation: 3.0,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                titlePadding: const EdgeInsets.all(0.0),
                                contentPadding: const EdgeInsets.all(0.0),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: currentColor,
                                    onColorChanged: changeColor,
                                    colorPickerWidth: 300.0,
                                    pickerAreaHeightPercent: 0.7,
                                    enableAlpha: true,
                                    displayThumbColor: true,
                                    showLabel: true,
                                    paletteType: PaletteType.hsv,
                                    pickerAreaBorderRadius:
                                        const BorderRadius.only(
                                      topLeft: const Radius.circular(2.0),
                                      topRight: const Radius.circular(2.0),
                                    ),
                                  ),
                                ));
                          },
                        );
                      },
                      child: const Text('select color'),
                      color: currentColor,
                      textColor: useWhiteForeground(currentColor)
                          ? const Color(0xffffffff)
                          : const Color(0xff000000),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 2,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: RaisedButton(
                      elevation: 3.0,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              titlePadding: const EdgeInsets.all(0.0),
                              contentPadding: const EdgeInsets.all(0.0),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: currentBorderColor,
                                  onColorChanged: changeBorderColor,
                                  colorPickerWidth: 300.0,
                                  pickerAreaHeightPercent: 0.7,
                                  enableAlpha: true,
                                  displayThumbColor: true,
                                  showLabel: true,
                                  paletteType: PaletteType.hsv,
                                  pickerAreaBorderRadius:
                                      const BorderRadius.only(
                                    topLeft: const Radius.circular(2.0),
                                    topRight: const Radius.circular(2.0),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('select border color'),
                      color: currentColor,
                      textColor: useWhiteForeground(currentBorderColor)
                          ? const Color(0xffffffff)
                          : const Color(0xff000000),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _save();
                  });

                  // if (formKey.currentState.validate()) {
                  //   formKey.currentState.save();
                  //   FormUser formUser = FormUser.customer(
                  //     name: name,
                  //     emailAddress: emailAddress,
                  //     password: password,
                  //     phone: phone,
                  //   );

                  // String result = await Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return HomePage(formUser);
                  //     },
                  //   ),
                  // );
                  // dynamic result =
                  //     Navigator.pushNamed(context, '/home', arguments: formUser);

                  // return result;
                  // print(result);
                  // Navigator.pop(context);
                },
                child: Text('Add Meeting'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context, bool isStart) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      isStart ? startDateController : endDateController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(
          TextPosition(
              offset:
                  isStart ? startDateController : endDateController.text.length,
              affinity: TextAffinity.upstream),
        );
      // isStart ? meeting.from = _selectedDate : meeting.to = _selectedDate;
    }
  }

  _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(
        () {
          selectedTime = picked;
          _hour = selectedTime.hour.toString();
          _minute = selectedTime.minute.toString();
          _time = _hour + ' : ' + _minute;
          isStart
              ? startTimeController.text = _time
              : endTimeController.text = _time;
          isStart
              ? startTimeController.text = Globals.globals.time(selectedTime)
              : endTimeController.text = Globals.globals.time(selectedTime);
          isStart
              ? meeting.fromZone = Globals.globals.time(selectedTime)
              : meeting.toZone = Globals.globals.time(selectedTime);
        },
      );
  }

  void _save() async {
    Navigator.pop(context);

    meeting.recurrenceRule = 'qqq';
    meeting.exceptionsDates = [DateTime(2000)];
    meeting.backgroundColor = currentColor;
    meeting.borderColor = currentBorderColor;
    meeting.eventTitle = titleController.text;
    meeting.isAllDay = isAllDay;
    // meeting.invitedPeople = [
    //   User(name: 'Ahmed', email: 'ahmed@gmial.com'),
    //   User(name: 'Ahmed', email: 'ahmed@gmial.com'),
    //   User(name: 'Ahmed', email: 'ahmed@gmial.com'),
    //   User(name: 'Ahmed', email: 'ahmed@gmial.com')
    // ];
    print(meeting);
    int result;
    //  Insert Operation
    result = await helper.insertMeeting(meeting);
    if (result != 0) _showAlertDialog('Status', 'Meeting Saved Successfully');
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
