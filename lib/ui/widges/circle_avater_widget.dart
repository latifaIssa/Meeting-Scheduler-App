import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../globals.dart';

class CircleAvaterWidget extends StatelessWidget {
  // const CircleAvaterWidget({ Key? key }) : super(key: key);
  String pic;
  CircleAvaterWidget(this.pic);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(
          right: size.width * 0.01,
          top: size.width * 0.03,
        ),
        child: CircleAvatar(
          radius: size.width * 0.05,
          backgroundImage: AssetImage(
            pic,
          ),
          backgroundColor: Color(0xFF6f52ed),
          child: ClipOval(
            clipBehavior: Clip.antiAlias,
            // child: Image(
            //   fit: BoxFit.cover,
            //   width: size.width * 0.14,
            //   image: AssetImage(
            //     pic,
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
