import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/helpers/db_helper.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:meeting_scheduler_app/services/route_helper.dart';
import 'package:meeting_scheduler_app/ui/screens/calendar.dart';
import 'package:meeting_scheduler_app/ui/screens/meetings_sceen.dart';
import 'package:meeting_scheduler_app/ui/widges/add_meeting.dart';
import 'package:meeting_scheduler_app/ui/widges/iconButtonWidget.dart';
import 'package:sqflite/sqflite.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // DatabaseHelper databaseHelper = DatabaseHelper();
  Future<List<Meeting>> newMeetings;
  List<Meeting> meetings;
  List<DateTime> dates;
  Meeting meeting;
  int index = 0;
  TabController tabController;
  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      // title: Text('home'),
      icon: Icon(Icons.grid_view_rounded),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.calendar_today_rounded,
      ),
      label: '',
      // onPressed: () {},
    ),
  ];
  bool navBarMode = false;
  initTabController() {
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void initState() {
    super.initState();
    initTabController();
  }

  void navigateToDetail() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddMeeting();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          MeetingsScreen(),
          Center(
            child: CalendarScreen(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //Floating action button on Scaffold
        onPressed: () async {
          RouteHelper.routeHelper.goToPage(AddMeeting.routeName);
        },
        backgroundColor: Color(0xFF6f52ed),
        child: Icon(Icons.add), //icon inside button
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      //floating action button position to center

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        //notche margin between floating button and bottom appbar
        child: BottomNavigationBar(
          unselectedItemColor: Color(0xFF6f52ed).withOpacity(0.6),
          fixedColor: Color(0xFF6f52ed),
          onTap: (tapedIndex) {
            this.index = tapedIndex;
            tabController.animateTo(tapedIndex);
            setState(() {});
          },
          currentIndex: index,
          items: items,
        ),
      ),
    );
  }
}
