
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/message_model.dart';
import 'package:pronz/models/message_models.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'attachment.dart';
import 'chatmessage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:path/path.dart' as p;
import 'package:random_string/random_string.dart' as random;
import 'package:file/local.dart';
import 'package:http/http.dart' as http;

import '';


enum RecordingState {
  UnSet,
  Set,
  Recording,
  Stopped,
}
class ChatScreen extends StatefulWidget {
  static  List<ChatMessage> messages = <ChatMessage>[];
  String filePath;
  File tempAudioFile;
  LocalFileSystem localFileSystem;
  int index;
  Post post;
  int firstID;
  int secondID;
  ChatScreen({this.post,
    this.index });
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  String _ImageLocalPath;
  File _image;
  int id;
  bool complete=false;
  IconData _recordIcon = Icons.mic_none;
  String _recordText = 'Click To Start';
  Future <message_models>conversation;
  message_models finalconversation;
  RecordingState _recordingState = RecordingState.UnSet;
  bool _isRecording = false;
  Random random = new Random();
  TextEditingController _controller = new TextEditingController();
  File fileRec=null;
  _initRecorder() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    widget.filePath = appDirectory.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString()+".mp3"
    ;
        DateTime.now().millisecondsSinceEpoch.toString()+".mp3"
        ;

