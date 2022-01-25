
import 'package:pronz/models/post.dart';

class Friend {
  int _userID;
  String _name;
  String _phoneNumber;
  String _varificationCode;
  int _uPublic;
  String _userName;
  int _gender;
  String _birthday;
  String _lat;
  String _lng;
  dynamic _token;
  bool _allowNotification;
  String _email;
  dynamic _socialToken;
  int _status;
  dynamic _lastSeen;
  dynamic _online;
  List<Post> _posts;

  int get userID => _userID;
  String get name => _name;
  String get phoneNumber => _phoneNumber;
  String get varificationCode => _varificationCode;
  int get uPublic => _uPublic;
  String get userName => _userName;
  int get gender => _gender;
  String get birthday => _birthday;
  String get lat => _lat;
  String get lng => _lng;
  dynamic get token => _token;
  bool get allowNotification => _allowNotification;
  String get email => _email;
  dynamic get socialToken => _socialToken;
  int get status => _status;
  dynamic get lastSeen => _lastSeen;
  dynamic get online => _online;
  List<Post> get posts => _posts;

  Friend({
      int userID, 
      String name, 
      String phoneNumber, 
      String varificationCode, 
      int uPublic, 
      String userName, 
      int gender, 
      String birthday, 
      String lat,
      String lng,
      dynamic token, 
      bool allowNotification, 
      String email, 
      dynamic socialToken, 
      int status, 
      dynamic lastSeen, 
      dynamic online, 
      List<Post> posts}){
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
    _lastSeen = lastSeen;
    _online = online;
    _posts = posts;
}

  Friend.fromJson(dynamic json) {
    _userID = json["UserID"];
    _name = json["Name"];
    _phoneNumber = json["PhoneNumber"];
    _varificationCode = json["VarificationCode"];
    _uPublic = json["UPublic"];
    _userName = json["UserName"];
    _gender = json["Gender"];
    _birthday = json["Birthday"];
    _lat = json["Lat"];
    _lng = json["Lng"];
    _token = json["Token"];
    _allowNotification = json["AllowNotification"];
    _email = json["Email"];
    _socialToken = json["SocialToken"];
    _status = json["Status"];
    _lastSeen = json["LastSeen"];
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

}