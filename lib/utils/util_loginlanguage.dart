import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectflite/l10n/app_localizations_en.dart';
import 'package:projectflite/l10n/app_localizations_es.dart';
import 'package:projectflite/utils/util_subtitledivider.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_languageapp.dart';
import '../l10n/app_localizations_pt.dart';
import '../presentation/routes.dart';
import '../presentation/theme_background.dart';

Widget textLogin(BuildContext context) {

  String language =  Provider.of<ChangeLanguage>(context).chooseLanguage;

  if(language == "pt"){
    return Text(AppLocalizationsPt().textLogin);
  }else if(language == "en"){
    return Text(AppLocalizationsEn().textLogin);
  }else{
   return Text(AppLocalizationsEs().textLogin);
  }
}

