
class Option {
  int _optionID;
  int _pollID;
  String _text;
  double _votes;


  set optionID(int value) {
    _optionID = value;
  }

  int _status;

  int get optionID => _optionID;
  int get pollID => _pollID;
  String get text => _text;
  double get votes => _votes;
  int get status => _status;

  Option({
      int optionID, 
      int pollID, 
      String text, 
     double votes,
      int status,
   String optnumber
  }){
    _optionID = optionID;
    _pollID = pollID;
    _text = text;
    _votes = votes;
    _status = status;

}

  Option.fromJson(dynamic json) {
    _optionID = json["OptionID"];
    _pollID = json["PollID"];
    _text = json["Text"];
    _votes = json["Votes"];
    _status = json["Status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if(_optionID!=null)
      map["OptionID"] = _optionID;
    map["PollID"] = _pollID;
    map["Text"] = _text;
    map["Votes"] = _votes;
    map["Status"] = "1";
    return map;
  }

  set pollID(int value) {
    _pollID = value;
  }

  set text(String value) {
    _text = value;
  }

  set votes(double value) {
    _votes = value;
  }

  set status(int value) {
    _status = value;
  }
}