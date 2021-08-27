import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/helpers/db_helper.dart';
import 'package:meeting_scheduler_app/models/filtered_list_model.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:meeting_scheduler_app/ui/widges/add_meeting.dart';

class MeetingProvider extends ChangeNotifier {
  MeetingProvider() {
    // filteredMeetingsList = [];
    // getAllMeetings();
    // getAllFilteredMeetings();
  }
  List<Meeting> meetings, fMeetings = [];
  List<FilteredListModel> filteredMeetingsList = [];
  List<String> dates = [];

  addMeeting(Meeting meetingInfo) async {
    int result = await DbHelper.dbHelper.insertMeeting(meetingInfo);
    getAllMeetings();
  }

  FilteredListModel getFilteredMeeting(String date) {
    try {
      this.fMeetings = this.meetings.where((e) {
        String fromDate =
            '${DateFormat.EEEE().format(e.fromDate)}, ${DateFormat.d().format(e.fromDate)}';
        String toDate =
            '${DateFormat.EEEE().format(e.toDate)}, ${DateFormat.d().format(e.toDate)}';
        if (date == fromDate || date == toDate) {
          print('Meeting: $e');
          print('date: $date');
        }
        return date == fromDate || date == toDate;
      }).toList();
    } on Exception catch (e) {
      print(e);
    }
    FilteredListModel filteredMeeting =
        FilteredListModel(date: date, meetings: fMeetings);
    return filteredMeeting;
    // notifyListeners();
  }

  getAllMeetings() async {
    this.meetings = await DbHelper.dbHelper.getAllMeetings();
    filteredMeetingsList = [];
    dates = [];
    // print(this.meetings.length);
    this.meetings.forEach((element) {
      String fromDate =
          '${DateFormat.EEEE().format(element.fromDate)}, ${DateFormat.d().format(element.fromDate)}';
      String toDate =
          '${DateFormat.EEEE().format(element.toDate)}, ${DateFormat.d().format(element.toDate)}';
      if (this.dates.contains(fromDate) == false) {
        this.dates.add(fromDate);
      }
      if (this.dates.contains(toDate) == false) {
        this.dates.add(toDate);
      }
    });
    this.dates.forEach((date) {
      this.fMeetings = this.meetings.where((e) {
        String fromDate =
            '${DateFormat.EEEE().format(e.fromDate)}, ${DateFormat.d().format(e.fromDate)}';
        String toDate =
            '${DateFormat.EEEE().format(e.toDate)}, ${DateFormat.d().format(e.toDate)}';
        if (date == fromDate || date == toDate) {
          print('Meeting: $e');
          print('date: $date');
        }
        return date == fromDate || date == toDate;
      }).toList();
      FilteredListModel filteredMeeting =
          FilteredListModel(date: date, meetings: fMeetings);
      this.filteredMeetingsList.add(filteredMeeting);
      print(this.filteredMeetingsList.length);
    });

    notifyListeners();
  }
}
