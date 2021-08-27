import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:meeting_scheduler_app/data/meetings-info.dart';
import 'package:meeting_scheduler_app/globals.dart';
import 'package:meeting_scheduler_app/helpers/db_helper.dart';
import 'package:meeting_scheduler_app/models/data_source.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:meeting_scheduler_app/providers/meeting_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  List<Meeting> meetings;
  CalendarScreen({this.meetings});
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MeetingProvider>(context, listen: false).getAllMeetings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.day,
          showNavigationArrow: true,
          headerStyle: CalendarHeaderStyle(textAlign: TextAlign.center),
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
          dataSource: _getCalendarDataSource(
              Provider.of<MeetingProvider>(context, listen: false).meetings),
        ),
      ),
    );
  }
}

final DateTime date = DateTime.now();
_AppointmentDataSource _getCalendarDataSource(List<Meeting> meetings) {
  List<Appointment> appointments = <Appointment>[];

  if (meetings != null)
    for (var item in meetings) {
      if (item != null) {
        print(item);
        Appointment appointment = convertToAppointment(item);
        appointments.add(appointment);
      }
    }
  appointments.add(
    Appointment(
      startTime: DateTime(2021, 8, 5, 12, 00),
      endTime: DateTime(2021, 8, 5, 1, 00),
      subject: 'Lunch Break',
      color: Colors.blueGrey,
      recurrenceRule: 'FREQ=DAILY',
    ),
  );

  return _AppointmentDataSource(appointments);
}

Appointment convertToAppointment(Meeting e) {
  return Appointment(
    startTime: e.fromDate,
    endTime: e.toDate,
    subject: e.eventTitle,
    color: Globals.globals.colors[e.borderColor],
    recurrenceRule: 'FREQ=DAILY;COUNT=${e.recurrencesRule}',
  );
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
