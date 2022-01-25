import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_chat extends StatefulWidget {
  @override
  _Home_chat createState() => _Home_chat();
}

class _Home_chat extends State<Home_chat> {
  String uidd;
  String namefire;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<void> initState()  {
    super.initState();
    checkoldnewuser();
  }
  checkoldnewuser() async {
    getcheckuser();
    print("here the id");
    print(uidd);
    final result = (await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: uidd)
            .get())
        .docs;
    print(result.length);
    if (result.length == 0) {
      //it is new user
      FirebaseFirestore.instance.collection('users').doc(uidd).set({
        "id": uidd,
        "name": namefire,
      });
    } else {
      print("you are old ");
      //it is old user
    }
  }

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
    );
  }

  getcheckuser() {
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        uidd = (prefs.getString('thesigninwithgoogle'));
        namefire = (prefs.getString('namefirebase'));
        print("uidd"+uidd);
      });
    });
  }
}
