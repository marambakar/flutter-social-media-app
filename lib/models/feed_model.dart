import 'dart:ui';



class FeedModel {
  String key;
  int type;
  String parentkey;
  String childRetwetkey;
  String description;
  String userId;
  int likeCount;
  List<String> likeList;
  int commentCount;
  int retweetCount;
  String createdAt;
  String imagePath;
  String date;
  String text;
  List<String> tags;
  List<String> replyTweetKeyList;
  Color coler;
 Color nextcoler;


 List<FeedModel> comments=[];


 //UserModel user;
  FeedModel({this.key,
    this.description,
    this.userId,
    this.likeCount,
    this.commentCount,
    this.retweetCount,
    this.createdAt,
    this.imagePath,
    this.likeList,
    this.tags,
   // this.user,
    this.replyTweetKeyList,
    this.parentkey,
    this.date,
    this.text,
    this.type,
    this.coler,
   this.nextcoler,
    this.childRetwetkey,
    this.comments});
}