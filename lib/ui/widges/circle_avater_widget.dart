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
    return Container(
      child: CircleAvatar(
        radius: size.width > 600 ? size.height * 0.07 : size.width * 0.07,
        backgroundImage: AssetImage(
          pic,
        ),
        backgroundColor: Color(0xFF6f52ed),
      ),
    );
  }
}
