import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_moodapp.dart';



AssetImage  backgroundImage( BuildContext context){

  var changeMood = Provider.of<MoodsApp>(context);

  if(changeMood.isLight == true){
    return AssetImage('assets/LightMode.png');
  }else{
    return AssetImage('assets/DarkMode.png');
  }
}


AssetImage  backgroundImageLogin( BuildContext context){

  var changeMood = Provider.of<MoodsApp>(context);

  if(changeMood.isLight == true){
    return AssetImage('assets/Fundo.png');
  }else{
    return AssetImage('assets/DarkMode.png');
  }
}