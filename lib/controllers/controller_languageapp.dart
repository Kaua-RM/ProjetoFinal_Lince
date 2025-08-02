import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChangeLanguage extends ChangeNotifier{

  late SharedPreferences preferences;
  String chooseLanguage = "pt";


  ChangeLanguage(){
    startLangue();
  }

  startLangue() async{
    await  preferencesLangue();
    await  readPreferences();
  }


  Future<void> preferencesLangue() async{
    preferences = await SharedPreferences.getInstance();
    await readPreferences();
  }

  readPreferences(){
    final langue = preferences.getString("language") ?? "pt";
    chooseLanguage = langue;
    notifyListeners();
  }


  setPreferences(String langue) async{
    await preferences.setString("language", langue);
    await readPreferences();
  }

}