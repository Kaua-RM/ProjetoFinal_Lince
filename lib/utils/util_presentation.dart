import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_moodapp.dart';
import 'package:projectflite/presentation/theme_background.dart';
import 'package:provider/provider.dart';



Widget iconLightMode(BuildContext context ){

  var changeMood = Provider.of<MoodsApp>(context);



  if(changeMood.isLight == false){
   return IconButton(onPressed: () => changeMood.setPreferences(changeMood.isLight), icon: Icon(Icons.dark_mode) , color: Background().white(),);
  }else{
    return IconButton(onPressed: () => changeMood.setPreferences(changeMood.isLight), icon: Icon(Icons.light_mode) , color: Background().orangeYellow(),);
  }

}