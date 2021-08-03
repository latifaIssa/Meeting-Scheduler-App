// import 'package:flutter/cupertino.dart';
// import 'package:meeting_scheduler_app/models/user.dart';

// class Meeting {
//   String subject;
//   String type;
//   List<User> invitedPeople;
//   String date;
//   String day;
//   DateTime startTime;
//   DateTime endTime;
//   Color color;
//   Color borderColor;
//   String recurrenceRule = 'FREQ=DAILY;COUNT=1';

//   Meeting({
//     @required this.subject,
//     @required this.type,
//     @required this.invitedPeople,
//     this.date,
//     @required this.day,
//     @required this.startTime,
//     @required this.endTime,
//     @required this.color,
//     @required this.borderColor,
//     this.recurrenceRule,
//   });
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/models/user.dart';

// class Meeting {
//   Meeting({
//     @required this.from,
//     @required this.to,
//     @required this.background = Colors.green,
//     @required this.isAllDay = false,
//     @required this.eventName = '',
//     @required this.startTimeZone = '',
//     @required this.endTimeZone = '',
//     this.description = '',
//     this.invitedPeople,
//     @required this.type,
//     this.borderColor,
//   });

//   String eventName;
//   DateTime from;
//   DateTime to;
//   Color background;
//   Color borderColor;
//   bool isAllDay;
//   String startTimeZone;
//   String endTimeZone;
//   String description;
//   String type;
//   List<User> invitedPeople;
// }

class Meeting {
  Meeting({
    this.id,
    @required this.from,
    @required this.to,
    this.title = '',
    this.isAllDay = false,
    @required this.background,
    this.fromZone = '',
    this.toZone = '',
    this.exceptionDates,
    this.recurrenceRule = '',
    // this.invitedPeople,
    @required this.type,
    this.borderColor,
  });
  int id;
  String from;
  String to;
  String title;
  bool isAllDay;
  Color background;
  String fromZone;
  String toZone;
  String recurrenceRule;
  List<DateTime> exceptionDates;
  String type;
  // List<User> invitedPeople = [];
  Color borderColor;

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['from'] = from;
    map['to'] = to;
    map['isAllDay'] = isAllDay;
    // map['isAllDay'] = isAllDay;
    map['background'] = background;
    map['fromZone'] = fromZone;
    map['toZone'] = toZone;
    map['exceptionDates'] = exceptionDates;
    map['type'] = type;
    // map['invitedPeople'] = invitedPeople;
    map['borderColor'] = borderColor;

    return map;
  }

  // Extract a Meeting object from a Map object
  Meeting.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.from = map['from'];
    this.to = map['to'];
    this.isAllDay = map['isAllDay'];
    this.background = map['background'];
    this.fromZone = map['fromZone'];
    this.toZone = map['toZone'];
    this.exceptionDates = map['exceptionDates'];
    this.type = map['type'];
    // this.invitedPeople = map['invitedPeople'];
    this.borderColor = map['borderColor'];
  }
}
