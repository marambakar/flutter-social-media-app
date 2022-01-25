
class Vote {
  int _userID;
  int _optionID;
  int _status;
  String _userName;
  int _pollID;

  int get userID => _userID;
  int get optionID => _optionID;
  int get status => _status;
  String get userName => _userName;
  int get pollID => _pollID;

  Vote({
      int userID, 
      int optionID, 
      int status, 
      String userName, 
      int pollID}){
    _userID = userID;
    _optionID = optionID;
    _status = status;
    _userName = userName;
    _pollID = pollID;
}

  Vote.fromJson(dynamic json) {
    _userID = json["UserID"];
    _optionID = json["OptionID"];
    _status = json["Status"];
    _userName = json["UserName"];
    _pollID = json["PollID"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["UserID"] = _userID;
    map["OptionID"] = _optionID;
    map["Status"] = _status;
    map["UserName"] = _userName;
    map["PollID"] = _pollID;
    return map;
  }

}