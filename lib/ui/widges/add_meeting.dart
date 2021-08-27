import 'package:intl/intl.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/data/meetings-info.dart';
import 'package:meeting_scheduler_app/globals.dart';
import 'package:meeting_scheduler_app/helpers/db_helper.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:meeting_scheduler_app/models/user.dart';
import 'dart:math';

import 'package:meeting_scheduler_app/providers/meeting_provider.dart';
import 'package:provider/provider.dart';

class AddMeeting extends StatefulWidget {
  static final String routeName = 'addMeeting';
  @override
  _AddMeetingState createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeeting> {
  DateTime _selectedDate;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  Random random = new Random();
  Meeting meeting;

// TextEditingController subject = TextEditingController();
  String subject = 'New Meeting';
  bool isAllDay = false;
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String selectedStartTime = Globals.globals.time(DateTime.now());
  String selectedEndTime = Globals.globals.time(DateTime.now());
  String type = 'Planning';
  int _startHour = DateTime.now().hour,
      _startMinute = DateTime.now().minute,
      _startday = DateTime.now().day,
      _startyear = DateTime.now().year,
      _startMonth = DateTime.now().month;
  int _endHour = DateTime.now().hour,
      _endMinute = DateTime.now().minute,
      _endday = DateTime.now().day,
      _endyear = DateTime.now().year,
      _endMonth = DateTime.now().month;

  String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  int _value = 1;
  List<String> typeNames = types.keys.toList();

  // create some values

  List<Color> currentColors = [Colors.blue, Colors.green];

  // void changeColor(Color color) => setState(() {
  //       currentColor = color;
  //       meeting.backgroundColor = color;
  //     });
  // void changeBorderColor(Color color) => setState(() {
  //       currentBorderColor = color;
  //       meeting.borderColor = color;
  //     });
  // void changeColors(List<Color> colors) =>
  //     setState(() => currentColors = colors);

// ValueChanged<Color> callback
  // void changeColor(Color color) {
  //   setState(() => pickerColor = color);
  // }

  @override
  void initState() {
    startDateController.text = DateFormat.yMd().format(DateTime.now());
    endDateController.text = DateFormat.yMd().format(DateTime.now());

    startTimeController.text = Globals.globals.time(DateTime.now());
    endTimeController.text = Globals.globals.time(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print('1: $selectedStartDate, $selectedEndDate');
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
                title: TextFormField(
                  controller: titleController,
                  onChanged: (String value) {
                    setState(() {
                      subject = value;
                      print('event title: $subject');
                    });

                    // meeting.eventTitle = titleController.text;
                    // if (meeting.eventTitle == null)
                    //   _showAlertDialog('Status', 'Meeting Title not updated');
                  },
                  keyboardType: TextInputType.multiline,
                  // maxLines: null,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    // border: InputBorder.none,
                    border: OutlineInputBorder(),
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
                          onChanged: (value) {
                            setState(() {
                              isAllDay = value;
                              print('IsAllDays: $isAllDay');

                              //         if (meeting.isAllDay == null)
                              // _showAlertDialog('Status', 'Meeting Title not updated');
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
                            // meeting.fromDate = startDateController;
                            // if (meeting.fromDate == null)
                            //   _showAlertDialog(
                            //       'Status', 'Meeting start Date not updated');
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
                          setState(() {});
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
                      // child: TimePickerWidget(
                      //   meeting: meeting,
                      //   newTime: _meetingEndTime,
                      //   newTimeString: _meetingEndTimeString,
                      //   isStart: false,
                      // ),
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
                          type = typeNames[value];
                          print('type: $type');
                          // meeting.meetingType = value;
                          // if (meeting.meetingType == null)
                          //   _showAlertDialog(
                          //       'Status', 'Meeting type not updated');
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
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 4,
              //       child: RaisedButton(
              //         elevation: 3.0,
              //         onPressed: () {
              //           showDialog(
              //             context: context,
              //             builder: (BuildContext context) {
              //               return AlertDialog(
              //                   titlePadding: const EdgeInsets.all(0.0),
              //                   contentPadding: const EdgeInsets.all(0.0),
              //                   content: SingleChildScrollView(
              //                     child: ColorPicker(
              //                       pickerColor: currentColor,
              //                       onColorChanged: changeColor,
              //                       colorPickerWidth: 300.0,
              //                       pickerAreaHeightPercent: 0.7,
              //                       enableAlpha: true,
              //                       displayThumbColor: true,
              //                       showLabel: true,
              //                       paletteType: PaletteType.hsv,
              //                       pickerAreaBorderRadius:
              //                           const BorderRadius.only(
              //                         topLeft: const Radius.circular(2.0),
              //                         topRight: const Radius.circular(2.0),
              //                       ),
              //                     ),
              //                   ));
              //             },
              //           );
              //         },
              //         child: const Text('select color'),
              //         color: currentColor,
              //         textColor: useWhiteForeground(currentColor)
              //             ? const Color(0xffffffff)
              //             : const Color(0xff000000),
              //       ),
              //     ),
              //     Expanded(
              //       child: SizedBox(
              //         width: 2,
              //       ),
              //     ),
              //     Expanded(
              //       flex: 4,
              //       child: RaisedButton(
              //         elevation: 3.0,
              //         onPressed: () {
              //           showDialog(
              //             context: context,
              //             builder: (BuildContext context) {
              //               return AlertDialog(
              //                 titlePadding: const EdgeInsets.all(0.0),
              //                 contentPadding: const EdgeInsets.all(0.0),
              //                 content: SingleChildScrollView(
              //                   child: ColorPicker(
              //                     pickerColor: currentBorderColor,
              //                     onColorChanged: changeBorderColor,
              //                     colorPickerWidth: 300.0,
              //                     pickerAreaHeightPercent: 0.7,
              //                     enableAlpha: true,
              //                     displayThumbColor: true,
              //                     showLabel: true,
              //                     paletteType: PaletteType.hsv,
              //                     pickerAreaBorderRadius:
              //                         const BorderRadius.only(
              //                       topLeft: const Radius.circular(2.0),
              //                       topRight: const Radius.circular(2.0),
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             },
              //           );
              //         },
              //         child: const Text('select border color'),
              //         color: currentColor,
              //         textColor: useWhiteForeground(currentBorderColor)
              //             ? const Color(0xffffffff)
              //             : const Color(0xff000000),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: height * 0.1,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    save();
                  });

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
              offset: isStart
                  ? startDateController.text.length
                  : endDateController.text.length,
              affinity: TextAffinity.upstream),
        );
      if (isStart) {
        // meeting.fromDate = _selectedDate;
        _startday = _selectedDate.day;
        _startyear = _selectedDate.year;
        _startMonth = _selectedDate.month;
        print('startday: $_startday');
      } else {
        // meeting.toDate = _selectedDate;
        _endday = _selectedDate.day;
        _endyear = _selectedDate.year;
        _endMonth = _selectedDate.month;
        print('endday: $_endday');
      }
    }
  }

