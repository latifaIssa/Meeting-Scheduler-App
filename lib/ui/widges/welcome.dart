import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/helpers/sharedprefernces_helper.dart';
import 'package:meeting_scheduler_app/models/user.dart';
import 'package:meeting_scheduler_app/routing/router.dart';
import 'package:meeting_scheduler_app/ui/screens/bottom_nav_bar.dart';

class WelcomeWidget extends StatelessWidget {
  Random random = new Random();
  WelcomeWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 30,
            bottom: 30,
            left: 20,
            right: 20,
          ),
          child: Text(
            'Welcome to your team calendar, Margaret!',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            // top: 30,
            // bottom: 30,
            left: 20,
          ),
          child: Text(
            'Here, you cam see all your meetings and create new ones.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 35,
          ),
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF6f52ed),
              minimumSize: Size(double.infinity,
                  45), // double.infinity is the width and 30 is the height
            ),
            onPressed: () {
              User user = User(
                name: 'Latifa',
                email: 'latifa@gmail.com',
                password: '123',
                picture: 'assets/images/${(random.nextInt(7) + 1)}.jfif',
              );
              SpHelper.spHelper.saveUser(user);
              AppRouter.router.pushFunction(BottomNavBarWidget());
            },
            child: Text(
              'Get started!',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            // color: Color(0xFF6f52ed),
          ),
        ),
      ],
    );
  }
}
