// library event_calendar;

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:meeting_scheduler_app/models/data_source.dart';
// import 'package:meeting_scheduler_app/models/meeting.dart';
// import 'package:meeting_scheduler_app/ui/widges/_TimeZonePicker.dart';
// import 'package:meeting_scheduler_app/ui/widges/color_picker.dart';
// import 'package:meeting_scheduler_app/ui/widges/resources_picker.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

// class getAppointmentEditor extends StatefulWidget {
//   // const getAppointmentEditor({ Key? key }) : super(key: key);

//   @override
//   _getAppointmentEditorState createState() => _getAppointmentEditorState();
// }

// class _getAppointmentEditorState extends State<getAppointmentEditor> {
//   List<Color> _colorCollection;
//   List<String> _colorNames;
//   int _selectedColorIndex = 0;
//   int _selectedTimeZoneIndex = 0;
//   int _selectedResourceIndex = 0;
//   List<String> _timeZoneCollection;
//   DataSource _events;
//   Meeting _selectedAppointment;
//   DateTime _startDate;
//   TimeOfDay _startTime;
//   DateTime _endDate;
//   TimeOfDay _endTime;
//   bool _isAllDay;
//   String _subject = '';
//   String _notes = '';
//   List<CalendarResource> _employeeCollection;
//   List<String> _nameCollection;
//   // void initState() {
//   //   _addResourceDetails();
//   //   _employeeCollection = <CalendarResource>[];
//   //   _addResources();
//   //   _events = DataSource(getMeetingDetails(), _employeeCollection);
//   //   _selectedAppointment = null;
//   //   _selectedColorIndex = 0;
//   //   _selectedTimeZoneIndex = 0;
//   //   _selectedResourceIndex = 0;
//   //   _subject = '';
//   //   _notes = '';
//   //   super.initState();
//   // }

