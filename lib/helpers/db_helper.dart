import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

final String databaseName = "meeting.db";
final String tableName = "meetings_table";
final String colMeetingId = "id";
final String colEventName = "eventTitle";
final String colFrom = "fromDate";
final String colTo = "toDate";
final String colIsAllDays = "isAllDays";
final String colBackgroundColor = "backgroundColor";
final String colFromZone = "fromZone";
final String colToZone = "toZone";
final String colRecurrenceRule = "recurrencesRule";
final String colExceptionDates = "exceptionsDates";
final String colType = "meetingType";
final String colInvitedPeople = "invitedPeople";
final String colBorderColor = "borderColor";

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    // Directory directory = await getApplicationDocumentsDirectory();
    var dir = await getDatabasesPath();
    var path = dir + "meeting.db";
    // String path = dir.path + 'meeting.db';

    // Open/create the database at a given path
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableName ( 
          $colMeetingId integer primary key autoincrement, 
          $colEventName text not null,
          $colFrom text not null,
          $colTo text not null,
          $colIsAllDays integer,
          $colBackgroundColor TEXT,
          $colFromZone TEXT,
          $colToZone TEXT,
          $colRecurrenceRule TEXT,
          $colExceptionDates TEXT,
          $colType TEXT,
          $colInvitedPeople TEXT,
          $colBorderColor TEXT)
        ''');
      },
    );
    return database;
  }

  // void _createDb(Database db, int newVersion) async {
  //   var sql =
  //       'CREATE TABLE $tableName ( $colMeetingId INTEGER PRIMARY KEY AUTOINCREMENT, '
  //       '$colEventName TEXT, '
  //       '$colFrom TEXT, '
  //       '$colTo TEXT, '
  //       '$colIsAllDays INTEGER, '
  //       '$colBackgroundColor TEXT, '
  //       '$colFromZone TEXT, '
  //       '$colToZone TEXT, '
  //       '$colRecurrenceRule TEXT, '
  //       '$colExceptionDates TEXT, '
  //       '$colType TEXT, '
  //       '$colInvitedPeople TEXT, '
  //       '$colBorderColor TEXT ) ';
  //   await db.execute(sql);
  //   // await db.execute(
  //   //     'CREATE TABLE $todoTable($colMeetingId INTEGER primary key autoincrement, $colEventName TEXT, '
  //   //         '$colFrom TEXT, $colTo TEXT, $colIsAllDays INTEGER  )');
  // }

  // Fetch Operation: Get all meeting objects from database
  Future<List<Map<String, dynamic>>> getMeetingMapList() async {
    Database db = await this.database;
// , orderBy: '$colFrom ASC'
//		var result = await db.rawQuery('SELECT * FROM $meetingTable order by $colTitle ASC');
    var result = await db.query(tableName);
    return result;
  }

  // Insert Operation: Insert a meeting object to database
  Future<int> insertMeeting(Meeting meeting) async {
    Database db = await this.database;
    var result = await db.insert(tableName, meeting.toMap());
    return result;
  }

  // Update Operation: Update a meeting object and save it to database
  Future<int> updateMeeting(Meeting meeting) async {
    var db = await this.database;
    var result = await db.update(tableName, meeting.toMap(),
        where: '$colMeetingId = ?', whereArgs: [meeting.id]);
    return result;
  }

  // Delete Operation: Delete a meeting object from database
  Future<int> deleteMeeting(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $tableName WHERE $colMeetingId = $id');
    return result;
  }

  // Get number of meetings objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Meetings List' [ List<Meeting> ]
  Future<List<Meeting>> getMeetingList() async {
//     var meetingMapList =
//         await getMeetingMapList(); // Get 'Map List' from database
//     int count =
//         meetingMapList.length; // Count the number of map entries in db table
// var db = await this.database;
//     List<Meeting> meetingList = List<Meeting>();
//     // For loop to create a 'meeting List' from a 'Map List'
//     for (int i = 0; i < count; i++) {
//       meetingList.add(Meeting.fromMapObject(meetingMapList[i]));
//     }

//     return meetingList;
    List<Meeting> _meetings = [];

    var db = await this.database;
    var result = await db.query(tableName);
    result.forEach((element) {
      var meetingsInfo = Meeting.fromMap(element);
      _meetings.add(meetingsInfo);
    });

    return _meetings;
  }

  getTablesNames() async {
    List<Map<String, Object>> tables = await _database
        .query('sqlite_master', where: 'type=?', whereArgs: ['table']);
    List<String> tablesNames = tables.map((e) => e['name'].toString()).toList();
    print(tablesNames);
  }
}
