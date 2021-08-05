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
      width: size.width > 600 ? size.width * 0.6 : size.width,
      height: size.width > 600 ? size.height * 0.9 : size.height * 0.28,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: size.width > 600 ? size.width * 0.5 : size.width,
            margin: EdgeInsets.symmetric(
              horizontal:
                  size.width > 600 ? size.width * 0.02 : size.width * 0.05,
            ),
            child: Text(
              ' ${DateFormat.EEEE().format(widget.meeting.fromDate)}, ${DateFormat.d().format(widget.meeting.toDate)}',
              style: TextStyle(
                fontSize: 20,
                color: Globals.globals.timeColor,
              ),
            ),
          ),
          Card(
            shape: Border(
              left: BorderSide(
                color: Globals.globals.colors[widget.meeting.borderColor],
                width: 5,
              ),
            ),
            margin: EdgeInsets.symmetric(
              vertical: size.height * 0.02,
              horizontal: size.width * 0.04,
            ),
            color: Globals.globals.colors[widget.meeting.backgroundColor],
            elevation: 1,
            child: ListTile(
              title: Container(
                height:
                    size.width > 600 ? size.height * 0.2 : size.height * 0.1,
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
                    // Expanded(
                    //   flex: 2,
                    //   child: Container(
                    //     child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: meeting.invitedPeople.length,
                    //       itemBuilder: (context, index) {
                    //         return CircleAvaterWidget(
                    //           meeting.invitedPeople[index].picture,
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
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
        ],
      ),
    );
  }
}
