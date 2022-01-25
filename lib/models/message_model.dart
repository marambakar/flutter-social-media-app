class Message_model {
  int _messageID;
  int _receiverID;
  int _senderID;
  String _text;
  int _seen;
  String _date;
  int _hasMedia;

  set messageID(int value) {
    _messageID = value;
  }

  int _status;

  int get messageID => _messageID;
  int get receiverID => _receiverID;
  int get senderID => _senderID;
  String get text => _text;
  int get seen => _seen;
  String get date => _date;
  int get hasMedia => _hasMedia;
  int get status => _status;

  Message_model({
      int messageID, 
      int receiverID, 
      int senderID, 
      String text, 
      int seen, 
      String date, 
      int hasMedia, 
      int status}){
    _messageID = messageID;
    _receiverID = receiverID;
    _senderID = senderID;
    _text = text;
    _seen = seen;
    _date = date;
    _hasMedia = hasMedia;
    _status = status;
}

  Message_model.fromJson(dynamic json) {
    _messageID = json["MessageID"];
    _receiverID = json["ReceiverID"];
    _senderID = json["SenderID"];
    _text = json["Text"];
    _seen = json["Seen"];
    _date = json["Date"];
    _hasMedia = json["HasMedia"];
    _status = json["Status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["MessageID"] = _messageID;
    map["ReceiverID"] = _receiverID;
    map["SenderID"] = _senderID;
    map["Text"] = _text;
    map["Seen"] = _seen;
    map["Date"] = _date;
    map["HasMedia"] = _hasMedia;
    map["Status"] = _status;
    return map;
  }

  set receiverID(int value) {
    _receiverID = value;
  }

  set senderID(int value) {
    _senderID = value;
  }

  set text(String value) {
    _text = value;
  }

  set seen(int value) {
    _seen = value;
  }

  set date(String value) {
    _date = value;
  }

  set hasMedia(int value) {
    _hasMedia = value;
  }

  set status(int value) {
    _status = value;
  }
}