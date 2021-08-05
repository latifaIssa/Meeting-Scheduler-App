import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_scheduler_app/models/meeting.dart';

class TimePickerWidget extends StatefulWidget {
  Meeting meeting;
  DateTime newTime;
  String newTimeString;
  bool isStart;
  TimePickerWidget(
      {this.meeting, this.newTime, this.newTimeString, this.isStart});
  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  DateTime _newTime;
  String _newTimeString;
  Function onSaveTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () async {
          var selectedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (selectedTime != null) {
            final now = DateTime.now();
            var selectedDateTime = DateTime(now.year, now.month, now.day,
                selectedTime.hour, selectedTime.minute);
            _newTime = selectedDateTime;
            setState(() {
              _newTimeString = DateFormat('HH:mm').format(selectedDateTime);
            });
          }
        },
        child: widget.isStart
            ? Column(children: [Text('Start Time'), Text(_newTimeString)])
            : Column(children: [Text('End Time'), Text(_newTimeString)]),
      ),
    );
  }
}
