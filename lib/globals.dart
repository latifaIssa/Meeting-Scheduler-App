import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/models/user.dart';

class Globals {
  Globals._();
  static Globals globals = Globals._();
  User user;
  Color titleColor = Color(0xFF26265c);
  Color timeColor = Color(0xFF7d7c93);
  String time(TimeOfDay selectedTime) {
    return formatDate(
        DateTime(
          2019,
          08,
          1,
          selectedTime.hour,
          selectedTime.minute,
        ),
        [hh, ':', nn, " ", am]).toString();
  }
}
