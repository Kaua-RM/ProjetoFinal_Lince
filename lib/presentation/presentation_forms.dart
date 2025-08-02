import 'package:flutter/material.dart';
import 'package:projectflite/utils/util_forms.dart';
import 'package:projectflite/utils/util_presentation.dart';
import 'package:projectflite/utils/util_subtitledividerlanguage.dart';
import 'package:projectflite/utils/util_titlesLanguagens.dart';
import 'package:provider/provider.dart';
import '../controllers/controller_languageapp.dart';
import '../controllers/controller_moodapp.dart';
import '../l10n/app_localizations.dart';
import '../utils/util_backgroundimage.dart';
import '../utils/util_routesbuttons.dart';
import '../utils/util_subtitledivider.dart';
import '../utils/util_titles.dart';
import '../utils/util_topdown.dart';


class PresentationForms extends StatelessWidget{
  const PresentationForms({super.key});

  @override
  Widget build(BuildContext context) {


   return Consumer<MoodsApp>(builder: (context , change , child) => Scaffold(
     body: Container(
       padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
    image: DecorationImage(
    image: backgroundImage(context),
    fit: BoxFit.cover,
    ),
     ),
       child: ListView(
       children: [
         Column(
           spacing: 40,
           children: [
             Row(
               children: [
                 topDown(context),
                 iconLightMode(context)
               ],
             ),
             titleLanguage("form", context),
             subTitleDividerLanguage("form", context),
             Column(
               spacing: 40,
               children: [
               title(),
                 participants(context),
                 meansTransports(context),
                 pitstop(context)
               ],
             ),
             routesButtons(context)
           ],
         )
       ],
       ),
   ),
   ));
  }
}