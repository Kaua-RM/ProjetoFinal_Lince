
import 'package:flutter/cupertino.dart';
import 'package:projectflite/utils/util_titles.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_languageapp.dart';
import '../l10n/app_localizations_en.dart';
import '../l10n/app_localizations_es.dart';
import '../l10n/app_localizations_pt.dart';

Widget titleLanguage( String page, BuildContext context){

  String language =  Provider.of<ChangeLanguage>(context).chooseLanguage;

  if(language == "pt"){
    if(page == "home") {
      return titles(
          AppLocalizationsPt().titleHome, AppLocalizationsPt().subTitleHome,
          context);
    }else if(page == "form"){
      return titles(
          AppLocalizationsPt().titleForm, AppLocalizationsPt().subTitleForm,
          context);
    }else{
      return titles(
          AppLocalizationsPt().titleBook, AppLocalizationsPt().subTitleBook,
          context);
    }
  }else if(language == "en"){
    if(page == "home") {
      return titles(
          AppLocalizationsEn().titleHome, AppLocalizationsEn().subTitleHome,
          context);
    }else if(page == "form"){
      return titles(
          AppLocalizationsEn().titleForm, AppLocalizationsEn().subTitleForm,
          context);
    }else{
      return titles(
          AppLocalizationsEn().titleBook, AppLocalizationsEn().subTitleBook,
          context);
    }
  }else{
    if(page == "home") {
      return titles(
          AppLocalizationsEs().titleHome, AppLocalizationsEs().subTitleHome,
          context);
    }else if(page == "form"){
      return titles(
          AppLocalizationsEs().titleForm, AppLocalizationsEs().subTitleForm,
          context);
    }else{
      return titles(
          AppLocalizationsEs().titleBook, AppLocalizationsEs().subTitleBook,
          context);
    }
  }
}

