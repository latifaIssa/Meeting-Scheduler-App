import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meeting_scheduler_app/models/user.dart';

class Globals {
  Globals._();
  static Globals globals = Globals._();
  User user;
  Color titleColor = Color(0xFF26265c);
  Color timeColor = Color(0xFF7d7c93);
  String time(DateTime selectedTime) {
    return DateFormat('kk:mm:a').format(selectedTime);
  }

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
}
