import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/data/meetings-info.dart';
import 'package:meeting_scheduler_app/globals.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:meeting_scheduler_app/ui/widges/circle_avater_widget.dart';

class MeetingWidget extends StatelessWidget {
  Meeting meeting;
  MeetingWidget(this.meeting);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width > 600 ? size.width * 0.6 : size.width,
      height: size.width > 600 ? size.height : size.height * 0.38,
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
              // ' ${DateFormat.E().format(meeting.from)}, ${DateFormat.d().format(meeting.from)}',
              '',
              style: TextStyle(
                fontSize: 20,
                color: Globals.globals.timeColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Card(
              shape: Border(
                left: BorderSide(
                  color: meeting.borderColor,
                  width: 5,
                ),
              ),
              margin: EdgeInsets.symmetric(
                vertical: size.height * 0.02,
                horizontal: size.width * 0.02,
              ),
              color: meeting.backgroundColor,
              elevation: 1,
              child: ListTile(
                title: Container(
                  height: size.width > 600
                      ? size.height * 0.25
                      : size.height * 0.15,
                  margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.05,
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
                          meeting.eventTitle,
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
                          ' ${meeting.fromZone} - ${meeting.toZone}',
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
                    types[meeting.meetingType],
                    color: meeting.borderColor,
                    size: size.width * 0.06,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
