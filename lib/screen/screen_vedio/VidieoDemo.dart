



import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/models/post.dart';
import 'package:video_player/video_player.dart';

class VidieoDemo extends StatefulWidget {

  String VidioPath;
  Post post;
  VidieoDemo({this.VidioPath, this.post});

  @override
  _VidieoDemoState createState() => _VidieoDemoState();
}

class _VidieoDemoState extends State<VidieoDemo> {
 VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
 ChewieController chewieController;



  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(
        widget.VidioPath);
    _initializeVideoPlayerFuture=_controller.initialize();
  //   _controller.setLooping(true);
  // _controller.setVolume(1.0);
    chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: 3/2,
        autoPlay: true,
        looping: true,);

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
        Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                )
            ),
          child: Stack(
              children:[
                FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                         if(widget.post.type==1)
                           {
                             return    Container(


                                 decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: const BorderRadius.only(
                                       bottomLeft: Radius.circular(40.0),
                                           topRight: Radius.circular(40.0),
                                     )
                                 ),
                                 // constraints: BoxConstraints.expand(
                                 //  width: MediaQuery.of(context).size.width,
                                 // ),
                                 child:  Chewie(
                                   controller: chewieController,
                                 ));
                           }
                         else  if(widget.post.type==2)
                         {
                           Container(


                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: const BorderRadius.only(
                                     bottomLeft: Radius.circular(40.0),
                                     //topRight: Radius.circular(40.0),
                                   )
                               ),
                               // constraints: BoxConstraints.expand(
                               //  width: MediaQuery.of(context).size.width,
                               // ),
                               child:  Chewie(
                                 controller: chewieController,
                               ));
                         }

                    else  if(widget.post.type==3)
                    {
                      Container(


                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(40.0),
                               bottomRight: Radius.circular(40.0),
                              )
                          ),
                          // constraints: BoxConstraints.expand(
                          //  width: MediaQuery.of(context).size.width,
                          // ),
                          child:  Chewie(
                            controller: chewieController,
                          ));
                    };

                           return    Container(


                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(40.0),
                               // topRight: Radius.circular(40.0),
                              )
                          ),
                          // constraints: BoxConstraints.expand(
                          //  width: MediaQuery.of(context).size.width,
                          // ),
                          child:  Chewie(
                            controller: chewieController,
                          ));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                // Align(
                //   alignment: Alignment.center,
                //         }else{
                //   child: RaisedButton(
                //     onPressed: (){
                //       setState(() {
                //         if(_controller.value.isPlaying){
                //           _controller.pause();
                //           _controller.play();
                //         }
                //       });
                //     },
                //     child:
                //     Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                //   ) ,
                // )

              ]
          )
        );







  }
}
