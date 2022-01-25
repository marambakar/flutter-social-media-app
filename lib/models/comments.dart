import 'package:pronz/models/comment.dart';

class Comments {
  List<Comment> _coms;

  Comments({
    List<Comment>coms
  })
  {
    this._coms = coms;
  }
  List<Comment> get comen => _coms;
  set posts(List<Comment> coments) => _coms = coments;

  factory Comments.fromJson(List<dynamic> json) => Comments(
      coms: List<Comment>.from(json.map((x) => Comment.fromJson(x))));
}