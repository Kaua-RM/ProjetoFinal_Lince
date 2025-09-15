import 'package:flutter/material.dart';

class ControllerDate extends ChangeNotifier{

   String dateInit = "";

   void setDate(String date){
     dateInit = date;
     notifyListeners();
   }

}