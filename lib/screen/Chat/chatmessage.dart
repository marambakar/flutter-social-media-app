
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/message_model.dart';
import 'package:pronz/screen/Splash_Screen.dart';


const String _name = "Customer";

class ChatMessage extends StatefulWidget {
  //final String text;

  // File imgPath;
  File imgPath;
  String tempAudioFile;
  Function method1,method2;
  //AudioPlayer audioPlayer =new  AudioPlayer();
  String audioPath=null;

  int NameUser;

  Message_model msg;
  //FlutterAudioRecorder audioRecorder;

// constructor to get text from textfield
  ChatMessage({this.msg, this.imgPath,this.tempAudioFile,this.NameUser});



// }
//
// class ChatMessageState extends State<ChatMessage>{




  @override
  State createState() => new ChatMessageState();
}

class ChatMessageState extends State<ChatMessage> {

  double width, hight;


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width ;
    hight = MediaQuery.of(context).size.height;
  //  print(" widget.msg.senderID"+ widget.msg.senderID.toString());
    return  widget.msg.senderID!=Splash_Screen.idstatic?


    Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              alignment: Alignment.topRight,
              child: CircleAvatar(
                child:
                Image.asset(
                  'images/pepo2.png',
                  width: 20,
                ),
                backgroundColor: Color_green,
              ),
            ),

            new Expanded (child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  new Text(_name, style: Theme.of(context).textTheme.subhead),

                  widget.imgPath!=null?
                  new Container(
                    width:width/3 ,
                    height: width/3,
                    decoration: BoxDecoration(
                      //  color: nextCo
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child:
                    Image.file(widget.imgPath),
                  )
                      :new Container(
                    // margin: const EdgeInsets.only(top: 5.0),
                    // child: new Text(text),
                  ),
                  widget.msg.text!=null?
                  new Container(
                    margin: const EdgeInsets.only(top: 7),
                    child: new Text(widget.msg.text,style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),),
                  ):
                  new Container()  ,
                  widget.tempAudioFile != null?

                  Column(
                    children: [
                      Center(
                          //child:_error != null
                          //     ?  Text("$_error",style:TextStyle(
                          //   fontSize: 10,))
                          //     : _position!=null?
                          // Text("${AudioManager.instance.info.title} lrc text: $_position",
                          //     style:TextStyle(
                          //       fontSize: 10,))
                          //     : Text("downloading",
                          //     style:TextStyle(
                          //       fontSize: 10,))
                      ),
                      Container(
                        // height: hight/9,
                        // width: width/3,
                          child:bottomPanel()
                      )
                    ],
                  )



                      :Container()

                ]
            ))

          ],
        )):





    Container(


      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.end,


        children: <Widget>[

          Expanded(
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(_name, style: Theme.of(context).textTheme.subhead),

                  widget.imgPath!=null?
                  new Container(
                    width:width/3 ,
                    height: width/3,
                    decoration: BoxDecoration(
                      //  color: nextCo
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child:
                    Image.file(widget.imgPath),
                  )
                      :new Container(
                    // margin: const EdgeInsets.only(top: 5.0),
                    // child: new Text(text),
                  ),
                  widget.msg.text!=null?
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(widget.msg.text,style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),),
                  ):
                  new Container()  ,
                  widget.tempAudioFile != null?

                  Column(
                    children: [
                      // Center(
                      //     child:_error != null
                      //         ?  Text("$_error",style:TextStyle(
                      //       fontSize: 10,))
                      //         : _position!=null?
                      //     // Text("${AudioManager.instance.info.title} lrc text: $_position",
                      //     //     style:TextStyle(
                      //     //       fontSize: 10,))
                      //     //     : Text("downloading",
                      //     //     style:TextStyle(
                      //     //       fontSize: 10,))
                      // ),
                      Container(
                        // height: hight/9,
                        // width: width/3,
                          child:bottomPanel()
                      )
                    ],
                  )



                      :Container()

                ]
            ),
          ),

          new Container(
            margin: const EdgeInsets.only(left: 16.0),
            alignment: Alignment.topRight,
            child: CircleAvatar(

              child:
              Image.asset(
                'images/panda2.png',
                width: 20,
              ),
              backgroundColor: Color_green,
            ),
          ),
        ],
      ),
    )

    ;

    // };

  }






  Future<int> play() async {
    // print("play"+audioPath);

// await audioPlayer.play(audioRecorder.recording.path,isLocal: true);

    //   await audioPlayer.play( "https://soundcloud.com/ghena-al-herek/wael-kfoury-mdalaleti-mp3",isLocal: false);


  }



  @override
  Future<void> initState()  {
    //


    // loadFile();

    // initPlatformState();
    // setupAudio();

  }

  String _platformVersion = 'Unknown';
  bool isPlaying = false;
  Duration _duration;
  Duration _position;
  double _slider;
  double _sliderVolume;
  String _error;
  num curIndex = 0;
  //PlayMode playMode = AudioManager.instance.playMode;


  var list = [
    {
      "title": "network",
      "desc": "network resouce playback",
      "url": "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.m4a",

    }
  ];


  // void setupAudio() async {
  //   List<AudioInfo> _list = [];
  //   list.forEach((item) => _list.add(AudioInfo(item["url"],
  //     title: item["title"], desc: item["desc"],
  //     // coverUrl: item["coverUrl"]
  //   )));
  //
  //   AudioManager.instance.audioList = _list;
  //   AudioManager.instance.intercepter = true;
  //   AudioManager.instance.play(auto: false);
  //
  //   await AudioManager.instance.onEvents((events, args) async {
  //     print("$events, $args");
  //     switch (events) {
  //       case   AudioManagerEvents.start:
  //         print(
  //             "start load data callback, curIndex is ${AudioManager.instance.curIndex}");
  //         _position = AudioManager.instance.position;
  //         _duration = AudioManager.instance.duration;
  //         _slider = 0;
  //         setState(() {});
  //         break;
  //       case AudioManagerEvents.ready:
  //         print("ready to play");
  //         _error = null;
  //         _sliderVolume = AudioManager.instance.volume;
  //         _position = AudioManager.instance.position;
  //         _duration = AudioManager.instance.duration;
  //         setState(() {});
  //         // if you need to seek times, must after AudioManagerEvents.ready event invoked
  //         // AudioManager.instance.seekTo(Duration(seconds: 10));
  //         break;
  //       case AudioManagerEvents.seekComplete:
  //         _position = AudioManager.instance.position;
  //         _slider = _position.inMilliseconds / _duration.inMilliseconds;
  //         setState(() {});
  //         print("seek event is completed. position is [$args]/ms");
  //         break;
  //       case  AudioManagerEvents.buffering:
  //         print("buffering $args");
  //         break;
  //       case AudioManagerEvents.playstatus:
  //         isPlaying = AudioManager.instance.isPlaying;
  //         setState(() {});
  //         break;
  //       case AudioManagerEvents.timeupdate:
  //         _position = AudioManager.instance.position;
  //         _slider = _position.inMilliseconds / _duration.inMilliseconds;
  //         setState(() {});
  //         AudioManager.instance.updateLrc(args["position"].toString());
  //         break;
  //       case AudioManagerEvents.error:
  //         _error = args;
  //         setState(() {});
  //         break;
  //       case AudioManagerEvents.ended:
  //         AudioManager.instance.next();
  //         break;
  //       case AudioManagerEvents.volumeChange:
  //         _sliderVolume = AudioManager.instance.volume;
  //         setState(() {});
  //         break;
  //       default:
  //         break;
  //     }
  //   });
  // }


  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   try {
  //     platformVersion = await AudioManager.instance.platformVersion;
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }



  Widget bottomPanel() {

    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: songProgress(),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 0),

        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
               // icon:
                //getPlayModeIcon(playMode),
                onPressed: () {
                 // playMode = AudioManager.instance.nextMode();
                  setState(() {});
                }),
            IconButton(
                iconSize: 20,
                icon: Icon(
                  Icons.skip_previous,
                  color: Colors.black,
                ),
             //   onPressed: () =>
                   // AudioManager.instance.previous()
            ),
            IconButton(
              onPressed: () async {
                // bool playing = await AudioManager.instance.playOrPause();
                // print("await -- $playing");
              },
              padding: const EdgeInsets.all(0.0),
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 20,
                color: Colors.black,
              ),
            ),
            IconButton(
                iconSize: 20,
                icon: Icon(
                  Icons.skip_next,
                  color: Colors.black,
                ),
             //   onPressed: () =>
                    //AudioManager.instance.next()
            ),
            IconButton(
                icon: Icon(
                  Icons.stop,
                  color: Colors.black,
                ),
           //     onPressed: () => //AudioManager.instance.stop()
            ),
          ],
        ),
      ),
    ]);
  }

  // Widget getPlayModeIcon(PlayMode playMode) {
  //   switch (playMode) {
  //     case PlayMode.sequence:
  //       return Icon(
  //         Icons.repeat,
  //         color: Colors.black,
  //       );
  //     case PlayMode.shuffle:
  //       return Icon(
  //         Icons.shuffle,
  //         color: Colors.black,
  //       );
  //     case PlayMode.single:
  //       return Icon(
  //         Icons.repeat_one,
  //         color: Colors.black,
  //       );
  //   }
  //   return Container();
  // }

  Widget songProgress() {
    var style = TextStyle(color: Colors.black,fontSize: 10);
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            _formatDuration(_position),
            style: style,
          ),
          Expanded(
            flex: 1,

            child: SliderTheme(
                data: SliderTheme.of(this.context).copyWith(
                  trackHeight: 2,
                  thumbColor: Colors.blueAccent,
                  overlayColor: Colors.blue,
                  thumbShape: RoundSliderThumbShape(
                    disabledThumbRadius: 5,
                    enabledThumbRadius: 5,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Colors.blueAccent,
                  inactiveTrackColor: Colors.grey,
                ),
                child: Slider(
                  value: _slider ?? 0,
                  onChanged: (value) {
                    setState(() {
                      _slider = value;
                    });
                  },
                  onChangeEnd: (value) {
                    if (_duration != null) {
                      Duration msec = Duration(
                          milliseconds:
                          (_duration.inMilliseconds * value).round());
                    //  AudioManager.instance.seekTo(msec);
                    }
                  },
                )),
          ),

          Text(
            _formatDuration(_duration),
            style: style,
          ),
        ],
      );




  }

  String _formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }

  @override
  void dispose() {
    // 释放所有资源
  //  AudioManager.instance.release();
    super.dispose();
  }
}
