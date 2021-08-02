import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/ui/screens/calendar.dart';
import 'package:meeting_scheduler_app/ui/screens/meetings_sceen.dart';
import 'package:meeting_scheduler_app/ui/widges/_getAppointmentEditor.dart';
import 'package:meeting_scheduler_app/ui/widges/add_meeting.dart';
import 'package:meeting_scheduler_app/ui/widges/iconButtonWidget.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int index = 0;
  TabController tabController;
  // final List<TitledNavigationBarItem> items = [
  //   TitledNavigationBarItem(
  //     icon: Icons.grid_view_rounded,
  //     title: Text(''),
  //   ),
  //   TitledNavigationBarItem(
  //     icon: Icons.calendar_today_rounded,
  //     title: Text(''),
  //   ),
  // ];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            child: MeetingsScreen(),
          ),
          Center(
            child: CalendarScreen(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //Floating action button on Scaffold
        onPressed: () async {
          // getAppointmentEditor();
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddMeeting();
              },
            ),
          );
          //code to execute on button press
        },
        backgroundColor: Color(0xFF6f52ed),
        child: Icon(Icons.add), //icon inside button
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      //floating action button position to center

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), //shape of notch
        // shape: AutomaticNotchedShape(
        //   RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(50),
        //       topRight: Radius.circular(50),
        //     ),
        //   ),
        //   RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(
        //       Radius.circular(50),
        //     ),
        //   ),
        // ),
        // child: SizedBox(
        //   width: double.infinity,
        //   height: 60,
        // ),
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

      // bottomNavigationBar: TitledBottomNavigationBar(
      //   onTap: (index) => print("Selected Index: $index"),
      //   // Switch(
      //   //     value: navBarMode,
      //   //     onChanged: (v) {
      //   //       setState(() => navBarMode = v);
      //   //     },
      //   //   ),
      //   // onTap: (tapedIndex) {
      //   //   // this.index = tapedIndex;

      //   //   tabController.animateTo(tapedIndex);
      //   //   // setState(() {});
      //   // },
      //   currentIndex: 0,
      //   reverse: navBarMode,
      //   curve: Curves.easeInBack,
      //   items: items,
      //   activeColor: Color(0xFF6f52ed),
      //   inactiveColor: Color(0xFF6f52ed).withOpacity(0.6),
      //   indicatorColor: Color(0xFF6f52ed),
      // ),
    );
  }
}
