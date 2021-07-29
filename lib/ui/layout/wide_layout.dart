import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/ui/widges/getStartedPhoto.dart';
import 'package:meeting_scheduler_app/ui/widges/welcome.dart';

class WideLayout extends StatelessWidget {
  WideLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: getStartedPhotoWidget(),
          ),
          Expanded(child: WelcomeWidget()),
        ],
      ),
    );
  }
}
