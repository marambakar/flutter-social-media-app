import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:pronz/models/comment.dart';
import 'package:pronz/models/comments.dart';
import 'package:pronz/models/notification.dart';
import 'package:pronz/models/notificationns.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/models/posts.dart';
import 'package:pronz/models/userupdate.dart';
import 'package:pronz/util/request_type.dart';
import 'network_client.dart';




import 'package:pronz/network/network_client.dart';

class AppRequests{
  static network_client client = network_client(Client());

  static Future<List<Post>> fetchPosts(id) async {

    final response = await client.request(requestType: RequestType.GET,
        path: "api/Post/getNearbyPosts?id=$id");
         print("response.statusCode"+response.statusCode.toString());
    if (response.statusCode == 200) {
      print(response.statusCode );
     // print("#########"+Posts.fromJson(json.decode(response.body)['dataList']).posts.toString());
      if(json.decode(response.body)['dataList']==null)
      {
        return null;
      }
      // If the server returns an OK response, then parse the JSON.
      return Posts.fromJson(json.decode(response.body)['dataList']).posts;
    } else {
      print(response.body);
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }



  static Future removevote(userid,pollId) async {

    final response = await client.request(requestType: RequestType.GET,
        path: "api/Options/removeVote?UserID=$userid&PollID=$pollId");

    if (response.statusCode == 200) {
      print(response.statusCode );
     // print("#########"+Posts.fromJson(json.decode(response.body)['data']).posts.toString());
      // If the server returns an OK response, then parse the JSON.
     // return Posts.fromJson(json.decode(response.body)['data']).posts;
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }



  static Future<List<Post>> fetchHashTagPosts(hash) async {

    final response = await client.request(requestType: RequestType.GET,
        path: "api/Post/getHashtagPosts?HashTag=%23$hash");

    if (response.statusCode == 200) {
      print(response.statusCode );
      print("coco"+response.body);
     print("#########"+Posts.fromJson(json.decode(response.body)['dataList']).posts.toString());
      // If the server returns an OK response, then parse the JSON.
      return Posts.fromJson(json.decode(response.body)['dataList']).posts;
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }


  static Future<List<Post>> fetchMyPosts(id,senderid) async {

    final response = await client.request(requestType: RequestType.GET,
        path: "api/Account/getUserPosts?senderID=$senderid&userID=$id");

    if (response.statusCode == 200) {
      print(response.statusCode );
      //print("#########"+Posts.fromJson(json.decode(response.body)['dataList']).posts.toString());
      // If the server returns an OK response, then parse the JSON.
      if(json.decode(response.body)['dataList']==null)
        {
          return null;
        }
      return Posts.fromJson(json.decode(response.body)['dataList']).posts;
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }


  static Future<List<Comment>> fetchMyComment(id) async {

    final response = await client.request(requestType: RequestType.GET,
        path: "api/Account/getUserComments?userID=$id");

    if (response.statusCode == 200) {
      print(response.statusCode );
      print("#########"+Comments.fromJson(json.decode(response.body)['dataList']).comen.toString());
      // If the server returns an OK response, then parse the JSON.
      return Comments.fromJson(json.decode(response.body)['dataList']).comen;
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }


  static Future<Post> fetchPostId(id) async {

    final response = await client.request(requestType: RequestType.GET,
        path: "api/Post/getPostByID?PostID=$id");

    if (response.statusCode == 200) {
      print(response.statusCode );
      print(response.body );
      print("#########"+Post.fromJson(json.decode(response.body)['data']).toString());
      // If the server returns an OK response, then parse the JSON.
      return Post.fromJson(json.decode(response.body)['data']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }


  static Future<List<Notificationn>> fetchNotification(id) async {

    final response = await client.request(requestType: RequestType.GET,
        path: "api/Notification/getUserNotification/$id");

    if (response.statusCode == 200) {
      print(response.statusCode );
      print("#########"+Notificationns.fromJson(json.decode(response.body)['dataList']).Nots.toString());
      // If the server returns an OK response, then parse the JSON.
      return Notificationns.fromJson(json.decode(response.body)['dataList']).Nots;
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }


  static Future<Userr> fetchotherUserProfil(id) async {

    final response = await client.request(requestType: RequestType.GET,
        path: "api/Account/getOtherUserProfile/?userID=$id");

    if (response.statusCode == 200) {
      print(response.statusCode );
      print("fetchotherUserProfil"+response.body );
    //  print("#########"+Userr.fromJson(json.decode(response.body)['data']).toString());
      // If the server returns an OK response, then parse the JSON.
      if(json.decode(response.body)['data']==null)
        {
          return null ;
        }
      else
      return Userr.fromJson(json.decode(response.body)['data']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

}