//   Widget _getAppointmentEditor(BuildContext context) {
//     return Container(
//         color: Colors.white,
//         child: ListView(
//           padding: const EdgeInsets.all(0),
//           children: <Widget>[
//             ListTile(
//               contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
//               leading: const Text(''),
//               title: TextField(
//                 controller: TextEditingController(text: _subject),
//                 onChanged: (String value) {
//                   _subject = value;
//                 },
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 style: TextStyle(
//                     fontSize: 25,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w400),
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Add title',
//                 ),
//               ),
//             ),
//             const Divider(
//               height: 1.0,
//               thickness: 1,
//             ),
//             ListTile(
//                 contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
//                 leading: Icon(
//                   Icons.access_time,
//                   color: Colors.black54,
//                 ),
//                 title: Row(children: <Widget>[
//                   const Expanded(
//                     child: Text('All-day'),
//                   ),
//                   Expanded(
//                       child: Align(
//                           alignment: Alignment.centerRight,
//                           child: Switch(
//                             value: _isAllDay,
//                             onChanged: (bool value) {
//                               setState(() {
//                                 _isAllDay = value;
//                               });
//                             },
//                           ))),
//                 ])),
//             ListTile(
//                 contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
//                 leading: const Text(''),
//                 title: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Expanded(
//                         flex: 7,
//                         child: GestureDetector(
//                             child: Text(
//                                 DateFormat('EEE, MMM dd yyyy')
//                                     .format(_startDate),
//                                 textAlign: TextAlign.left),
//                             onTap: () async {
//                               final DateTime date = await showDatePicker(
//                                 context: context,
//                                 initialDate: _startDate,
//                                 firstDate: DateTime(1900),
//                                 lastDate: DateTime(2100),
//                               );

//                               if (date != null && date != _startDate) {
//                                 setState(() {
//                                   final Duration difference =
//                                       _endDate.difference(_startDate);
//                                   _startDate = DateTime(
//                                       date.year,
//                                       date.month,
//                                       date.day,
//                                       _startTime.hour,
//                                       _startTime.minute,
//                                       0);
//                                   _endDate = _startDate.add(difference);
//                                   _endTime = TimeOfDay(
//                                       hour: _endDate.hour,
//                                       minute: _endDate.minute);
//                                 });
//                               }
//                             }),
//                       ),
//                       Expanded(
//                           flex: 3,
//                           child: _isAllDay
//                               ? const Text('')
//                               : GestureDetector(
//                                   child: Text(
//                                     DateFormat('hh:mm a').format(_startDate),
//                                     textAlign: TextAlign.right,
//                                   ),
//                                   onTap: () async {
//                                     final TimeOfDay time = await showTimePicker(
//                                         context: context,
//                                         initialTime: TimeOfDay(
//                                             hour: _startTime.hour,
//                                             minute: _startTime.minute));

//                                     if (time != null && time != _startTime) {
//                                       setState(() {
//                                         _startTime = time;
//                                         final Duration difference =
//                                             _endDate.difference(_startDate);
//                                         _startDate = DateTime(
//                                             _startDate.year,
//                                             _startDate.month,
//                                             _startDate.day,
//                                             _startTime.hour,
//                                             _startTime.minute,
//                                             0);
//                                         _endDate = _startDate.add(difference);
//                                         _endTime = TimeOfDay(
//                                             hour: _endDate.hour,
//                                             minute: _endDate.minute);
//                                       });
//                                     }
//                                   })),
//                     ])),
//             ListTile(
//                 contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
//                 leading: const Text(''),
//                 title: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Expanded(
//                         flex: 7,
//                         child: GestureDetector(
//                             child: Text(
//                               DateFormat('EEE, MMM dd yyyy').format(_endDate),
//                               textAlign: TextAlign.left,
//                             ),
//                             onTap: () async {
//                               final DateTime date = await showDatePicker(
//                                 context: context,
//                                 initialDate: _endDate,
//                                 firstDate: DateTime(1900),
//                                 lastDate: DateTime(2100),
//                               );

//                               if (date != null && date != _endDate) {
//                                 setState(() {
//                                   final Duration difference =
//                                       _endDate.difference(_startDate);
//                                   _endDate = DateTime(
//                                       date.year,
//                                       date.month,
//                                       date.day,
//                                       _endTime.hour,
//                                       _endTime.minute,
//                                       0);
//                                   if (_endDate.isBefore(_startDate)) {
//                                     _startDate = _endDate.subtract(difference);
//                                     _startTime = TimeOfDay(
//                                         hour: _startDate.hour,
//                                         minute: _startDate.minute);
//                                   }
//                                 });
//                               }
//                             }),
//                       ),
//                       Expanded(
//                           flex: 3,
//                           child: _isAllDay
//                               ? const Text('')
//                               : GestureDetector(
//                                   child: Text(
//                                     DateFormat('hh:mm a').format(_endDate),
//                                     textAlign: TextAlign.right,
//                                   ),
//                                   onTap: () async {
//                                     final TimeOfDay time = await showTimePicker(
//                                         context: context,
//                                         initialTime: TimeOfDay(
//                                             hour: _endTime.hour,
//                                             minute: _endTime.minute));

//                                     if (time != null && time != _endTime) {
//                                       setState(() {
//                                         _endTime = time;
//                                         final Duration difference =
//                                             _endDate.difference(_startDate);
//                                         _endDate = DateTime(
//                                             _endDate.year,
//                                             _endDate.month,
//                                             _endDate.day,
//                                             _endTime.hour,
//                                             _endTime.minute,
//                                             0);
//                                         if (_endDate.isBefore(_startDate)) {
//                                           _startDate =
//                                               _endDate.subtract(difference);
//                                           _startTime = TimeOfDay(
//                                               hour: _startDate.hour,
//                                               minute: _startDate.minute);
//                                         }
//                                       });
//                                     }
//                                   })),
//                     ])),
//             ListTile(
//               contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
//               leading: Icon(
//                 Icons.public,
//                 color: Colors.black87,
//               ),
//               title: Text(_timeZoneCollection[_selectedTimeZoneIndex]),
//               onTap: () {
//                 showDialog<Widget>(
//                   context: context,
//                   barrierDismissible: true,
//                   builder: (BuildContext context) {
//                     return TimeZonePicker();
//                   },
//                 ).then((dynamic value) => setState(() {}));
//               },
//             ),
//             const Divider(
//               height: 1.0,
//               thickness: 1,
//             ),
//             ListTile(
//               contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
//               leading: Icon(Icons.lens,
//                   color: _colorCollection[_selectedColorIndex]),
//               title: Text(
//                 _colorNames[_selectedColorIndex],
//               ),
//               onTap: () {
//                 showDialog<Widget>(
//                   context: context,
//                   barrierDismissible: true,
//                   builder: (BuildContext context) {
//                     return ColorPicker();
//                   },
//                 ).then((dynamic value) => setState(() {}));
//               },
//             ),
//             const Divider(
//               height: 1.0,
//               thickness: 1,
//             ),
//             ListTile(
//               contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
//               leading: Icon(Icons.person_pin),
//               title: Text(
//                 _nameCollection[_selectedResourceIndex],
//               ),
//               onTap: () {
//                 showDialog<Widget>(
//                   context: context,
//                   barrierDismissible: true,
//                   builder: (BuildContext context) {
//                     return ResourcePicker();
//                   },
//                 ).then((dynamic value) => setState(() {}));
//               },
//             ),
//             const Divider(
//               height: 1.0,
//               thickness: 1,
//             ),
//             ListTile(
//               contentPadding: const EdgeInsets.all(5),
//               leading: Icon(
//                 Icons.subject,
//                 color: Colors.black87,
//               ),
//               title: TextField(
//                 controller: TextEditingController(text: _notes),
//                 onChanged: (String value) {
//                   _notes = value;
//                 },
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w400),
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Add description',
//                 ),
//               ),
//             ),
//             const Divider(
//               height: 1.0,
//               thickness: 1,
//             ),
//           ],
//         ));
//   }

