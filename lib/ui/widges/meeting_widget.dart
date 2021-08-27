import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/data/meetings-info.dart';
import 'package:meeting_scheduler_app/globals.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:meeting_scheduler_app/ui/widges/circle_avater_widget.dart';

class MeetingWidget extends StatefulWidget {
  Meeting meeting;
  MeetingWidget(this.meeting);

  @override
  _MeetingWidgetState createState() => _MeetingWidgetState();
}

class _MeetingWidgetState extends State<MeetingWidget> {
  @override
  Widget build(BuildContext context) {
    var startTime = widget.meeting.fromZone;
    var endTime = widget.meeting.toZone;
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width > 600 ? size.width * 0.6 : size.width * 0.8,
      height: size.width > 600 ? size.height * 0.9 : size.height * 0.20,
      child: Card(
        shape: Border(
          left: BorderSide(
            color: Globals.globals.colors[widget.meeting.borderColor],
            width: 5,
          ),
        ),
        margin: EdgeInsets.symmetric(
          vertical: size.height * 0.01,
          horizontal: size.width * 0.04,
        ),
        color: Globals.globals.colors[widget.meeting.backgroundColor],
        elevation: 1,
        child: ListTile(
          title: Container(
            height: size.width > 600 ? size.height * 0.2 : size.height * 0.1,
            margin: EdgeInsets.symmetric(
              vertical: size.height * 0.03,
              horizontal: size.width * 0.02,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: size.height * 0.018),
                  child: Text(
                    widget.meeting.eventTitle,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Globals.globals.titleColor,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: size.width > 600
                          ? size.width * 0.01
                          : size.height * 0.01),
                  child: Text(
                    ' $startTime - $endTime',
                    style: TextStyle(
                      fontSize: 15,
                      color: Globals.globals.timeColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          trailing: Container(
            width: size.width * 0.1,
            height: size.height * 0.05,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              types[widget.meeting.meetingType],
              color: Globals.globals.colors[widget.meeting.borderColor],
              size: size.width * 0.06,
            ),
          ),
        ),
      ),
    );
  }
}
