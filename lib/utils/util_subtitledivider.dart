import 'package:flutter/material.dart';
import 'package:projectflite/presentation/theme_background.dart';
import 'package:provider/provider.dart';
import '../controllers/controller_moodapp.dart';

Widget  subTitleDivider(String subtitle , BuildContext context){

  var changeMood = Provider.of<MoodsApp>(context);


  if(changeMood.isLight == true) {
    return Column(
      children: [
        Text(subtitle, style: TextStyle(
          color: Background().strongBlue(),
          fontSize: 24,
          fontFamily: 'Poppins-Bold',
        ),),
        Divider(
          color: Background().strongBlue(),
          thickness: 6,
        ),
      ],
    );
  }else{
    return Column(
      children: [
        Text(subtitle, style: TextStyle(
          color: Background().white(),
          fontSize: 24,
          fontFamily: 'Poppins-Bold',
        ),),
        Divider(
          color: Background().lightBlue(),
          thickness: 6,
        ),
      ],
    );
  }
}