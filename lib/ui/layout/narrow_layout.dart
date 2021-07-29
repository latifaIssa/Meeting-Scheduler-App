import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/ui/widges/getStartedPhoto.dart';
import 'package:meeting_scheduler_app/ui/widges/welcome.dart';

class NarrowLayout extends StatelessWidget {
  NarrowLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getStartedPhotoWidget(),
            WelcomeWidget(),
          ],
        ),
      ),
    );
  }
}
