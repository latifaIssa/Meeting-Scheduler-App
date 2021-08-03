import 'package:meeting_scheduler_app/models/meeting.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String databaseName = "meeting.db";
  String tableName = "meetings_table";
  String colMeetingId = "id";
  String colEventName = "title";
  String colFrom = "from";
  String colTo = "to";
  String colIsAllDays = "isAllDays";
  String colBackgroundColor = "background";
  String colFromZone = "fromZone";
  String colToZone = "toZone";
  String colRecurrenceRule = "recurrenceRule";
  String colExceptionDates = "exceptionDates";
  String colType = "type";
  String colInvitedPeople = "invitedPeople";
  String colBorderColor = "borderColor";

  String todoTable = 'todo_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colStatus = 'status';
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
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'meeting.db';

    // Open/create the database at a given path
    var meetingsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return meetingsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    // var sql =
    //     'CREATE TABLE $tableName ( $colMeetingId INTEGER PRIMARY KEY AUTOINCREMENT, '
    //     '$colEventName TEXT, '
    //     '$colFrom TEXT, '
    //     '$colTo TEXT, '
    //     '$colIsAllDays INTEGER, '
    //     '$ColBackgroundColor TEXT, '
    //     '$colFromZone TEXT, '
    //     '$colToZone TEXT, '
    //     '$colRecurrenceRule TEXT, '
    //     '$colExceptionDates TEXT, '
    //     '$colType TEXT, '
    //     '$colInvitedPeople TEXT, '
    //     '$colBorderColor TEXT ) ';
    // await db.execute(sql);
    await db.execute(
        'CREATE TABLE $todoTable($colMeetingId INTEGER primary key autoincrement, $colEventName TEXT, '
            '$colFrom TEXT, $colTo TEXT, $colIsAllDays INTEGER  )');
  }

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
    var meetingMapList =
        await getMeetingMapList(); // Get 'Map List' from database
    int count =
        meetingMapList.length; // Count the number of map entries in db table

    List<Meeting> meetingList = List<Meeting>();
    // For loop to create a 'meeting List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      meetingList.add(Meeting.fromMapObject(meetingMapList[i]));
    }

    return meetingList;
  }

  getTablesNames() async {
    List<Map<String, Object>> tables = await _database
        .query('sqlite_master', where: 'type=?', whereArgs: ['table']);
    List<String> tablesNames = tables.map((e) => e['name'].toString()).toList();
    print(tablesNames);
  }
}
