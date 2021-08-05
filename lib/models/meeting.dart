// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:meeting_scheduler_app/models/user.dart';

// class Meeting {
//   int _id;
//   DateTime _fromDate;
//   DateTime _toDate;
//   String _eventTitle;
//   bool _isAllDay;
//   Color _backgroundColor;
//   DateTime _fromZone;
//   DateTime _toZone;
//   int _recurrenceRule;
//   List<DateTime> _exceptionsDates;
//   String _meetingType;
//   List<User> _invitedPeople = [];
//   Color _borderColor;
//   String _recurrencesRule;
//   Meeting.withId(
//     this._id,
//     @required this._fromDate,
//     @required this._toDate,
//     this._eventTitle,
//     this._isAllDay,
//     @required this._backgroundColor,
//     this._fromZone,
//     this._toZone,
//     this._exceptionsDates,
//     this._recurrenceRule,
//     this._invitedPeople,
//     @required this._meetingType,
//     this._borderColor,
//     this._recurrencesRule,
//   );
//   Meeting(
//     @required this._fromDate,
//     @required this._toDate,
//     this._eventTitle,
//     this._isAllDay,
//     @required this._backgroundColor,
//     this._fromZone,
//     this._toZone,
//     this._exceptionsDates,
//     this._recurrenceRule,
//     this._invitedPeople,
//     @required this._meetingType,
//     this._borderColor,
//     this._recurrencesRule,
//   );
//   int get meetingId => _id;
//   String get eventTitle => _eventTitle;
//   DateTime get toDate => _toDate;
//   DateTime get fromDate => _fromDate;
//   DateTime get toZone => _toZone;
//   DateTime get fromZone => _fromZone;
//   bool get isAllDay => _isAllDay;
//   Color get backgroundColor => _backgroundColor;
//   int get recurrenceRule => _recurrenceRule;
//   List<DateTime> get exceptionsDates => _exceptionsDates;
//   String get meetingType => _meetingType;
//   List<User> get invitedPeople => _invitedPeople;
//   Color get borderColor => _borderColor;

//   set eventTitle(String newTitle) {
//     this._eventTitle = newTitle;
//   }

//   set toDate(DateTime newDate) {
//     this._toDate = newDate;
//   }

//   set fromDate(DateTime newDate) {
//     this._fromDate = newDate;
//   }

//   set toZone(DateTime newDate) {
//     this._toZone = newDate;
//   }

//   set fromZone(DateTime newDate) {
//     this._toZone = newDate;
//   }

//   set isAllDay(bool newIsAllDays) {
//     this._isAllDay = newIsAllDays;
//   }

//   set backgroundColor(Color color) {
//     this._backgroundColor = color;
//   }

//   set borderColor(Color color) {
//     this._borderColor = color;
//   }

//   set recurrenceRule(int newRecurrenceRule) {
//     this._recurrenceRule = newRecurrenceRule;
//   }

//   set exceptionsDates(List<DateTime> newList) {
//     this._exceptionsDates = newList;
//   }

//   set meetingType(String newType) {
//     this._meetingType = newType;
//   }

//   set invitedPeople(List<User> newList) {
//     this._invitedPeople = newList;
//   }

//   // Convert a Meeting object into a Map object
//   Map<String, dynamic> toMap() {
//     var map = Map<String, dynamic>();
//     if (_id != null) {
//       map['id'] = _id;
//     }
//     map['eventTitle'] = _eventTitle;
//     map['fromDate'] = _fromDate;
//     map['toDate'] = _toDate;
//     map['isAllDay'] = _isAllDay;
//     map['backgroundColor'] = _backgroundColor;
//     map['fromZone'] = _fromZone;
//     map['toZone'] = _toZone;
//     map['recurrencesRule'] = _recurrencesRule;
//     map['exceptionsDates'] = _exceptionsDates;
//     map['meetingType'] = _meetingType;
//     map['invitedPeople'] = _invitedPeople;
//     map['borderColor'] = _borderColor;

//     return map;
//   }

