import 'dart:io';

import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper {
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  static final String databaseName = "meeting.db";
  static final String tableName = "meetings_table";
  static final String colMeetingId = "id";
  static final String colEventName = "eventTitle";
  static final String colFrom = "fromDate";
  static final String colTo = "toDate";
  static final String colIsAllDays = "isAllDay";
  static final String colBackgroundColor = "backgroundColor";
  static final String colFromZone = "fromZone";
  static final String colToZone = "toZone";
  static final String colRecurrenceRule = "recurrencesRule";
  static final String colExceptionDates = "exceptionsDates";
  static final String colType = "meetingType";
  static final String colInvitedPeople = "invitedPeople";
  static final String colBorderColor = "borderColor";

  Database database;
  initDatabase() async {
    database = await createConnection();
  }

  Future<Database> createConnection() async {
    Directory directory = await getApplicationDocumentsDirectory();

    Database database = await openDatabase(join(directory.path, databaseName),
        version: 1, onCreate: (db, version) {
      db.execute('''
          create table $tableName ( 
          $colMeetingId integer primary key autoincrement, 
          $colEventName text not null,
          $colFrom text not null,
          $colTo text not null,
          $colIsAllDays integer,
          $colBackgroundColor integer,
          $colFromZone TEXT,
          $colToZone TEXT,
          $colRecurrenceRule integer,
          $colExceptionDates TEXT,
          $colType TEXT,
          $colBorderColor integer)
        ''');
    });
    return database;
  }

  Future<int> insertMeeting(Meeting meeting) async {
    try {
      int rowNum = await database.insert(tableName, meeting.toMap());
      print(rowNum);
      return rowNum;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<List<Meeting>> getAllMeetings() async {
    try {
      List<Map<String, dynamic>> results = await database.query(tableName);
      List<Meeting> meetings = results.map((e) => Meeting.fromMap(e)).toList();
      return meetings;
    } on Exception catch (e) {
      return null;
    }
  }
}
