import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
class testt extends StatefulWidget {
  @override
  _testt createState() => _testt();
}

class _testt extends State<testt> {
  bool isSignIn = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
   User _user;
  FacebookLogin facebookLogin = FacebookLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("facebook login"),
      ),
      body: isSignIn
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // CircleAvatar(
            //   radius: 80,
            //   backgroundImage: NetworkImage(_user.photoURL.toString()),
            // ),
            Text(
              _user.displayName.toString(),
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            OutlineButton(
              onPressed: () {
                gooleSignout();
              },
              child: Text(
                "Logout",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      )
          : Center(
        child: OutlineButton(
          onPressed: () async {
            print("herrreeeeeeeeeeeeeeeee");
            initiateFacebookLogin();
          },
          child: Text(
            "Login with facebook",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
  Future<UserCredential> firebaseAuthWithFacebook({ FacebookAccessToken token}) async {

    AuthCredential credential= FacebookAuthProvider.credential(token.token);
    UserCredential firebaseUser = await _auth.signInWithCredential(credential);
    return firebaseUser;
  }
  void initiateFacebookLogin() async {
    final FirebaseAuth _fAuth = FirebaseAuth.instance;
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
    await facebookLogin.logIn(['email']);
    Map _userObj = {};

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        //  onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        var graphResponse = await http.get( Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult
            .accessToken.token}'));
        print("1111");
        var firebaseUser = await firebaseAuthWithFacebook(
            token: facebookLoginResult.accessToken);
        print("2222");

        // var User = await firebaseAuthWithFacebook(
        //     token: facebookLoginResult.accessToken);

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        // onLoginStatusChanged(true, profileData: profile);
        break;
        // onLoginStatusChanged(true);
        break;
    }
  }
  bool isLoggedIn = false;

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      print("looooginnnn");
      this.isLoggedIn = isLoggedIn;
    });
  }


  Future loginWithfacebook(FacebookLoginResult result) async {
    print("creeeeeeeeeeeeeeeeeeeednnnnnnnn");
    final FacebookAccessToken accessToken = result.accessToken;
    AuthCredential credential =
    FacebookAuthProvider.credential(accessToken.token);
    var a = await _auth.signInWithCredential(credential);
    setState(() {
      isSignIn = true;
      _user = a.user;
    });
  }

  Future<void> gooleSignout() async {
    await _auth.signOut().then((onValue) {
      setState(() {
        facebookLogin.logOut();
        isSignIn = false;
      });
    });
  }
}