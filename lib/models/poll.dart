
import 'dart:convert';

import 'package:pronz/models/option.dart';


class Poll {
  int _polid;
  String _title;
  int _postID;

  int get polid => _polid;
  int _status;
  List<Option> _options;

  String get title => _title;
  int get postID => _postID;
  int get status => _status;
  List<Option> get options => _options;

  Poll({
    int polid,
      String title, 
      int postID, 
      int status, 
      List<Option> options}){
    _polid= polid;
    _title = title;
    _postID = postID;
    _status = status;
    _options = options;
}

  Poll.fromJson(dynamic json) {
    _polid = json["PollID"];
    _title = json["Title"];
    _postID = json["PostID"];
    _status = json["Status"];
    if (json["options"] != null) {
      _options = [];
      json["options"].forEach((v) {
        _options.add(Option.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
   map["PollID"] =_polid;
    map["Title"] = _title;
    map["PostID"] = _postID;
    map["Status"] = _status;
    if (_options != null) {
      map["options"] =json.encode( _options.map((v) => v.toJson()).toList());
    }
    return map;
  }

}



