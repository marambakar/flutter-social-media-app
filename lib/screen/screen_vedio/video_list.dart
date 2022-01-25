import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/screen/screen_vedio/VidieoDemo.dart';

class VedioListPage extends StatefulWidget {
  Post post;


  VedioListPage({this.post});
  @override
  VedioListPageBody createState() => VedioListPageBody();
}






class VedioListPageBody extends State<VedioListPage> {


  @override
  initState() {
    super.initState();
    setState(() {
    });

  }
  List <Color> col;



  double widthscreen,heightscreen;
  @override
  Widget build(BuildContext context) {

    print("NIVOOOOOOOOOOOOOOOOOO"+widget.post.medias[0].url);


    widthscreen= MediaQuery.of(context).size.width;
    heightscreen= MediaQuery.of(context).size.height;

    return Scaffold(
      body:   Container(
        height:heightscreen,
        color: Colors.black54,
          child: ListView.builder(

              scrollDirection: Axis.vertical,
              itemCount: widget.post.medias.length,
              itemBuilder: (BuildContext context, int index) {

                return  VidieoDemo(VidioPath: widget.post.medias[index].url,post:widget.post);

              }
          ),

        //ListView,
      ),
    );
  }


}
