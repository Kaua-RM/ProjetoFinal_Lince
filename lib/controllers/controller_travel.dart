import 'package:flutter/material.dart';
import 'package:projectflite/models/model_people.dart';
import 'package:projectflite/models/model_pitStop.dart';
import 'package:projectflite/models/model_travel.dart';

class ControllerTravel extends ChangeNotifier {
  List<ModelTravel> travels = [];

  void setNewTravel(
    String title,
    String DateInit,
    String DateEnd,
    String typeVei,
    List<ModelPitstop> pitstops,
    List<ModelPeople> peoples,
  ) {
    travels.add(
      ModelTravel(
        0,
        title: title,
        initDate: DateInit,
        endDate: DateEnd,
        pitstops: pitstops,
        peoples: peoples,
        typeVei: typeVei,
      ),
    );
    notifyListeners();
  }
}
