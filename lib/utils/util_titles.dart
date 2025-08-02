import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_languageapp.dart';
import 'package:projectflite/presentation/theme_background.dart';
import 'package:provider/provider.dart';
import '../controllers/controller_moodapp.dart';



Widget titles(String title , String subtitle , BuildContext context){

  var changeMood = Provider.of<MoodsApp>(context);


  return Column(
    children: [
      Text(title , style: TextStyle(
          fontSize: 40,
          color: Background().orangeYellow(),
          fontFamily: 'Poppins-Bold'
      ),),
     subTitle(subtitle, changeMood.isLight)
    ],
  );
}


Widget subTitle(String subtitle , bool islight) {
  if (islight == true) {
    return Text(subtitle, style: TextStyle(
        color: Background().strongBlue(),
        fontFamily: 'Poppins-SemiBold'
    ),);
  } else {
    return Text(subtitle, style: TextStyle(
        color: Background().white(),
        fontFamily: 'Poppins-SemiBold'
    ),);
  }
}