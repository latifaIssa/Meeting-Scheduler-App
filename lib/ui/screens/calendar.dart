import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:meeting_scheduler_app/data/meetings-info.dart';
import 'package:meeting_scheduler_app/globals.dart';
import 'package:meeting_scheduler_app/models/data_source.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _minDate, _maxDate, _firstDate, _lastDate;
  final CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: TableCalendar(
    //     firstDay: DateTime.utc(2021, 7, 31),
    //     lastDay: DateTime.utc(2021, 8, 4),
    //     focusedDay: DateTime.now(),
    //   ),
    // );
    return Scaffold(
      // appBar: AppBar(
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.arrow_forward),
      //       onPressed: () {
      //         _calendarController.forward();
      //       },
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.day,
          showNavigationArrow: true,
          headerStyle: CalendarHeaderStyle(textAlign: TextAlign.center),
          // dayViewSettings: DayViewSettings(numberOfWeeksInView: 3),

          headerHeight: 60,
          viewHeaderStyle: ViewHeaderStyle(
            dateTextStyle: TextStyle(
              color: Globals.globals.titleColor,
              fontWeight: FontWeight.bold,
            ),
            dayTextStyle: TextStyle(
              color: Globals.globals.titleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          headerDateFormat: 'd,MMM',
          dataSource: _getCalendarDataSource(),
        ),
      ),
    );
  }
}

// _AppointmentDataSource _getCalendarDataSource() {
//   List<Appointment> appointments = <Appointment>[];

// appointments.add(
//   Appointment(
//     startTime: DateTime(2021, 8, 1, 10, 30),
//     endTime: DateTime(2021, 8, 1, 13),
//     subject: 'Occurs daily',
//     color: Colors.red,
//     recurrenceRule: 'FREQ=DAILY;COUNT=1',
//   ),
// );

// return _AppointmentDataSource(appointments);
final DateTime date = DateTime.now();
MeetingDataSource _getCalendarDataSource() {
  List<Meeting> appointments = <Meeting>[];
  appointments.add(
    Meeting(
      from: date,
      to: date.add(const Duration(hours: 1)),
      title: 'General Meeting',
      isAllDay: false,
      background: Colors.red,
      // endTimeZone: '',
      // startTimeZone: '',
      // type: '',
      // fromZone: '',
      // toZone: '',
      // recurrenceRule: '',
      // exceptionDates: null, endTimeZone: ''
    ),
  );

  return MeetingDataSource(appointments);
// }

// class _AppointmentDataSource extends CalendarDataSource {
//   _AppointmentDataSource(List<Appointment> source) {
//     appointments = source;
//   }
}
