import 'dart:convert';

import 'package:meeting_scheduler_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';

class SpHelper {
  SpHelper._();
  static SpHelper spHelper = SpHelper._();
  SharedPreferences sharedPreferences;
  initSharedPrefernces() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  saveUser(User user) {
    Globals.globals.user = user;
    sharedPreferences.setString('user', json.encode({...user.toMap()}));
  }

  User getUser() {
    // try {
    String user1 = sharedPreferences.getString('user');
    if (user1 == null) {
      return null;
    }
    // assert(user1 != null);
    Map userMap = json.decode(user1);
    User user = User.map(userMap);
    Globals.globals.user = user;
    return user;
    // } on Exception catch (e) {
    //   return null;
    // }
  }

  signOut() {
    sharedPreferences.remove('user');
  }
}
