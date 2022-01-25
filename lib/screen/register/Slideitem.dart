import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/models/media.dart';
import '../../models/Model.dart';

class Slideitem extends StatelessWidget {
  final int index;
  Slideitem(this.index);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            // shape: BoxShape.circle,

            image: DecorationImage(
                image: AssetImage(SlideList[index].imageUrl), fit: BoxFit.cover),
          ),
        ),
        Positioned(

          bottom: MediaQuery.of(context).size.height/5,
          right: MediaQuery.of(context).size.height/8,
          left: MediaQuery.of(context).size.height/8,


          child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text(SlideList[index].Title , style: TextStyle(color: Colors.white , fontSize: 25 ,  fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                SizedBox(height: 10,),
                Text(SlideList[index].discrbtion , style: TextStyle(color: Colors.white , fontSize: 18),textAlign: TextAlign.center)
              ]
           ),

        )

      ],
    );
  }
}
