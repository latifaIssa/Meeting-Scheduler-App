import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/helpers/db_helper.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:meeting_scheduler_app/models/user.dart';
import 'package:sqflite/sqflite.dart';

Random random = new Random();
List<Color> colors = [
  Color(0xFFeeeefe),
  Color(0xFFfff2f2),
  Color(0xFFe5f8f8),
  Color(0xFFfcf0e4),
  Color(0xFF948bff),
  Color(0xFFff6e6d),
  Color(0xFF2bc8d7),
  Color(0xFFff9d2c),
];
Map<String, IconData> types = {
  'review': Icons.note,
  'planning': Icons.copy_outlined,
  'chatting': Icons.chat_bubble_outline,
  'calling': Icons.call,
};

// List<Meeting> appointments = <Meeting>[
//   Meeting(
//     fromDate: DateTime.now(),
//     // to: 'date'.add(const Duration(hours: 1)),
//     toDate: DateTime.now(),
//     eventTitle: 'General Meeting',
//     isAllDay: false,
//     backgroundColor: Colors.red,
//     meetingType: '',
//     borderColor: colors[4],

//     // endTimeZone: '',
//     // startTimeZone: '',
//     // type: '',
//     // fromZone: '',
//     // toZone: '',
//     // recurrenceRule: '',
//     // exceptionDates: null, endTimeZone: ''
//   ),
//   Meeting(
//     fromDate: DateTime.now(),
//     // to: 'date'.add(const Duration(hours: 1)),
//     toDate: DateTime.now(),
//     eventTitle: 'General Meeting',
//     isAllDay: false,
//     backgroundColor: Colors.red,
//     meetingType: '',
//     borderColor: colors[5],
//     // endTimeZone: '',
//     // startTimeZone: '',
//     // type: '',
//     // fromZone: '',
//     // toZone: '',
//     // recurrenceRule: '',
//     // exceptionDates: null, endTimeZone: ''
//   ),
// ];
  
   
  
// // List<Appointment> meetings = [
// //   Appointment(
// //     subject: 'Design Review',
// //     type: 'review',
// //     invitedPeople: [
// //       User(
// //         name: 'latifa',
// //         email: 'latifa@masri',
// //         picture: 'assets/images/${(random.nextInt(6) + 1)}.jfif',
// //       ),
// //       User(
// //         name: 'latifa',
// //         email: 'latifa@masri',
// //         picture: 'assets/images/${(random.nextInt(6) + 1)}.jfif',
// //       ),
// //       User(
// //         name: 'latifa',
// //         email: 'latifa@masri',
// //         picture: 'assets/images/${(random.nextInt(6) + 1)}.jfif',
// //       ),
// //       User(
// //         name: 'latifa',
// //         email: 'latifa@masri',
// //         picture: 'assets/images/${(random.nextInt(6) + 1)}.jfif',
// //       ),
// //     ],
// //     date: 'July 8',
// //     day: 'Thursday',
// //     startTime: DateTime(2021, 8, 1, 10),
// //     endTime: DateTime(2021, 8, 1, 11),
// //     color: colors[0],
// //     borderColor: colors[4],
// //   ),
// //   Appointment(
// //     subject: 'Project Palnning',
// //     type: 'planning',
// //     invitedPeople: [
// //       User(
// //         name: 'latifa',
// //         email: 'latifa@masri',
// //         picture: 'assets/images/${(random.nextInt(6) + 1)}.jfif',
// //       ),
// //       User(
// //         name: 'latifa',
// //         email: 'latifa@masri',
// //         picture: 'assets/images/${(random.nextInt(6) + 1)}.jfif',
// //       ),
// //     ],
// //     // date: DateFormat.MMMMd().format(DateTime.now()),
// //     // startTime: DateFormat.jm().format(DateTime.now()),
// //     // endTime: DateFormat.jm().format(DateTime.now()),
// //     date: 'July 9',
// //     day: 'Thursday',
// //     startTime: DateTime(2021, 8, 1, 11),
// //     endTime: DateTime(2021, 8, 1, 12),
// //     color: colors[1],
// //     borderColor: colors[5],
// //   ),
// //   Appointment(
// //     subject: 'Kickoff Meetings',
// //     type: 'chatting',
// //     invitedPeople: [
// //       User(
// //         name: 'latifa',
// //         email: 'latifa@masri',
// //         picture: 'assets/images/${(random.nextInt(6) + 1)}.jfif',
// //       ),
// //       User(
// //         name: 'latifa',
// //         email: 'latifa@masri',
// //         picture: 'assets/images/${(random.nextInt(6) + 1)}.jfif',
// //       ),
// //       User(
// //         name: 'latifa',
// //         email: 'latifa@masri',
// //         picture: 'assets/images/${(random.nextInt(6) + 1)}.jfif',
// //       ),
// //     ],
// //     date: 'July 12',
// //     day: 'Sunday',
// //     startTime: DateTime(2021, 8, 1, 1),
// //     endTime: DateTime(2021, 8, 1, 2),
// //     color: colors[2],
// //     borderColor: colors[6],
// //   ),
// //   Appointment(
// //     subject: 'Setup call',
// //     type: 'calling',
// //     invitedPeople: [
// //       User(
// //         name: 'latifa',
// //         email: 'latifa@masri',
// //         picture: 'assets/images/${(random.nextInt(6) + 1)}.jfif',
// //       ),
// //     ],
// //     date: 'July 12',
// //     day: 'Sunday',
// //     startTime: DateTime(2021, 8, 1, 3),
// //     endTime: DateTime(2021, 8, 1, 4),
// //     color: colors[3],
// //     borderColor: colors[7],
// //   ),
// // ];
