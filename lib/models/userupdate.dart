import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';
import 'package:pronz/models/post.dart';
class Userr {
  int _userID;
  String _name;
  String _phoneNumber;
  String _varificationCode;
  int _uPublic;
  String _userName;

  set userID(int value) {
    _userID = value;
  }

  int _gender;
  DateTime _birthday;
  String _lat;
 String _lng;
  String _token;
  bool _allowNotification;
  String _email;
  String _socialToken;
  int _status;
  List<Post> _posts;
  DateTime _lastSeen;
     int _online;

  int get userID => _userID;
  String get name => _name;
  String get phoneNumber => _phoneNumber;
  String get varificationCode => _varificationCode;
  int get uPublic => _uPublic;
  String get userName => _userName;
  int get gender => _gender;
  DateTime get birthday => _birthday;
  String get lat => _lat;
  String get lng => _lng;
  String get token => _token;
  bool get allowNotification => _allowNotification;
  String get email => _email;
  String get socialToken => _socialToken;
  int get status => _status;
  List<Post> get posts => _posts;
  DateTime get lastSeen => _lastSeen;
  int get online => _online;

  Userr({
    int userID,
    String name,
    String phoneNumber,
    String varificationCode,
    int uPublic,
    String userName,
    int gender,
    DateTime birthday,
    String lat,
   String lng,
    String token,
    bool allowNotification,
    String email,
    String socialToken,
    int status,
    DateTime lastSeen,
    int online,
    /// List<Post> posts
  }){
    _userID = userID;
    _name = name;
    _phoneNumber = phoneNumber;
    _varificationCode = varificationCode;
    _uPublic = uPublic;
    _userName = userName;
    _gender = gender;
    _birthday = birthday;
    _lat = lat;
    _lng = lng;
    _token = token;
    _allowNotification = allowNotification;
    _email = email;
    _socialToken = socialToken;
    _status = status;
    _posts = posts;
    _lastSeen = lastSeen;
    _online = online;
  }

  Userr.fromJson(dynamic json) {
    _userID = json["UserID"];
    _name = json["Name"];
    _phoneNumber = json["PhoneNumber"];
    _varificationCode = json["VarificationCode"];
    _uPublic = json["UPublic"];
    _userName = json["UserName"];
    _gender = json["Gender"];
    _birthday = DateTime.parse(json["Birthday"]);
    _lat = json["Lat"];
    _lng = json["Lng"];
    _token = json["Token"];
    _allowNotification = json["AllowNotification"];
    _email = json["Email"];
    _socialToken = json["SocialToken"];
    _status = json["Status"];
   json["LastSeen"]==null? _lastSeen=DateTime.now():
  _lastSeen = DateTime.parse(json["LastSeen"]);
    _online = json["Online"];
    if (json["posts"] != null) {
      _posts = [];
      json["posts"].forEach((v) {
        _posts.add(Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["UserID"] = _userID;
    map["Name"] = _name;
    map["PhoneNumber"] = _phoneNumber;
    map["VarificationCode"] = _varificationCode;
    map["UPublic"] = _uPublic;
    map["UserName"] = _userName;
    map["Gender"] = _gender;
    map["Birthday"] = _birthday;
    map["Lat"] = _lat;
    map["Lng"] = _lng;
    map["Token"] = _token;
    map["AllowNotification"] = _allowNotification;
    map["Email"] = _email;
    map["SocialToken"] = _socialToken;
    map["Status"] = _status;
    map["LastSeen"] = _lastSeen;
    map["Online"] = _online;
    if (_posts != null) {
      map["posts"] = _posts.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set name(String value) {
    _name = value;
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  set varificationCode(String value) {
    _varificationCode = value;
  }

  set uPublic(int value) {
    _uPublic = value;
  }

  set userName(String value) {
    _userName = value;
  }

  set gender(int value) {
    _gender = value;
  }

  set birthday(DateTime value) {
    _birthday = value;
  }

  set lat(String value) {
    _lat = value;
  }

  set lng(String value) {
    _lng = value;
  }

  set token(String value) {
    _token = value;
  }

  set allowNotification(bool value) {
    _allowNotification = value;
  }

  set email(String value) {
    _email = value;
  }

  set socialToken(String value) {
    _socialToken = value;
  }

  set status(int value) {
    _status = value;
  }

  set posts(List<dynamic> value) {
    _posts = value;
  }
}