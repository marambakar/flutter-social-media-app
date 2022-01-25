import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/userupdate.dart';
import 'package:pronz/screen/register/Register3.dart';
import 'package:pronz/widget/button_done.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
class Register2 extends StatefulWidget {
  Userr temp;
  Register2({this.temp});
  @override
  _register createState() => _register();
}

class _register extends State<Register2> {
  bool find=false;
  bool isSignIn = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  FacebookLogin facebookLogin = FacebookLogin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[49],
      appBar: AppBar(
        title: Text(
          "Social App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                child: FlatButton(
                  color: Color_green,
                  textColor: Colors.white,
                  child: Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text(
                        LocaleKeys.Register.tr(),
                        style: TextStyle(fontSize: 18),
                      )),
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/33,
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: FlatButton(
                  color: Colors.white,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.apple,
                        size: 30,
                        color: Colors.grey,
                      ),
                      Text(
                        LocaleKeys.SigninwithAppleId.tr(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/55,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: FlatButton(
                  color: Colors.blue[900],
                  onPressed: () {
                    print("herrreeeeeeeeeeeeeeeee");
                    initiateFacebookLogin();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.facebookF,
                        size: MediaQuery.of(context).size.width/18,
                        color: Colors.white,
                      ),
                      Text(
                        LocaleKeys.SigninwithFacebook.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width/18,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/44,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: FlatButton(
                  color: Colors.blue[800],
                  onPressed: () {
                    googleLogin();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.google,
                        size: MediaQuery.of(context).size.width/18,
                        color: Colors.white,
                      ),
                      Text(
                        LocaleKeys.SigninwithGoogle.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width/18,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    LocaleKeys.PrivacyPolicy.tr(),
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    LocaleKeys.Termsofuse.tr(),
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/33,
              ),
              Container(
                alignment: Alignment.topRight,
                child: ButtonWidget(
                  method: () {
                    setState(() {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Register3(temp: widget.temp,)));
                    });

                  },
                ),
              ),
              // )
            ],
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




  googleLogin() async {
    final googleSignIn = GoogleSignIn();

    GoogleSignInAccount _user;
    // GoogleSignInAccount get user => _user;
    // Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    print("*********googleUser**************"+_user.email.toString());

    final googleAuth = await googleUser.authentication;
    print("*********googleAuth**************"+googleAuth.idToken.toString());
    print("*********googleAuth.accessToken**************"+googleAuth.accessToken.toString());

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    print("*********credential**************"+credential.accessToken.toString());
    print("*********credentialidToken**************"+credential.idToken.toString());

    var user=  (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    print("*********user**************"+user.uid);
    // here if the user loged in we need to save some data in database
    Save_Signingoogleid(user.uid , user.displayName);



    // notifyListeners();
  }
  Save_Signingoogleid (String Signingoogle , String namefire) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('thesigninwithgoogle', Signingoogle);
    pref.setString('namefirebase', namefire);
    print("here save Signingoogle ");
    print(Signingoogle);
  }

}
