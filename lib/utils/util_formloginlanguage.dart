

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_peoples.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_languageapp.dart';
import '../l10n/app_localizations_en.dart';
import '../l10n/app_localizations_es.dart';
import '../l10n/app_localizations_pt.dart';


Widget formsLoginLanguage(BuildContext context , TextEditingController controllerName , TextEditingController controllerYears ) {

  String language = Provider.of<ChangeLanguage>(context).chooseLanguage;

  if (language == "pt") {
    return Column(
      children: [
        form(
          AppLocalizationsPt().textFormLoginLogin,
          AppLocalizationsPt().textFormLoginPassword,
          context,
          controllerName,
          controllerYears
        ),
      ],
    );
  } else if (language == "en") {
    return Column(
      children: [
        form(
          AppLocalizationsEn().textFormLoginLogin,
          AppLocalizationsEn().textFormLoginPassword,
          context,
            controllerName,
            controllerYears
        ),
      ],
    );
  } else {
    return Column(
      children: [
        form(
          AppLocalizationsEs().textFormLoginLogin,
          AppLocalizationsEs().textFormLoginPassword,
          context,
            controllerName,
            controllerYears
        ),
      ],
    );
  }
}

Widget form(
  String login,
  String password,
  BuildContext context,
  TextEditingController controlName,
  TextEditingController controlYear,
) {

  var consumer = Provider.of<ControllerPeoples>(context);

  return Column(
    children: [
      TextFormField(decoration: InputDecoration(hintText: login) , controller: controlName,),
      SizedBox(height: 20),
      TextFormField(decoration: InputDecoration(hintText: password) , controller:  controlYear,),
    ],
  );
}





