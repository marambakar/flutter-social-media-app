import 'package:flutter/material.dart';
import 'package:pronz/models/Model.dart';
import 'package:pronz/screen/register/RegisterPage.dart';
import 'package:pronz/screen/register/slideDots.dart';
import 'dart:async';
import 'Slideitem.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
class First_page extends StatefulWidget {
  @override
  _first createState() => _first();
}

class _first extends State<First_page> {
  int _current = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: (5)), (Timer timer) {
      if (_current < 2) {
        _current++;
      } else {
        //go to the next page
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RegisterPage()));
        timer.cancel();
      }
      _pageController.animateToPage(_current,
          duration: Duration(microseconds: (300)), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
  _onpagechange(int index) {
    setState(() {
      _current = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[49],
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
          child: Stack(children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.horizontal,
              reverse: true,
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: _onpagechange,
              itemCount: SlideList.length,
              itemBuilder: (ctx, i) => Slideitem(i),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 120,
              right: 0,
              left: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  Container(
                    margin:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height/77),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 2; i >= 0; i--)
                          if (i == _current)
                            slideDots(true)
                          else
                            slideDots(false)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                    child: FlatButton(
                      child: Column(children: <Widget>[
                        Text(
                          LocaleKeys.JoinNow.tr(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height/77),
                        ),
                        Text(
                          LocaleKeys.Iagreetothetermsofuse.tr(),
                          style: TextStyle(
                            color: Colors.grey,
                              fontSize:MediaQuery.of(context).size.height/77
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ]),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterPage())
                        );
                      },
                      //textColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/77,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        LocaleKeys.PrivacyPolicy.tr(),
                        style: TextStyle(color: Colors.white,fontSize:MediaQuery.of(context).size.height/77 ),

                      ),
                      Text(
                        LocaleKeys.Termsofuse.tr(),
                        style: TextStyle(color: Colors.white,fontSize:MediaQuery.of(context).size.height/77),
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
