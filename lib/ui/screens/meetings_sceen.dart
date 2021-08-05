import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/globals.dart';
import 'package:meeting_scheduler_app/helpers/db_helper.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:meeting_scheduler_app/ui/widges/circle_avater_widget.dart';
import 'package:meeting_scheduler_app/ui/widges/meeting_widget.dart';
import 'package:sqflite/sqflite.dart';

class MeetingsScreen extends StatefulWidget {
  List<Meeting> meetings;
  MeetingsScreen({this.meetings});
  @override
  _MeetingsScreenState createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  Future<List<Meeting>> newMeetings;
  List<Meeting> meetings;
  List<Meeting> currentMeetings;

  @override
  void initState() {
    print('table: ${databaseHelper.getTablesNames()}');
    updateListView();
    super.initState();
  }

  // void loadMeetings() {
  //   newMeetings = databaseHelper.getMeetingList();
  //   if (mounted) setState(() {});
  // }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Meeting>> meetingListFuture = databaseHelper.getAllMeetings();
      Future<List<Meeting>> newMeetings = databaseHelper.getAllMeetings();
      meetingListFuture.then((meetingsList) {
        setState(() {
          this.meetings = meetingsList;
          // print(this.meetings.length)
          print(' count from update: ${meetingsList.length}');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(' type: ${meetings.first.meetingType}');
    updateListView();
    if (meetings == null) {
      meetings = List<Meeting>();
      updateListView();
      print(' length: ${meetings.length}');
    } else {
      print(' count: ${meetings.length} ');
    }

    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 10, vertical: width > 600 ? 5 : 30),
      child: Column(
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
                    margin: width > 600
                        ? EdgeInsets.all(0)
                        : EdgeInsets.only(
                            left: width * 0.05,
                            top: height * 0.03,
                            // bottom: height * 0.05,
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
                    margin: width > 600
                        ? EdgeInsets.all(0)
                        : EdgeInsets.only(
                            left: width * 0.05,
                            // bottom: height * 0.05,
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
            flex: width > 600 ? 1 : 5,
            // child: FutureBuilder<List<Meeting>>(
            //   future: newMeetings,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       currentMeetings = snapshot.data;

            //       return ListView(
            //         children: currentMeetings.map<Widget>((meeting) {
            //           // return Container(
            //           //   margin: const EdgeInsets.only(bottom: 32),
            //           //   padding: const EdgeInsets.symmetric(
            //           //       horizontal: 16, vertical: 8),
            //           //   decoration: BoxDecoration(
            //           //     color: meeting.backgroundColor,
            //           //     boxShadow: [
            //           //       BoxShadow(
            //           //         color: meeting.backgroundColor.withOpacity(0.4),
            //           //         blurRadius: 8,
            //           //         spreadRadius: 2,
            //           //         offset: Offset(4, 4),
            //           //       ),
            //           //     ],
            //           //     borderRadius: BorderRadius.all(Radius.circular(24)),
            //           //   ),
            //           //   child: MeetingWidget(meeting),
            //           // );
            //           return Column(children: [
            //             Text(meeting.eventTitle),
            //             MeetingWidget(meeting)
            //           ]);
            //         }).toList(),
            //       );
            //     }
            //     return Center(
            //       child: Text(
            //         'Loading..',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     );
            //   },
            // ),
            // flex: size.width > 600 ? 1 : 5,
            child: Container(
              child: ListView.builder(
                scrollDirection:
                    size.width > 600 ? Axis.horizontal : Axis.vertical,
                itemCount: meetings.length,
                // shrinkWrap: true,
                itemBuilder: (context, index) {
                  return meetings[index] == null
                      ? Text('theres no meetings exist')
                      : MeetingWidget(meetings[index]);
                  // return Container(
                  //   child: Text(meetings[index].eventTitle),
                  // );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
