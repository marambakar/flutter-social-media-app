import 'dart:ui';
import 'package:pronz/models/comment.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/models/media.dart';
import 'package:pronz/models/poll.dart';

class Post {
  int _postID;
  int _userID;
  int type;
  int _likes;
  int _disLikes;
  String _pContent;

  set postID(int value) {
    _postID = value;
  }

  String _date;
  String _location;
  int _haveMedia;
  String _title;
  int _havePoll;
  String _lat;
 String _lng;
  int _status;
  List<Media> _medias;
 String _hash;

  String get hash => _hash;

  set hash(String value) {
    _hash = value;
  } // String imagePath;

  Color coler;
  Color nextcoler;
   bool isfind;
   String imgback;
  List<Comment> _Comments = [];

  List<dynamic> _polls;
  String _link;

  String get link => _link;

  set link(String value) {
    _link = value;
  }

  dynamic _picture;

  int get postID => _postID;
  int get userID => _userID;
  int get likes => _likes;
  int get disLikes => _disLikes;
  String get pContent => _pContent;
  String get date => _date;
  String get location => _location;
  int get haveMedia => _haveMedia;
  String get title => _title;
  int get havePoll => _havePoll;
  String get lat => _lat;
 String get lng => _lng;
  int get status => _status;
  int get types => _status;
  List<Media> get medias => _medias;
  List<Comment> get Comments=>_Comments;
  List<dynamic> get polls => _polls;
  dynamic get picture => _picture;
  Post({
    int postID,
    int userID,
    int likes,
    int disLikes,
    String pContent,
    String date,
    String location,
    int haveMedia,
    String title,
    int havePoll,
   String lat,
    String  lng,
    int type,
    int status,
    List<Media> medias,
    String imagePath,
    Color coler,
    Color nextcoler,
    List<Comment> comments,
    bool isfind,
    List<Poll> polls,
    dynamic picture,
    String hash,
    String link,
    String imgback,
  }) {
    _postID = postID;
    _userID = userID;
    _likes = likes;
    _disLikes = disLikes;
    _pContent = pContent;
    _date = date;
    _location = location;
    _haveMedia = haveMedia;
    _title = title;
    _havePoll = havePoll;
    _lat = lat;
    _lng = lng;
    this.type = type;
    _status = status;
    _medias = medias;
   // this.imagePath = imagePath;
    this.coler = coler;
    this.nextcoler = nextcoler;
    this._Comments = comments;
    this.isfind=isfind;
    _polls = polls;
    _picture = picture;
    _hash=hash;
    _link=link;
    this.imgback=imgback;

  }

  set medias(List<Media> value) {
    _medias = value;
  }

  Post.fromJson(dynamic json) {
    _postID = json["PostID"];
    _userID = json["UserID"];
    _likes = json["Likes"];
    _disLikes = json["DisLikes"];
    _pContent = json["PContent"];
    _date = json["Date"];
    _location = json["Location"];
    _haveMedia = json["HaveMedia"];
    _title = json["Title"];
    _havePoll = json["HavePoll"];
    _lat = json["Lat"];
    _lng = json["Lng"];
    _status = json["Status"];
    if (json["Medias"] != null) {
      _medias = [];
      json["Medias"].forEach((v) {
        _medias.add(Media.fromJson(v));
      });
    }
    if (json["Comments"] != null) {
      _Comments = [];
      json["Comments"].forEach((v) {
        _Comments.add(Comment.fromJson(v));
      });
    }
    if (json["Polls"] != null) {
      _polls = [];
      json["Polls"].forEach((v) {
        _polls.add(Poll.fromJson(v));
      });
    }
    _picture = json["picture"];

   _hash = json["HashTag"];

      _link=json["Link"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["PostID"] = _postID;
    map["UserID"] = _userID;
    map["Likes"] = _likes;
    map["DisLikes"] = _disLikes;
    map["PContent"] = _pContent;
    map["Date"] = _date;
    map["Location"] = _location;
    map["HaveMedia"] = _haveMedia;
    map["Title"] = _title;
    map["HavePoll"] = _havePoll;
    map["Lat"] = _lat;
    map["Lng"] = _lng;
    map["Status"] = _status;
    if (_medias != null) {
      map["Medias"] = _medias.map((v) => v.toJson()).toList();
    }
    if (_Comments != null) {
      map["Comments"] = _Comments.map((v) => v.toJson()).toList();
    }

    if (_polls != null) {
      map["Polls"] = _polls.map((v) => v.toJson()).toList();
    }
    map["picture"] = _picture;

      map["HashTag"]=_hash;

        map["Link"]=_link;


    return map;
  }

  set userID(int value) {
    _userID = value;
  }

  set likes(int value) {
    _likes = value;
  }

  set disLikes(int value) {
    _disLikes = value;
  }

  set pContent(String value) {
    _pContent = value;
  }

  set date(String value) {
    _date = value;
  }

  set location(String value) {
    _location = value;
  }

  set haveMedia(int value) {
    _haveMedia = value;
  }

  set title(String value) {
    _title = value;
  }

  set havePoll(int value) {
    _havePoll = value;
  }

  set lat(String value) {
    _lat = value;
  }

  set lng(String value) {
    _lng = value;
  }

  set status(int value) {
    _status = value;
  }

  set Comments(List<Comment> value) {
    _Comments = value;
  }

  set picture(dynamic value) {
    _picture = value;
  }

  set polls(List<dynamic> value) {
    _polls = value;
  }
}
