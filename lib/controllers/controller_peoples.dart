import 'package:flutter/cupertino.dart';
import 'package:projectflite/models/model_people.dart';

class ControllerPeoples  extends ChangeNotifier{

  List<ModelPeople> people = [];

  void addPeople(String name ,String years ){
    people.add(ModelPeople( 0, Name: name, Age: years));
    notifyListeners();
  }

}