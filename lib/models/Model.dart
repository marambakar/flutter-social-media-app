import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Model {
  final imageUrl;
  final Title;
  final discrbtion;

  Model({
    @required this.imageUrl,
    @required this.Title,
    @required this.discrbtion,
  });
}

final SlideList = [
  Model(imageUrl: 'images/photo_2021-07-31_20-41-04.jpg' , Title:"LOCAL" , discrbtion: "Instantly Chat With people around you"),
  Model(imageUrl: 'images/photo_2021-07-31_20-41-12.jpg' , Title:"RELEVENT" , discrbtion: "Explore communities that interest you"),
  Model(imageUrl: 'images/photo_2021-07-31_20-40-48.jpg' , Title:"SIMPLE" , discrbtion: "Chat with others through text and images posts"),
];
