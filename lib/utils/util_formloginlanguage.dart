
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_languageapp.dart';
import '../l10n/app_localizations_en.dart';
import '../l10n/app_localizations_es.dart';
import '../l10n/app_localizations_pt.dart';

Widget formsLoginLanguage(BuildContext context){

  String language =  Provider.of<ChangeLanguage>(context).chooseLanguage;

  if(language == "pt"){
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              hintText: AppLocalizationsPt().textFormLoginLogin
          ),
        ),
        SizedBox(height: 20,),
        TextFormField(
          decoration: InputDecoration(
              hintText: AppLocalizationsPt().textFormLoginPassword
          ),
        ),
      ],
    );
  }else if(language == "en"){
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              hintText: AppLocalizationsEn().textFormLoginLogin
          ),
        ),
        SizedBox(height: 20,),
        TextFormField(
          decoration: InputDecoration(
              hintText: AppLocalizationsEn().textFormLoginPassword
          ),
        ),
      ],
    );
  }else{
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              hintText: AppLocalizationsEs().textFormLoginLogin
          ),
        ),
        SizedBox(height: 20,),
        TextFormField(
          decoration: InputDecoration(
              hintText: AppLocalizationsEs().textFormLoginPassword
          ),
        ),
      ],
    );
  }




}