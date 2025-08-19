import 'package:flutter/cupertino.dart';
import 'package:projectflite/models/model_group.dart';

class ControllerGroup extends ChangeNotifier{

String chooseVehicle = "";


void addGroup(String vehicle){

  ModelGroup(0, ch_vehicle: vehicle);

  chooseVehicle = vehicle;

  notifyListeners();

}



}