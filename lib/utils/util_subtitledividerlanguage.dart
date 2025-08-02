

import 'package:flutter/cupertino.dart';
import 'package:projectflite/l10n/app_localizations_en.dart';
import 'package:projectflite/l10n/app_localizations_es.dart';
import 'package:projectflite/utils/util_subtitledivider.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_languageapp.dart';
import '../l10n/app_localizations_pt.dart';

Widget subTitleDividerLanguage(String page, BuildContext context){

  String language =  Provider.of<ChangeLanguage>(context).chooseLanguage;

  if(language == "pt"){
    if(page == "home") {
      return subTitleDivider(
          AppLocalizationsPt().subTitleDividerHome, context);
    }else if(page == "form"){
      return subTitleDivider(
          AppLocalizationsPt().subTitleDividerForm,
          context);
    }else{
      return subTitleDivider(
          AppLocalizationsPt().subTitleDividerBook,
          context);
    }
  }else if(language == "en"){
    if(page == "home") {
      return subTitleDivider(
          AppLocalizationsEn().subTitleDividerHome, context);
    }else if(page == "form"){
      return subTitleDivider(
          AppLocalizationsEn().subTitleDividerForm,
          context);
    }else{
      return subTitleDivider(
          AppLocalizationsEn().subTitleDividerBook,
          context);
    }
  }else{
    if(page == "home") {
      return subTitleDivider(
          AppLocalizationsEs().subTitleDividerHome, context);
    }else if(page == "form"){
      return subTitleDivider(
          AppLocalizationsEs().subTitleDividerForm,
          context);
    }else{
      return subTitleDivider(
          AppLocalizationsEs().subTitleDividerBook,
          context);
    }
  }
}
