import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/globals.dart';
import 'package:meeting_scheduler_app/models/filtered_list_model.dart';
import 'package:meeting_scheduler_app/providers/meeting_provider.dart';
import 'package:meeting_scheduler_app/ui/widges/circle_avater_widget.dart';
import 'package:meeting_scheduler_app/ui/widges/meeting_widget.dart';
import 'package:provider/provider.dart';

@immutable
class MeetingsScreen extends StatefulWidget {
  MeetingsScreen();
  @override
  _MeetingsScreenState createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MeetingProvider>(context, listen: false).getAllMeetings();
    // Provider.of<MeetingProvider>(context, listen: false)
    //     .getAllFilteredMeetings();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    final String today = Globals.globals.time(DateTime.now());
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              // margin: EdgeInsets.symmetric(
              //   horizontal: width * 0.02,
              //   vertical: height * 0.03,
              // ),
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
                              bottom: height * 0.05,
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
                              top: height * 0.02,
                              bottom: height * 0.05,
                            ),
                      child: CircleAvaterWidget(
                        Globals.globals.user.picture,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Selector<MeetingProvider, List<FilteredListModel>>(
                builder: (context, data, x) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Container(
                          width:
                              size.width > 600 ? size.width * 0.5 : size.width,
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width > 600
                                ? size.width * 0.02
                                : size.width * 0.05,
                          ),
                          child: Text(
                            today == data[i].date ? 'Today' : data[i].date,
                            style: TextStyle(
                              fontSize: 20,
                              color: Globals.globals.timeColor,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            ListView.builder(
                              // scrollDirection: size.width > 600
                              //     ? Axis.horizontal
                              //     : Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: data[i].meetings.length,
                              itemBuilder: (context, index) {
                                return data[i].meetings == null
                                    ? Text('theres no meetings exist')
                                    : MeetingWidget(data[i].meetings[index]);
                                // return Container(
                                //   child: Text(meetings[index].eventTitle),
                                // );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                      ],
                    );
                  });
            }, selector: (context, provider) {
              return provider.filteredMeetingsList;
            }),
          ],
        ),
      ),
    );
  }
}
