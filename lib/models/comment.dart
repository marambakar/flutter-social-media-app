

import 'package:flutter/material.dart';

class Comment {
  int _commentID;
  String _text;

  set commentID(int value) {
    _commentID = value;
  }

  int _postID;
  int _userID;
  int _status;
  String _ownerName;
  String _timeStamp;
  int _likeID;
  int _dislikeID;
  Color coler;

  int get commentID => _commentID;
  String get text => _text;
  int get postID => _postID;
  int get userID => _userID;
  int get status => _status;
  String get ownerName => _ownerName;
  String get timeStamp => _timeStamp;
  int get likeID => _likeID;
  int get dislikeID => _dislikeID;

  Comment({
      int commentID, 
      String text, 
      int postID, 
      int userID, 
      int status, 
      String ownerName, 
      String timeStamp, 
      int likeID, 
      int dislikeID,
      Color coler
  }){
    _commentID = commentID;
    _text = text;
    _postID = postID;
    _userID = userID;
    _status = status;
    _ownerName = ownerName;
    _timeStamp = timeStamp;
    _likeID = likeID;
    _dislikeID = dislikeID;
    coler=this.coler;
}

  Comment.fromJson(dynamic json) {
    _commentID = json["CommentID"];
    _text = json["Text"];
    _postID = json["PostID"];
    _userID = json["UserID"];
    _status = json["Status"];
    _ownerName = json["OwnerName"];
    _timeStamp = json["TimeStamp"];
    _likeID = json["LikeID"];
    _dislikeID = json["DislikeID"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["CommentID"] = _commentID;
    map["Text"] = _text;
    map["PostID"] = _postID;
    map["UserID"] = _userID;
    map["Status"] = _status;
    map["OwnerName"] = _ownerName;
    map["TimeStamp"] = _timeStamp;
    map["LikeID"] = _likeID;
    map["DislikeID"] = _dislikeID;
    return map;
  }

  set text(String value) {
    _text = value;
  }

  set postID(int value) {
    _postID = value;
  }

  set userID(int value) {
    _userID = value;
  }

  set status(int value) {
    _status = value;
  }

  set ownerName(String value) {
    _ownerName = value;
  }

  set timeStamp(String value) {
    _timeStamp = value;
  }

  set likeID(int value) {
    _likeID = value;
  }

  set dislikeID(int value) {
    _dislikeID = value;
  }
}