import 'package:flutter/cupertino.dart';

class User {
  String name;
  String email;
  String picture;
  String password;

  User({
    @required this.name,
    @required this.email,
    this.picture,
    this.password,
  });
  factory User.map(Map map) {
    return User(
        name: map['name'],
        email: map['emailAddress'],
        password: map['password'],
        picture: map['picture']);
  }

  Map<String, dynamic> toMap() {
    Map map = {
      'email': this.email,
      'password': this.password,
      'name': this.name,
      'picture': this.picture,
    };
    return {...map};
  }
}