   fileRec= await  new File( widget.filePath);





  }



  Future<File> loadFile() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    print(appDocDir);

    final file = File("${appDocDir.path}"+'/'+widget.filePath.split('/').last);
    //file.writeAsBytesSync(audio);
    return file;
  }




  // _startRecording() async {
  //
  //   await AudioRecorder.start(path:fileRec.path, audioOutputFormat: AudioOutputFormat.WAV);
  //
  // }

  // _stopRecording() async {
  //   // await audioRecorder.stop();
  //   await AudioRecorder.stop();
  //   // print("mus"+audioRecorder.recording.path);
  //
  // //  widget.tempAudioFile = widget.localFileSystem.file(audioRecorder.recording.path);
  //   //print("  File length: ${await widget.tempAudioFile.length()}");
  //
  //   // setState(()  {
  //   //   ChatMessage message=new ChatMessage(tempAudioFile: fileRec,);
  //   //   ChatScreen.messages.insert(0, message);
  //   //
  //   // });
  //
  //   addpos( );
  //  localAodio=true;
  // }




  void startRecord() async {


      recordFilePath = await getFilePath();

      RecordMp3.instance.start(recordFilePath, (type) {

        setState(() {});
      });
    }



  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    localAodio=true;
    addpos( );
  }



  String recordFilePath;



  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

  // Future<void> _recordVoice() async {
  //   if (await AudioRecorder.hasPermissions) {
  //  // await _initRecorder();
  //
  //     await startRecord();
  //     _recordingState = RecordingState.Recording;
  //     _recordIcon = Icons.stop;
  //     _recordText = 'Recording';
  //   } else {
  //     Scaffold.of(context).hideCurrentSnackBar();
  //     Scaffold.of(context).showSnackBar(SnackBar(
  //       content: Text('Please allow recording from settings.'),
  //     ));
  //   }
  // }

  // Future<void> _onRecordButtonPressed() async {
  //   switch (_recordingState) {
  //     case RecordingState.Set:
  //       await _recordVoice();
  //       break;
  //
  //     case RecordingState.Recording:
  //       await  stopRecord();
  //       _recordingState = RecordingState.Stopped;
  //       _recordIcon = Icons.fiber_manual_record;
  //       _recordText = 'Record new one';
  //       break;
  //
  //     case RecordingState.Stopped:
  //       await _recordVoice();
  //       break;
  //
  //     case RecordingState.UnSet:
  //       Scaffold.of(this.context).hideCurrentSnackBar();
  //       Scaffold.of(this.context).showSnackBar(SnackBar(
  //         content: Text('Please allow recording from settings.'),
  //       ));
  //       break;
  //   }
  // }

  var _playerSubscription;
  bool _isPlaying;
  String _playerTxt;
  int second;
  final TextEditingController _chatController = new TextEditingController();

  void _handleSubmit(String text) {
    _chatController.clear();
    Message_model msg=new Message_model(text:text);
    ChatMessage message = new ChatMessage(msg: msg);
    setState(() {
      ChatScreen.messages.insert(0, message);
    });
  }


  _imgFromCamera() async {

    _image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    ChatMessage message = new ChatMessage(imgPath:_image);

    setState(() {
      ChatScreen.messages.insert(0, message);
    });

  }

  @override
  void initState() {
    super.initState();
 print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" + Splash_Screen.idstatic.toString() + widget.index.toString());
    print("thissss the id of serrr" + widget.index.toString());
    MyApp.checkanotheruser=widget.index;
   print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
   MyApp.checkdisplay=1;

   print("theeee checkkk" + MyApp.checkdisplay.toString());

   if(!MyApp.streamController.isClosed){
     MyApp.streamController.stream.listen((data) {
       if(this.mounted){

         setState(() {

           print("data value $data");
           conversation = gitConversation(Splash_Screen.idstatic ,widget.index )    .then((value) {
             finalconversation= value;
           });
         });
       }

     });
   }



    print(")))))))))))))" + widget.index.toString());
    second = widget.index;
   // gitConversation();
    if(this.mounted){    setState(() {
      conversation = gitConversation(Splash_Screen.idstatic,widget.index)
          .then((value) {
        finalconversation= value;
      });
      //     .
      // then((value) {
      //   print("******************************************");
      //   finalconversation= value;
      //   print(finalconversation.messages.length);
      //   setState(() {
      //     complete = true;
      //     print("this is he change" + complete.toString());
      //     // for(int i= 0 ; i<finalconversation.messages.length ; i++){
      //     //
      //     //   ChatScreen.messages.add(new ChatMessage(text: finalconversation.messages[i].text,NameUser: finalconversation.messages[i].senderID,));
      //     // }
      //
      //  });
    });}

      print("here the conversation" + conversation.toString());
   // });


    // AudioRecorder.hasPermissions.then((hasPermision) {
    //   if (hasPermision) {
    //     _recordingState = RecordingState.Set;
    //     _recordIcon = Icons.mic;
    //     _recordText = 'Record';
    //   }
    // });

  }
  void initailize(){

  }
  bool chat=false;
  bool local=false;
  bool localAodio=false;
  Message_model loc;
  Message_model   loc2;
  List<ChatMessage> locMass=new List();
  Widget _chatEnvironment() {

    return IconTheme(
        data: new IconThemeData(color: Colors.greenAccent),
        // child: new Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Stack(children: [

          Container(

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                // border: Border.all(
                //
                //   width: 1,
                //   color: Color_green,
                // ),
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10,right: 10),

              child: Row(children: [
                new Flexible(
                  child: new TextField(
                    maxLines: 3,
                    minLines: 2,
                    onChanged: (value)
                    {
                      loc2=new Message_model(text:value,senderID: Splash_Screen.idstatic );
                    },

                    decoration: new InputDecoration.collapsed(
                        hintText: "Starts typing ..."),
                    controller: _chatController,
                    //onSubmitted: _handleSubmit,
                  ),),

                new IconButton(
                    icon: new Icon(
                      Icons.send,
                      //   textDirection: TextDirection.rtl,
                    ),
                    onPressed: () async {
                      //   await getdatafromsf();
                      print("_chatController.text"+_chatController.text.toString());
                      if(!_chatController.text.isEmpty)
                        {
                   var res=await   Post_message(38);
                   // if (res.statusCode == 200) {
                   //   Message_model mass=   Message_model.fromJson(json.decode(res.body)['data']);
                   // }
                      setState(() {
                        _handleSubmit(_chatController.text);
                        chat=false;
                        print("Nivvvvvvvvvvvvv"+_chatController.text);
                        loc=loc2;
                        local=true;
                      // locMass.insert( locMass.length, new   ChatMessage(msg: loc),);
                       finalconversation.messages.insert(0,loc);

                      });}
                      else{
                        local=false;
                      }

                    } ),

              ],)

          )



        ],)


      // ),
    );


  }



  @override
  Widget build(BuildContext context) {
    print(widget.index.toString() + "indexxxxxxxxxxxxxxxxxxxx");
    return
      Scaffold(
      body:
        //  complete == true ?

          Container(
          //  height: 200,

            child:  FutureBuilder (
                  future: Future.wait([
                    conversation,
                  ]),

                builder: (context, snapshot) {


                  //  print(conversation.messages.length.toString());
                    print("has"+snapshot.hasData.toString());
                 return   Container(
                        height: MediaQuery.of(context).size.height,
                   child: (snapshot.hasData)?

                      Container(

                        decoration: BoxDecoration(color: Colors.grey[300]),
                        child: new Column(
                          children: <Widget>[
                            new Flexible(

                              child: ListView.builder(

                                 // padding: new EdgeInsets.all(8.0),
                                  reverse: true,
                                  itemCount:finalconversation.messages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {

                                    return
                                       ChatMessage(msg:finalconversation.messages[index]);


                                  }

                              ),
                            ),
                        //     locMass.length!=0?
                        //
                        // //   new   ChatMessage(msg: loc):Container(),
                        //
                        //
                        //    Flexible(
                        //
                        //       child: ListView.builder(
                        //
                        //
                        //       itemCount:locMass.length,
                        //       itemBuilder:
                        //       (BuildContext context, int index) {
                        //
                        //       return
                        //       locMass[index];
                        //
                        //
                        //       }
                        //
                        //       ),
                        //     ):Container(),

                            new Divider(
                              height: 1.0,
                            ),
                            new Container(

                              decoration: new BoxDecoration(
                                color: Theme.of(context).cardColor,
                              ),
                              child: _chatEnvironment(),
                            ),


                          ],
                        ),


    ) : Container(),
    );
  })));
  }

  @override
  void dispose() {

    super.dispose();
    MyApp.streamController.close();
    MyApp.streamController = new StreamController<bool>();

    MyApp.checkdisplay = 2;
    print("the stream closed");
    _recordingState = RecordingState.UnSet;

  }
  Future<http.Response>Post_message(int user_id) async {
    print("inside the post func");
   // getdatafromsf();
    print("gettt now ");
    print(id);
    return http.post(
      Uri.parse('http://bronze.fingerprint.ml/api/Message/addMessge/2143'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
     //   'MessageID' : 1,
        'ReceiverID' : widget.index,
        'SenderID' :Splash_Screen.idstatic,// id,
        'Text' : _chatController.text,
        'Seen' : 1,
        'HasMedia' : 2 ,
        'Status' : 1 ,

      }),

    );
}
// set instead of function splash,id
 // getdatafromsf()  async {
 //    SharedPreferences data = await SharedPreferences.getInstance();
 //    id = data.getInt('id');
 //    print("inside the get ");
 //    print(id);
 //  }


  void addpos() async
  {
    print("FileNivo"+ recordFilePath.split("/").last);




    var req = http.MultipartRequest('POST', Uri.parse("http://bronze.fingerprint.ml/api/Post/addPostWithMedia"));

    req.fields['UserID']="38" ;
    req.files.add(
        http.MultipartFile.fromBytes(
            'picture',
            File(recordFilePath).readAsBytesSync(),
            filename:recordFilePath.split("/").last
        )
    );
    var r = await req.send();
    var response = r.stream.bytesToString();
    print("response"+response.toString());
  }
  Future <message_models> gitConversation(int userid , int anotherid) async {
    print("+++++++++++++++++++++++" + widget.index.toString() + Splash_Screen.idstatic.toString());
    // we should reblace 38 with splashscreen.id
    int id = Splash_Screen.idstatic;
    int id2 = widget.index;
    final String Api = "http://bronze.fingerprint.ml/api/Message/getConversation/7?firstID=$id&secondID=$id2";
    var result = await http.get(Uri.parse(Api));
    if(result.statusCode == 200 )
    {
      json.decode(result.body)['dataList'];
      print("the leeength" + message_models.fromJson(json.decode(result.body)['dataList']).messages.length.toString());
    }
    return message_models.fromJson(json.decode(result.body)['dataList']);
  }
}
