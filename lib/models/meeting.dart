import 'package:flutter/cupertino.dart';
import 'package:meeting_scheduler_app/models/user.dart';

class Meeting {
  String title;
  String type;
  List<User> invitedPeople;
  String date;
  String day;
  String startTime;
  String endTime;
  Color color;
  Color borderColor;

  Meeting({
    @required this.title,
    @required this.type,
    @required this.invitedPeople,
    @required this.date,
    @required this.day,
    @required this.startTime,
    @required this.endTime,
    @required this.color,
    @required this.borderColor,
  });
}
