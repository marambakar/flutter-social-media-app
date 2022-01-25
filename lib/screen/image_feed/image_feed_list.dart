import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/data/feed_data.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/screen/image_feed/image_feed_detail.dart';

class FeedImagePage extends StatefulWidget {
Post post;


     FeedImagePage({this.post});
  @override
  FeedImagePageBody createState() => FeedImagePageBody();
}






class FeedImagePageBody extends State<FeedImagePage> {


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

                      return  FeedImageDetail(imgPath: widget.post.medias[index].url,post:widget.post);

                    }
                ), //ListView,
              ),
        );
  }


}

