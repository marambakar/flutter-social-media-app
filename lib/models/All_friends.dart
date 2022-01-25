import 'package:pronz/models/friend.dart';
class Friends{
  List<Friend> _Friends;
  Friends(
      {
        List<Friend> friends,
      }
      )
  {
    this._Friends = friends;
  }
  List<Friend> get friends => _Friends;
  set friends(List<Friend> friendss) => _Friends = friendss;

  factory Friends.fromJson(List<dynamic> json) => Friends(
      friends: List<Friend>.from(json.map((x) => Friend.fromJson(x))));
}