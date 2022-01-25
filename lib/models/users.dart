import 'package:firebase_auth/firebase_auth.dart';

class Users {
  List<User> _Users;

  Users({List<User> users}) {
    this._Users = users;
    if (users == null) {
      this._Users = new List<User>();
    }
  }
  List<User> get users => _Users;
  set users(List<User> users) => _Users = users;

  // factory Users.fromJson(List<dynamic> json) => Users(
  //     users: List<User>.from(json.map((x) => User.fromJson(x))));
}