  _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    String _newTimeString;
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        final now = DateTime.now();
        var selectedDateTime = DateTime(now.year, now.month, now.day,
            selectedTime.hour, selectedTime.minute);

        _newTimeString = Globals.globals.time(selectedDateTime);
        isStart
            ? startTimeController.text = _newTimeString
            : endTimeController.text = _newTimeString;

        if (isStart) {
          // meeting.fromDate = selectedDateTime;
          selectedStartTime = _newTimeString;
          print('startTime: $selectedStartTime');
          _startHour = selectedDateTime.hour;
          _startMinute = selectedDateTime.minute;
          print("$_startHour : $_startMinute");
        } else {
          // meeting.toDate = selectedDateTime;
          selectedEndTime = _newTimeString;
          print('endTime: $selectedEndTime');
          _endHour = selectedDateTime.hour;
          _endMinute = selectedDateTime.minute;
          print("$_endHour : $_endMinute");
        }
        print('START= $_startHour:$_startMinute, eND= $_endHour:$_endMinute');
      });
    }
  }

  void save() async {
    Navigator.pop(context);

    int colorIndex = random.nextInt(4);
    selectedStartDate = DateTime(
      _startyear,
      _startMonth,
      _startday,
      _startHour,
      _startMinute,
    );
    selectedEndDate = DateTime(
      _endyear,
      _endMonth,
      _endday,
      _endHour,
      _endMinute,
    );
    print('2: $selectedStartDate, $selectedEndDate');

    Meeting meetingInfo = Meeting(
      eventTitle: subject,
      fromDate: selectedStartDate,
      toDate: selectedEndDate,
      isAllDay: isAllDay,
      fromZone: selectedStartTime,
      toZone: selectedEndTime,
      backgroundColor: colorIndex,
      meetingType: type,
      recurrencesRule: 1,
      exceptionsDates: DateTime(2000),
      borderColor: colorIndex + 4,
    );
    print(' title ${meetingInfo.eventTitle} from $subject');
    print(' title ${meetingInfo.fromDate} from $selectedStartDate');
    print(' title ${meetingInfo.toDate} from $selectedEndDate');
    print(' isAllDay ${meetingInfo.isAllDay} from $isAllDay');
    Provider.of<MeetingProvider>(context, listen: false)
        .addMeeting(meetingInfo);
    // if (result != 0) _showAlertDialog('Status', 'Meeting Saved Successfully');
    // Provider.of<MeetingProvider>(context, listen: false).getAllMeetings();
  }

  // void _showAlertDialog(String title, String message) {
  //   AlertDialog alertDialog = AlertDialog(
  //     title: Text(title),
  //     content: Text(message),
  //   );
  //   showDialog(context: context, builder: (_) => alertDialog);
  // }
}
