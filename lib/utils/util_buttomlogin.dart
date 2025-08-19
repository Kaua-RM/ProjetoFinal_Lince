import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_languageapp.dart';
import '../controllers/controller_peoples.dart';
import '../l10n/app_localizations_en.dart';
import '../l10n/app_localizations_es.dart';
import '../l10n/app_localizations_pt.dart';
import '../presentation/routes.dart';
import '../presentation/theme_background.dart';

Widget buttomLogin(BuildContext context ,  TextEditingController controlName,
    TextEditingController controlYear,){

  String language =  Provider.of<ChangeLanguage>(context).chooseLanguage;
  if(language == "pt"){
    return Buttom(AppLocalizationsPt().buttomLogin, context , controlName , controlYear);
  }else if(language == "en"){
    return Buttom(AppLocalizationsEn().buttomLogin, context , controlName , controlYear);
  }else{
    return Buttom(AppLocalizationsEs().buttomLogin, context , controlName , controlYear);
  }
}


Widget Buttom(String text , BuildContext context , TextEditingController controlName , TextEditingController controlYear){

  var consumePeople = Provider.of<ControllerPeoples>(context, listen: false);

  return ElevatedButton(
    onPressed: () {
      consumePeople.addPeople(controlName.text, controlYear.text);
      Routes.routeHome(context); } ,
    style: ElevatedButton.styleFrom(
      backgroundColor: Background().strongBlue(),
    ),
    child: Text(
      text,
      style: TextStyle(color: Background().orangeYellow(),fontSize: 18),
    ),
  );
}