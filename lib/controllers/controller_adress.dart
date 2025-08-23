import 'package:flutter/cupertino.dart';
import 'package:projectflite/models/model_adress.dart';

class ControllerAdress  extends ChangeNotifier{

  List<ModelAdress> adress = [];

  void setNewAdress(String city , String state , String country , double lat , double log) {
    adress.add(ModelAdress(city: city, state: state, country: country, lat: lat, log: log));
    notifyListeners();
  }


}