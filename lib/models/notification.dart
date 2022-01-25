
class Notificationn {
  int _nid;
  int _senderID;
  int _receiverID;
  String _senderName;
  dynamic _receiverToken;
  String _message;
  int _postID;
  String _timestamp;
  int _status;
 String _type;

  set nid(int value) {
    _nid = value;
  }

  int get nid => _nid;
  int get senderID => _senderID;
  int get receiverID => _receiverID;
  String get senderName => _senderName;
  dynamic get receiverToken => _receiverToken;
  String get message => _message;
  int get postID => _postID;
  String get timestamp => _timestamp;
  int get status => _status;
  String get type => _type;

  Notificationn({
      int nid, 
      int senderID, 
      int receiverID, 
      String senderName, 
      dynamic receiverToken, 
      String message, 
      int postID, 
      String timestamp, 
      int status, 
      dynamic type}){
    _nid = nid;
    _senderID = senderID;
    _receiverID = receiverID;
    _senderName = senderName;
    _receiverToken = receiverToken;
    _message = message;
    _postID = postID;
    _timestamp = timestamp;
    _status = status;
    _type = type;
}

  Notificationn.fromJson(dynamic json) {
    _nid = json["NID"];
    _senderID = json["SenderID"];
    _receiverID = json["ReceiverID"];
    _senderName = json["SenderName"];
    _receiverToken = json["ReceiverToken"];
    _message = json["Message"];
    _postID = json["PostID"];
    _timestamp = json["Timestamp"];
    _status = json["Status"];
    _type = json["Type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["NID"] = _nid;
    map["SenderID"] = _senderID;
    map["ReceiverID"] = _receiverID;
    map["SenderName"] = _senderName;
    map["ReceiverToken"] = _receiverToken;
    map["Message"] = _message;
    map["PostID"] = _postID;
    map["Timestamp"] = _timestamp;
    map["Status"] = _status;
    map["Type"] = _type;
    return map;
  }

  set senderID(int value) {
    _senderID = value;
  }

  set type(String  value) {
    _type = value;
  }

  set status(int value) {
    _status = value;
  }

  set timestamp(String value) {
    _timestamp = value;
  }

  set postID(int value) {
    _postID = value;
  }

  set message(String value) {
    _message = value;
  }

  set receiverToken(dynamic value) {
    _receiverToken = value;
  }

  set senderName(String value) {
    _senderName = value;
  }

  set receiverID(int value) {
    _receiverID = value;
  }
}