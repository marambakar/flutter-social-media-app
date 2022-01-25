import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pronz/config.dart';
import 'package:pronz/screen/notification_page/notification.dart';
import 'package:pronz/screen/profile/my_profile.dart';
import 'feed_screen/feed_page.dart';

class control_page extends StatefulWidget {
  @override
  control_pageState createState() => control_pageState ();
}


class control_pageState extends State<control_page> {
  bool click = true;
  int index=0;
  PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);
  List <Widget>  bb= [FeedPage(), Mynotification(), ProfilPage()];
  @override
  Widget build(BuildContext context) {
    // return PersistentTabView(
    //   context,
    //   controller: _controller,
    //   screens: _buildScreens(),
    //   items: _navBarsItems(),
    //   confineInSafeArea: true,
    //   backgroundColor: Color_green, // Default is Colors.white.
    //   handleAndroidBackButtonPress: true, // Default is true.
    //   resizeToAvoidBottomInset:
    //       true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
    //   stateManagement: true, // Default is true.
    //   hideNavigationBarWhenKeyboardShows:
    //       true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
    //   decoration: NavBarDecoration(
    //     borderRadius: BorderRadius.only(
    //         bottomLeft: Radius.circular(2), bottomRight: Radius.circular(2)),
    //     colorBehindNavBar: Colors.transparent,
    //   ),
    //   popAllScreensOnTapOfSelectedTab: true,
    //   popActionScreens: PopActionScreensType.all,
    //   itemAnimationProperties: ItemAnimationProperties(
    //     // Navigation Bar's items animation properties.
    //     duration: Duration(milliseconds: 200),
    //     curve: Curves.ease,
    //   ),
    //   screenTransitionAnimation: ScreenTransitionAnimation(
    //     // Screen transition animation on change of selected tab.
    //     animateTabTransition: true,
    //     curve: Curves.ease,
    //     duration: Duration(milliseconds: 200),
    //   ),
    //   navBarStyle:
    //       NavBarStyle.style6, // Choose the nav bar style with this property.
    // );



      return Scaffold(

          body:  _buildScreens(index),
          bottomNavigationBar:  new BottomNavigationBar(
            backgroundColor:Color_green ,
              currentIndex: index,
              onTap: (int index) {
                setState(() {
                  this.index = index;
                }
                );
                _buildScreens(index);
              },
              type: BottomNavigationBarType.fixed,
              items: [
                new BottomNavigationBarItem(
                    backgroundColor: Color_green,

                    icon: index != 0 ?
                      new Image.asset("images/panda1.png",width: 30,height: 30,)
                      //color: Colors.white,


                        :
                    new Image.asset("images/panda2.png",width: 30,height: 30,),
                      //color: Colors.white,


                    title: new Text("Route1", style: new TextStyle(
                        color: const Color(0xFF06244e), fontSize: 0.0))),
                new BottomNavigationBarItem(
                    icon: index != 1 ?      new Image.asset("images/jaras.png",width: 30,height: 30,) :     new Image.asset("images/jarasRun.png",width: 30,height: 30,),
                    title: new Text("Route2", style: new TextStyle(
                        color: const Color(0xFF06244e), fontSize: 0.0))),
                new BottomNavigationBarItem(
                    icon: index != 2 ?    new Image.asset("images/pepo.png",width: 30,height: 30,) :     new Image.asset("images/pepo2.png",width: 30,height: 30,),
                    title: new Text("Route3", style: new TextStyle(
                        color: const Color(0xFF06244e), fontSize: 0.0),)),

              ]));
    }

    Widget _buildScreens(int index) {
      // _controller.index==1?
      //     click=true
      // :click=false;
      if(index==0)
        return FeedPage();
      else if (index==1)
        return Mynotification();
      else if(index==2)
        {
          return  ProfilPage();
        }


    }

  }

//
//   List<PersistentBottomNavBarItem> _navBarsItems() {
//
//     return
//
//       [
//       PersistentBottomNavBarItem(
//
//        // Image.asset("images/panda2.png",height:30 ,),
//         icon: ImageIcon(
//           AssetImage("images/panda2.png"),
//           //color: Colors.white,
//           size: 35,
//         ),
//         //title: ("feed"),
//       activeColorPrimary: CupertinoColors.white,
//       inactiveColorPrimary: CupertinoColors.white,
//       ),
//       PersistentBottomNavBarItem(
//         // icon: Icon(
//         //   Icons.notifications_sharp,
//         //   color: Colors.white,
//         //   size: 35,
//         // ),
//       icon: click?
//       ImageIcon(
//
//         AssetImage(
//             "images/jarasRun.png"),
//         size: 35,
//      color: Colors.grey,
//
//       )
//         :
//       ImageIcon(
//
//         AssetImage(
//             "images/jaras.png"),
//         size: 35,
//        color: Colors.black,
//       ),
//
//         //title: ("Home"),
//       activeColorPrimary: Colors.transparent,
//
//         //  inactiveColorPrimary: CupertinoColors.white,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.person_rounded, color: Colors.white, size: 35),
//         //title: ("feed"),
//         activeColorPrimary: CupertinoColors.activeBlue,
//         //inactiveColorPrimary: CupertinoColors.white,
//       ),
//     ];
//   }
// }
