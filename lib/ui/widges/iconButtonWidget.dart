import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  IconData icon;
  int currentIndex;
  IconButtonWidget({this.icon, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: currentIndex == 0
          ? Color(0xFF6f52ed)
          : Color(0xFF6f52ed).withOpacity(0.6),
    );
  }
}
