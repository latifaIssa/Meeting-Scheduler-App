import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meeting_scheduler_app/helpers/sharedprefernces_helper.dart';
import 'package:meeting_scheduler_app/ui/layout/narrow_layout.dart';
import 'package:meeting_scheduler_app/ui/layout/wide_layout.dart';
import 'package:meeting_scheduler_app/ui/screens/bottom_nav_bar.dart';
import 'package:meeting_scheduler_app/ui/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  // const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1)).then(
      (value) {
        if (SpHelper.spHelper.getUser() != null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return (MediaQuery.of(context).size.width > 600)
                    ? WideLayout()
                    : NarrowLayout();
              },
            ),
          );
        }
      },
    );
    return Container();
  }
}
