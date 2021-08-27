import 'package:flutter/cupertino.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';

class FilteredListModel {
  String date;
  List<Meeting> meetings;
  FilteredListModel({
    @required this.date,
    @required this.meetings,
  });

  factory FilteredListModel.map(Map map) {
    return FilteredListModel(
      date: map['date'],
      meetings: map['meetings'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['date'] = date;
    map['meetings'] = meetings;
    return map;
  }
}
