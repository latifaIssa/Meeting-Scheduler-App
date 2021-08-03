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
//     @required this.backgroundcolor = Colors.green,
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
    @required this.fromDate,
    @required this.toDate,
    this.eventTitle = '',
    this.isAllDay = false,
    @required this.backgroundColor,
    this.fromZone = '',
    this.toZone = '',
    this.exceptionsDates,
    this.recurrenceRule = '',
    this.invitedPeople,
    @required this.meetingType,
    this.borderColor,
    this.recurrencesRule,
  });
  int id;
  String fromDate;
  String toDate;
  String eventTitle;
  bool isAllDay;
  Color backgroundColor;
  String fromZone;
  String toZone;
  String recurrenceRule;
  List<DateTime> exceptionsDates;
  String meetingType;
  List<User> invitedPeople = [];
  Color borderColor;
  String recurrencesRule;

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['eventTitle'] = eventTitle;
    map['fromDate'] = fromDate;
    map['toDate'] = toDate;
    map['isAllDay'] = isAllDay;
    map['backgroundColor'] = backgroundColor;
    map['fromZone'] = fromZone;
    map['toZone'] = toZone;
    map['recurrencesRule'] = recurrencesRule;
    map['exceptionsDates'] = exceptionsDates;
    map['meetingType'] = meetingType;
    map['invitedPeople'] = invitedPeople;
    map['borderColor'] = borderColor;

    return map;
  }

  // Extract a Meeting object from a Map object
  factory Meeting.fromMap(Map<String, dynamic> map) => Meeting(
        id: map['id'],
        eventTitle: map['eventtitle'],
        fromDate: map['fromDate'],
        toDate: map['toDate'],
        isAllDay: map['isAllDay'],
        backgroundColor: map['backgroundcolor'],
        fromZone: map['fromZone'],
        toZone: map['toZone'],
        recurrencesRule: map['recurrencesRule'],
        exceptionsDates: map['exceptionsDates'],
        meetingType: map['meetingType'],
        invitedPeople: map['invitedPeople'],
        borderColor: map['borderColor'],
      );
}
