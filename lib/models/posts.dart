
import 'package:pronz/models/post.dart';

class Posts {
  List<Post> _posts;

  Posts({
    List<Post>posts
  })
  {
    this._posts = posts;
    if(posts==null){
      this.posts=<Post>[];
    }
  }
  List<Post> get posts => _posts;
  set posts(List<Post> postss) => _posts = postss;

  factory Posts.fromJson(List<dynamic> json) => Posts(
      posts: List<Post>.from(json.map((x) => Post.fromJson(x))));
}