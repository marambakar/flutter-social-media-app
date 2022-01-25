import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pronz/widget/Attachment_D.dart';

import 'add_chat.dart';
import 'chatmessage.dart';

class Attachment extends StatefulWidget {
 File image;
 static ChatMessage cha=new ChatMessage();
  _addAttachment createState() => _addAttachment();
}

class _addAttachment extends State<Attachment> {
  String _ImageLocalPath;


  _imgFromCamera() async {
   widget.image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);



     if(widget.image!=null)
     {
       Attachment.cha = new ChatMessage(imgPath: widget.image);
       ChatScreen.messages.insert(0, Attachment.cha);

     }



  }


    _imgFromGallery() async {
     widget.image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

      if(widget.image!=null)
      {
        Attachment.cha = new ChatMessage(imgPath: widget.image);
        ChatScreen.messages.insert(0, Attachment.cha);
      }



  }

  double widthscreen, heightscreen;
  String textfill;
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      decoration: BoxDecoration(
        color: Colors.green[400],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(60.0),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: heightscreen / 8.55,
              width: widthscreen / 3.75,
              decoration: BoxDecoration(
                color: Colors.black54,
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
                  Navigator.pop(context); //close the popup
                },
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                  child: ListView(
                children: <Widget>[
                  AttD(
                    text: "Camera",
                    icon: Icons.camera_alt_outlined,
                    method: () {

                               setState(() {
                                 _imgFromCamera();
                                 Navigator.pop(context);
                               });


                    },
                  ),
                  Divider(color: Colors.black),
                  AttD(
                    text: "Photo & Video Library",
                    icon: Icons.photo,
                    method: () {

                      setState(() {
                        _imgFromGallery();
                        Navigator.pop(context);
                      });



                    },
                  ),
                  Divider(color: Colors.black),
                  AttD(
                    text: "Document",
                    icon: Icons.assignment_sharp,
                    method: () {
                           setState(() {
                             _imgFromGallery();
                             Navigator.pop(context);
                           });



                    },
                  ),
                  Divider(color: Colors.black),
                  AttD(
                    text: "Location",
                    icon: Icons.location_on_outlined,
                    method: () {},
                  ),
                  Divider(color: Colors.black),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
