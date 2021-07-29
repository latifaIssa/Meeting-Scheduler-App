import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/data/meetings-info.dart';
import 'package:meeting_scheduler_app/globals.dart';
import 'package:meeting_scheduler_app/ui/widges/meeting_widget.dart';

class MeetingsScreen extends StatelessWidget {
  // const MeetingsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Expanded(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
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
                        right: size.width * 0,
                        top: size.width * 0.03,
                      ),
                      child: CircleAvatar(
                        radius: size.width * 0.07,
                        // backgroundImage: AssetImage(
                        //   Globals.globals.user.picture,
                        // ),
                        backgroundColor: Color(0xFF6f52ed),
                        child: ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: Image(
                            fit: BoxFit.cover,
                            width: size.width * 0.14,
                            image: AssetImage(
                              Globals.globals.user.picture,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: ListView.builder(
                    itemCount: meetings.length,
                    shrinkWrap: true,
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
          ),
        ),
      ),
    );
  }
}
