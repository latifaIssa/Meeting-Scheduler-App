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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: Text(
            ' ${meeting.day}, ${meeting.date}',
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
              vertical: size.width * 0.05,
              horizontal: size.width * 0.05,
            ),
            color: meeting.color,
            elevation: 1,
            child: ListTile(
              title: Container(
                height: size.height * 0.15,
                margin: EdgeInsets.symmetric(
                  vertical: size.width * 0.05,
                  horizontal: size.width * 0.02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Text(
                        meeting.title,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Globals.globals.titleColor,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        ' ${meeting.startTime} - ${meeting.startTime}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Globals.globals.timeColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // flex: 5,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: meeting.invitedPeople.length,
                          itemBuilder: (context, index) {
                            return CircleAvaterWidget(
                              meeting.invitedPeople[index].picture,
                            );
                          },
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
                  types[meeting.type],
                  color: meeting.borderColor,
                  size: size.width * 0.06,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
