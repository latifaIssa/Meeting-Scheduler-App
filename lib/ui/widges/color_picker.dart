import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meeting_scheduler_app/globals.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';

class ColorPickerWidget extends StatefulWidget {
  Meeting meeting;
  ColorPickerWidget(meeting);
  @override
  State<StatefulWidget> createState() {
    return _ColorPickerWidgetState();
  }
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  // List<Color> _colorCollection;
  // int _selectedColorIndex = 0;
  // List<String> _colorNames;
  // create some values
  Color currentColor = Colors.blue;
  List<Color> currentColors = [Colors.blue, Colors.green];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);

  @override
  Widget build(BuildContext context) {
    // return AlertDialog(
    //   content: Container(
    //       width: double.maxFinite,
    //       child: ListView.builder(
    //         padding: const EdgeInsets.all(0),
    //         itemCount: _colorCollection.length - 1,
    //         itemBuilder: (BuildContext context, int index) {
    //           return ListTile(
    //             contentPadding: const EdgeInsets.all(0),
    //             leading: Icon(
    //                 index == _selectedColorIndex
    //                     ? Icons.lens
    //                     : Icons.trip_origin,
    //                 color: _colorCollection[index]),
    //             title: Text(_colorNames[index]),
    //             onTap: () {
    //               setState(() {
    //                 _selectedColorIndex = index;
    //               });

    //               // ignore: always_specify_types
    //               Future.delayed(const Duration(milliseconds: 200), () {
    //                 // When task is over, close the dialog
    //                 Navigator.pop(context);
    //               });
    //             },
    //           );
    //         },
    //       )),
    // );
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: Globals.globals.colors[widget.meeting.backgroundColor],
          onColorChanged: changeColor,
          colorPickerWidth: 300.0,
          pickerAreaHeightPercent: 0.7,
          enableAlpha: true,
          displayThumbColor: true,
          showLabel: true,
          paletteType: PaletteType.hsv,
          pickerAreaBorderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(2.0),
            topRight: const Radius.circular(2.0),
          ),
        ),
      ),
    );
  }
}
