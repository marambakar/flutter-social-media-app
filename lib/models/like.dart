/// LikeID : 2
/// PostID : 47
/// UserID : 39
/// Status : 1
/// TimeStamp : "2021-07-04T17:47:51.757"
/// UserName : "user2"

class Like {
  int _likeID;
  int _postID;
  int _userID;
  int _status;
  String _timeStamp;
  String _userName;

  int get likeID => _likeID;
  int get postID => _postID;
  int get userID => _userID;
  int get status => _status;
  String get timeStamp => _timeStamp;
  String get userName => _userName;

  Like({
      int likeID, 
      int postID, 
      int userID, 
      int status, 
      String timeStamp, 
      String userName}){
    _likeID = likeID;
    _postID = postID;
    _userID = userID;
    _status = status;
    _timeStamp = timeStamp;
    _userName = userName;
}

  Like.fromJson(dynamic json) {
    _likeID = json["LikeID"];
    _postID = json["PostID"];
    _userID = json["UserID"];
    _status = json["Status"];
    _timeStamp = json["TimeStamp"];
    _userName = json["UserName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["LikeID"] = _likeID;
    map["PostID"] = _postID;
    map["UserID"] = _userID;
    map["Status"] = _status;
    map["TimeStamp"] = _timeStamp;
    map["UserName"] = _userName;
    return map;
  }

}