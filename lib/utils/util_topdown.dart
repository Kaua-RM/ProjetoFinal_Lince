import 'package:flutter/material.dart';
import 'package:projectflite/presentation/theme_background.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_languageapp.dart';



Widget topDown(BuildContext context){

  var changeLanguage = Provider.of<ChangeLanguage>(context);

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Row(
        spacing: 20,
        children: [
          OutlinedButton(onPressed: () => changeLanguage.setPreferences("pt"),style: OutlinedButton.styleFrom(
            backgroundColor: Background().strongBlue(),

          ), child: Text("PT" , style: TextStyle(color: Background().white() , fontSize: 8 , fontFamily: 'Poppins-Bold'), )
          ),
          OutlinedButton(onPressed: () => changeLanguage.setPreferences("en"),style: OutlinedButton.styleFrom(
              backgroundColor: Background().strongBlue()
          ), child: Text("EN" , style: TextStyle(color: Background().white() , fontSize: 8 , fontFamily: 'Poppins-Bold'),)
          ),
          OutlinedButton(onPressed: () => changeLanguage.setPreferences("es"),style: OutlinedButton.styleFrom(
              backgroundColor: Background().strongBlue()
          ), child: Text("ES" , style: TextStyle(color: Background().white() , fontSize: 8 , fontFamily: 'Poppins-Bold'),)
          ),
        ],
      ),

    ],
  );

}
