import 'package:flutter/material.dart';

class ControllerDate extends ChangeNotifier{

   String dateInit = "";

   void setDate(String Date){
     dateInit = Date;
     notifyListeners();
   }

}