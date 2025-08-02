import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_languageapp.dart';
import 'package:projectflite/controllers/controller_moodapp.dart';
import 'package:projectflite/presentation/presentation_login.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => MoodsApp()),
      ChangeNotifierProvider(create: (context) => ChangeLanguage())
    ], child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: PresentationLogin(),
    ));
  }
}