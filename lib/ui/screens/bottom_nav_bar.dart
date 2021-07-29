import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/ui/widges/iconButtonWidget.dart';

class BottomNavBarWidget extends StatefulWidget {
  // const BottomNavBar({ Key? key }) : super(key: key);

  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int currentIndex = 0;
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Text('kkk'),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                        backgroundColor: Color(0xFF6f52ed),
                        child: Icon(Icons.add),
                        elevation: 0.1,
                        onPressed: () {}),
                  ),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.grid_view_rounded,
                            color: currentIndex == 0
                                ? Color(0xFF6f52ed)
                                : Color(0xFF6f52ed).withOpacity(0.6),
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);
                          },
                          splashColor: Colors.white,
                        ),
                        Container(
                          width: size.width * 0.20,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.calendar_today_rounded,
                              color: currentIndex == 1
                                  ? Color(0xFF6f52ed)
                                  : Color(0xFF6f52ed).withOpacity(0.6),
                            ),
                            onPressed: () {
                              setBottomBarIndex(1);
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0); // Start
    path.lineTo(size.width * 0.2, 0);
    // path.quadraticBezierTo(size.width * 0.36, 0, size.width * 0.39, 5);
    path.arcToPoint(Offset(size.width * 0.43, size.height * 0.6),
        radius: Radius.circular(120.0), clockwise: true);
    path.arcToPoint(Offset(size.width * 0.57, size.height * 0.6),
        radius: Radius.circular(35.0), clockwise: false);
    path.arcToPoint(Offset(size.width * 0.7, size.height * 0),
        radius: Radius.circular(120.0), clockwise: true);
    path.lineTo(size.width, size.height * 0);
    // canvas.drawShadow(path, Colors.white, 1, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
