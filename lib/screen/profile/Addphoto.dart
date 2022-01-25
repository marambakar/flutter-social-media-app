import 'dart:developer';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pronz/config.dart';

import 'package:pronz/data/feed_data.dart';
import 'package:pronz/models/feed_model.dart';

import 'package:http/http.dart' as http;
import 'package:pronz/models/post.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class Addphoto extends StatefulWidget {

  Addphoto();
  _addphoto createState() => _addphoto();
}

class _addphoto extends State {
  File imageFile;
  File videoFile;
  String textfill;
  double widthscreen, heightscreen;
 // VideoPlayerController _controller;

  Post newPost=new Post();
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      imageFile = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      imageFile = image;
    });
  }

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  ChewieController chewieController;




  Future getVideo() async {
    Future<File> _videoFile =
    ImagePicker.pickVideo(source: ImageSource.gallery);
    _videoFile.then((file) async {
      setState(() {
        videoFile = file;
        // _controller = VideoPlayerController.file(videoFile);
        //
        // // Initialize the controller and store the Future for later use.
        //
        // // Use the controller to loop the video.
        // _controller.setLooping(true);



        _controller = VideoPlayerController.file(
            videoFile);
        _initializeVideoPlayerFuture=_controller.initialize();
        //   _controller.setLooping(true);
        // _controller.setVolume(1.0);
        chewieController = ChewieController(
          videoPlayerController: _controller,
          aspectRatio: 100/50,
          autoPlay: true,
          looping: true,);
      });
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.adjust),
                    title: new Text('Vedio'),
                    onTap: () {
                      getVideo();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;

    return
        SingleChildScrollView(
          child: context.locale==Locale('en')?

          Container(
              color: null,
              height: heightscreen*0.75,
              decoration: BoxDecoration(
                color: Color_green,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(60.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            try {
                              Navigator.pop(context); //close the popup
                            } catch (e) {}
                          },
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: heightscreen / 8.55,
                          width: widthscreen / 3.75,
                          decoration: BoxDecoration(
                            color: greenphotoBlack,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(60.0),
                              bottomLeft: Radius.circular(90.0),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              // setState(() {
                              //   feeds.last.type = 2;
                              //   feeds.add(new FeedModel(
                              //     createdAt: "lala",
                              //     imagePath: imageFile.path,
                              //     date: new DateTime.now().toString(),
                              //     text: textfill,
                              //     type: 3,
                              //    coler: Colors.cyan,
                              //   ));
                              //
                              //   try {
                              //     Navigator.pop(context); //close the popup
                              //   } catch (e) {}
                              // });
                                 if(imageFile!=null)
                                   {
                                     addpos(imageFile);
                                   }
                                 else
                                 {
                                   addpos(videoFile);
                                 }

                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                        textAlign: TextAlign.start,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        expands: true,
                        decoration: InputDecoration(
                          hintText:   LocaleKeys.hintAddphoto.tr(),
                          hintStyle:
                              TextStyle(color: Colors.white54, fontSize: 24),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          print("The value entered is : $value");
                         textfill = value;


                        },
                      )),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      child: Container(
                        child: imageFile != null
                            ? Image.file(imageFile)
                       :videoFile!=null?
                     // VideoPlayer(_controller)
                     Chewie(
                        controller: chewieController,
                                 )
                        :Text( LocaleKeys.showved.tr())

                        // decoration: BoxDecoration(
                        //
                        //   image: DecorationImage(image:AssetImage('images/OIP (19).jfif'),fit: BoxFit.cover  ),
                        //
                        // ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            Container(
                              width: widthscreen/6,
                              height: heightscreen/9,
                              child:     IconButton(
                                  icon:Image.asset("images/cam2.png"),
                                  onPressed: () {
                                    _showPicker(context);
                                  }
                                // _getFromGallery
                                // _getFromCamera();

                              ),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: widthscreen,
                    height: heightscreen / 30,
                  )
                ],
              )): Container(
              color: null,
              height: heightscreen*0.75,
              decoration: BoxDecoration(
                color: Color_green,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            try {
                              Navigator.pop(context); //close the popup
                            } catch (e) {}
                          },
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: heightscreen / 8.55,
                          width: widthscreen / 3.75,
                          decoration: BoxDecoration(
                            color: greenphotoBlack,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60.0),
                              bottomRight: Radius.circular(90.0),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              // setState(() {
                              //   feeds.last.type = 2;
                              //   feeds.add(new FeedModel(
                              //     createdAt: "lala",
                              //     imagePath: imageFile.path,
                              //     date: new DateTime.now().toString(),
                              //     text: textfill,
                              //     type: 3,
                              //    coler: Colors.cyan,
                              //   ));
                              //
                              //   try {
                              //     Navigator.pop(context); //close the popup
                              //   } catch (e) {}
                              // });
                              if(imageFile!=null)
                              {
                                addpos(imageFile);
                              }
                              else
                              {
                                addpos(videoFile);
                              }

                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            textAlign: TextAlign.start,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            expands: true,
                            decoration: InputDecoration(
                              hintText: LocaleKeys.hintAddphoto.tr(),
                              hintStyle:
                              TextStyle(color: Colors.white54, fontSize: 24),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              print("The value entered is : $value");
                              textfill = value;


                            },
                          )),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      child: Container(
                          child: imageFile != null
                              ? Image.file(imageFile)
                              :videoFile!=null?
                          // VideoPlayer(_controller)
                          Chewie(
                            controller: chewieController,
                          )
                              :Text( LocaleKeys.showved.tr())

                        // decoration: BoxDecoration(
                        //
                        //   image: DecorationImage(image:AssetImage('images/OIP (19).jfif'),fit: BoxFit.cover  ),
                        //
                        // ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            Container(
                              width: widthscreen/6,
                              height: heightscreen/9,
                              child:     IconButton(
                                  icon:Image.asset("images/cam2.png"),
                                  onPressed: () {
                                    _showPicker(context);
                                  }
                                // _getFromGallery
                                // _getFromCamera();

                              ),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: widthscreen,
                    height: heightscreen / 30,
                  )
                ],
              )),
        );

  }

  Future _getFromGallery() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = image;
    });

    // PickedFile pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.gallery,
    //   maxWidth: 1800,
    //   maxHeight: 1800,
    // );
    // if (pickedFile != null) {
    //   setState(() {
    //     imageFile = File(pickedFile.path);
    //   });
    // }
  }

  // _getFromCamera() async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //   }
  // }



  Future<File> compressFile(File file) async{
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 5,
       );
    return compressedFile;
  }

var idd;
  void addpos(File file) async
  {
   print("FileNivo"+ file.path.split("/").last);
   var fileSize =await file.length();

   SharedPreferences prefs = await SharedPreferences.getInstance();

   idd = prefs.getInt('id');



  // file=await compressFile(file);
  //  print("File size : "+fileSize.toString()+file.path.toString());

    var req = http.MultipartRequest('POST', Uri.parse("http://bronze.fingerprint.ml/api/Post/addPostWithMedia"));
    if(textfill!=null)
      {
        req.fields['PContent']=textfill.toString();
      }

    req.fields['UserID']=idd.toString();
    req.fields['Status'] ="1";
    req.files.add(
        http.MultipartFile.fromBytes(
            'picture',
            File(file.path).readAsBytesSync(),
            filename: file.path.split("/").last
        )
    );
    var r = await req.send();
    var response = r.stream.bytesToString();
    print("response vedeo"+response.toString());
  }
}