//   // Extract a Meeting object from a Map object
//   Meeting.fromMap(Map<String, dynamic> map) {
//     this._id = map['id'];
//     this._eventTitle = map['eventtitle'];
//     this._fromDate = map['fromDate'];
//     this._toDate = map['toDate'];
//     this._isAllDay = map['isAllDay'];
//     this._backgroundColor = map['backgroundcolor'];
//     this._fromZone = map['fromZone'];
//     this._toZone = map['toZone'];
//     this._recurrencesRule = map['recurrencesRule'];
//     this._exceptionsDates = map['exceptionsDates'];
//     this._meetingType = map['meetingType'];
//     this._invitedPeople = map['invitedPeople'];
//     this._borderColor = map['borderColor'];
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/models/user.dart';

class Meeting {
  Meeting({
    this.id,
    @required this.fromDate,
    @required this.toDate,
    this.eventTitle,
    this.isAllDay = false,
    @required this.backgroundColor,
    this.fromZone,
    this.toZone,
    this.exceptionsDates,
    this.recurrencesRule,
    // this.invitedPeople,
    @required this.meetingType,
    this.borderColor,
  });
  int id;
  DateTime fromDate;
  DateTime toDate;
  String eventTitle;
  bool isAllDay;
  int backgroundColor;
  String fromZone;
  String toZone;
  int recurrencesRule;
  DateTime exceptionsDates;
  String meetingType;
  // List<User> invitedPeople = [];
  int borderColor;

  int get meetingId => id;
  String get title => eventTitle;
  DateTime get getToDate => toDate;
  DateTime get getFromDate => fromDate;
  String get toTime => toZone;
  String get fromTime => fromZone;
  bool get getisAllDay => isAllDay;
  int get getbackgroundColor => backgroundColor;
  int get getRecurrenceRule => recurrencesRule;
  DateTime get getExceptionsDates => exceptionsDates;
  String get getMeetingType => meetingType;
  // List<User> get getInvitedPeople =>       invitedPeople;
  int get getBorderColor => borderColor;

  set setEventTitle(String newTitle) {
    this.eventTitle = newTitle;
  }

  set setToDate(DateTime newDate) {
    this.toDate = newDate;
  }

  set setFromDate(DateTime newDate) {
    this.fromDate = newDate;
  }

  set setToZone(String newDate) {
    this.toZone = newDate;
  }

  set setFromZone(String newDate) {
    this.toZone = newDate;
  }

  set setIsAllDay(bool newIsAllDays) {
    this.isAllDay = newIsAllDays;
  }

  set serBackgroundColor(int color) {
    this.backgroundColor = color;
  }

  set setBorderColor(int color) {
    this.borderColor = color;
  }

  set setRecurrenceRule(int newRecurrenceRule) {
    this.recurrencesRule = newRecurrenceRule;
  }

  set setExceptionsDates(DateTime newList) {
    this.exceptionsDates = newList;
  }

  set setMeetingType(String newType) {
    this.meetingType = newType;
  }

//   set invitedPeople(List<User> newList) {
//     this._invitedPeople = newList;
//   }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['eventTitle'] = eventTitle;
    map['fromDate'] = fromDate.toIso8601String();
    map['toDate'] = toDate.toIso8601String();
    map['isAllDay'] = isAllDay ? 1 : 0;
    map['backgroundColor'] = backgroundColor;
    map['fromZone'] = fromZone;
    map['toZone'] = toZone;
    map['recurrencesRule'] = recurrencesRule;
    map['exceptionsDates'] = exceptionsDates.toIso8601String();
    map['meetingType'] = meetingType;
    // map['invitedPeople'] = invitedPeople;
    map['borderColor'] = borderColor;

    return map;
  }

  // Extract a Meeting object from a Map object
  factory Meeting.fromMap(Map<String, dynamic> map) => Meeting(
        id: map['id'],
        eventTitle: map['eventTitle'],
        fromDate: DateTime.parse(map['fromDate']),
        toDate: DateTime.parse(map['toDate']),
        isAllDay: map['isAllDay'] == 0 ? false : true,
        backgroundColor: map['backgroundColor'],
        fromZone: map['fromZone'],
        toZone: map['toZone'],
        recurrencesRule: map['recurrencesRule'],
        exceptionsDates: DateTime.parse(map['exceptionsDates']),
        meetingType: map['meetingType'],
        // invitedPeople: map['invitedPeople'],
        borderColor: map['borderColor'],
      );
}