//   @override
//   Widget build([BuildContext context]) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//             appBar: AppBar(
//               title: Text(getTitle()),
//               backgroundColor: _colorCollection[_selectedColorIndex],
//               leading: IconButton(
//                 icon: const Icon(
//                   Icons.close,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               actions: <Widget>[
//                 IconButton(
//                     padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
//                     icon: const Icon(
//                       Icons.done,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       final List<Meeting> meetings = <Meeting>[];
//                       if (_selectedAppointment != null) {
//                         _events.appointments.removeAt(
//                             _events.appointments.indexOf(_selectedAppointment));
//                         _events.notifyListeners(CalendarDataSourceAction.remove,
//                             <Meeting>[]..add(_selectedAppointment));
//                       }
//                       meetings.add(Meeting(
//                         from: _startDate,
//                         to: _endDate,
//                         background: _colorCollection[_selectedColorIndex],
//                         startTimeZone: _selectedTimeZoneIndex == 0
//                             ? ''
//                             : _timeZoneCollection[_selectedTimeZoneIndex],
//                         endTimeZone: _selectedTimeZoneIndex == 0
//                             ? ''
//                             : _timeZoneCollection[_selectedTimeZoneIndex],
//                         description: _notes,
//                         isAllDay: _isAllDay,
//                         eventName: _subject == '' ? '(No title)' : _subject,
//                         //  ids: <String>[
//                         //   _employeeCollection[_selectedResourceIndex].id
//                         // ],
//                       ));

//                       _events.appointments.add(meetings[0]);

//                       _events.notifyListeners(
//                           CalendarDataSourceAction.add, meetings);
//                       _selectedAppointment = null;

//                       Navigator.pop(context);
//                     })
//               ],
//             ),
//             body: Padding(
//               padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
//               child: Stack(
//                 children: <Widget>[_getAppointmentEditor(context)],
//               ),
//             ),
//             floatingActionButton: _selectedAppointment == null
//                 ? const Text('')
//                 : FloatingActionButton(
//                     onPressed: () {
//                       if (_selectedAppointment != null) {
//                         _events.appointments.removeAt(
//                             _events.appointments.indexOf(_selectedAppointment));
//                         _events.notifyListeners(CalendarDataSourceAction.remove,
//                             <Meeting>[]..add(_selectedAppointment));
//                         _selectedAppointment = null;
//                         Navigator.pop(context);
//                       }
//                     },
//                     child:
//                         const Icon(Icons.delete_outline, color: Colors.white),
//                     backgroundColor: Colors.red,
//                   )));
//   }

//   String getTitle() {
//     return _subject.isEmpty ? 'New event' : 'Event details';
//   }
// }
