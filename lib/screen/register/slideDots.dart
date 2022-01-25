import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pronz/models/Model.dart';
import 'package:pronz/main.dart';
import 'package:pronz/screen/register/slideDots.dart';
import 'dart:async';

class slideDots extends StatelessWidget {
  bool isActive;
  slideDots(this.isActive);
  @override
  Widget build(BuildContext context) {
    slideDots(this.isActive);
    return AnimatedContainer(
      duration: Duration(microseconds: (150)),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: isActive ? Colors.white : Colors.grey,
      ),
    );
  }
}
