
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodsApp extends ChangeNotifier{

   late SharedPreferences preferences;

  bool isLight = true;
  bool isloading = true;


  MoodsApp() {
   startMood();
  }


  startMood() async{

    await  preferencesMood();
    await  readPreferences();
  }


  Future<void> preferencesMood() async{
    preferences = await SharedPreferences.getInstance();
    await readPreferences();
  }

   readPreferences(){
    final mood = preferences.getBool("islight") ?? true;
    isLight = mood;
    notifyListeners();
  }


  setPreferences(bool mood) async{
    await preferences.setBool("islight", !mood);
    await readPreferences();
  }

}