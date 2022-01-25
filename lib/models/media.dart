
class Media {
  int _mediaID;
  dynamic _messageID;
  int _postID;
  String _url;
  String _kind;
  int _status;
  int _mediaType;

  int get mediaID => _mediaID;
  dynamic get messageID => _messageID;
  int get postID => _postID;
  String get url => _url;
  String get kind => _kind;
  int get status => _status;
  dynamic get mediaType => _mediaType;

  Media({
      int mediaID, 
      dynamic messageID, 
      int postID, 
      String url, 
      String kind, 
      int status, 
      int mediaType}){
    _mediaID = mediaID;
    _messageID = messageID;
    _postID = postID;
    _url = url;
    _kind = kind;
    _status = status;
    _mediaType = mediaType;
}

  Media.fromJson(dynamic json) {
    _mediaID = json["MediaID"];
    _messageID = json["MessageID"];
    _postID = json["PostID"];
    _url = json["URL"];
    _kind = json["Kind"];
    _status = json["Status"];
    _mediaType = json["MediaType"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["MediaID"] = _mediaID;
    map["MessageID"] = _messageID;
    map["PostID"] = _postID;
    map["URL"] = _url;
    map["Kind"] = _kind;
    map["Status"] = _status;
    map["MediaType"] = _mediaType;
    return map;
  }

}