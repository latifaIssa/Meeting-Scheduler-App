import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class getStartedPhotoWidget extends StatelessWidget {
  double h = 1.8;
  double w = 1;

  getStartedPhotoWidget();
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      h = 1;
      w = 1.8;
    }
    return Container(
      height: MediaQuery.of(context).size.height / h,
      width: MediaQuery.of(context).size.width / w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(-25),
          bottomRight: Radius.circular(-180),
        ),
        border: Border.all(
          width: 1,
          color: Colors.white10,
          style: BorderStyle.solid,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(
            'assets/images/getStarted.jfif',
          ),
          fit: BoxFit.cover,
        ),
      ),
      // child: Image(
      //   // width: ,
      //   image: AssetImage(
      //     'assets/images/getStarted.jfif',
      //   ),
      //   fit: BoxFit.cover,
      // ),
    );
  }
}
