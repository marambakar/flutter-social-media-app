

class Dislike {
  int _postID;
  int _userID;
  int _status;
  String _userName;

  int get postID => _postID;
  int get userID => _userID;
  int get status => _status;
  String get userName => _userName;

  Dislike({
      int postID, 
      int userID, 
      int status, 
      String userName}){
    _postID = postID;
    _userID = userID;
    _status = status;
    _userName = userName;
}

  Dislike.fromJson(dynamic json) {
    _postID = json["PostID"];
    _userID = json["UserID"];
    _status = json["Status"];
    _userName = json["UserName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["PostID"] = _postID;
    map["UserID"] = _userID;
    map["Status"] = _status;
    map["UserName"] = _userName;
    return map;
  }

}