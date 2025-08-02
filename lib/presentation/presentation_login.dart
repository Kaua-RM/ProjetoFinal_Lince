import 'package:flutter/material.dart';
import 'package:projectflite/l10n/app_localizations.dart';
import 'package:projectflite/l10n/app_localizations_en.dart';
import 'package:projectflite/presentation/routes.dart';
import 'package:projectflite/presentation/theme_background.dart';
import 'package:projectflite/utils/util_backgroundimage.dart';
import 'package:projectflite/utils/util_formloginlanguage.dart';
import 'package:projectflite/utils/util_loginlanguage.dart';
import 'package:projectflite/utils/util_topdown.dart';

import '../utils/util_presentation.dart';



class PresentationLogin extends StatelessWidget {
  const PresentationLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: backgroundImageLogin(context),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          topDown(context),
                          iconLightMode(context),
                        ],
                      ),
                      Image.asset("assets/Logo.png"),
                      SizedBox(height: 40,),
                      formsLoginLanguage(context),
                      SizedBox(height: 50,),
                      textLogin(context),
                      SizedBox(height: 50,),
                     buttomLogin(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
