import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/data/meetings-info.dart';
import 'package:meeting_scheduler_app/globals.dart';
import 'package:meeting_scheduler_app/helpers/db_helper.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:meeting_scheduler_app/ui/widges/circle_avater_widget.dart';
import 'package:meeting_scheduler_app/ui/widges/meeting_widget.dart';
import 'package:sqflite/sqflite.dart';

class MeetingsScreen extends StatefulWidget {
  @override
  _MeetingsScreenState createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Meeting> meetings;

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Meeting>> MeetingListFuture = databaseHelper.getMeetingList();
      MeetingListFuture.then((meetings) {
        setState(() {
          this.meetings = meetings;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (meetings == null) {
      meetings = List<Meeting>();
      updateListView();
    }
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  margin: EdgeInsets.only(
                    left: size.width * 0.05,
                    top: size.height * 0.03,
                    bottom: size.height * 0.05,
                  ),
                  child: Text(
                    'Meetings',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(
                    left: size.width * 0.05,
                    bottom: size.height * 0.05,
                  ),
                  child: CircleAvaterWidget(
                    Globals.globals.user.picture,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: size.width > 600 ? 1 : 5,
          child: Container(
            child: ListView.builder(
              scrollDirection:
                  size.width > 600 ? Axis.horizontal : Axis.vertical,
              itemCount: meetings.length,
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                return MeetingWidget(meetings[index]);
                // return Container(
                //   child: Text(meetings[index].title),
                // );
              },
            ),
          ),
        ),
      ],
    );
  }
}
