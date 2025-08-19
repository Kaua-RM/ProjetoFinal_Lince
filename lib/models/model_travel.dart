import 'package:projectflite/models/model_people.dart';
import 'package:projectflite/models/model_pitStop.dart';

class ModelTravel {
  int? idTravel;
  String title = "";
  var initDate;
  var endDate;
  List<ModelPitstop> pitstops;
  List<ModelPeople> peoples;
  String typeVei;

  ModelTravel(
    this.idTravel, {
    required this.title,
    required this.initDate,
    required this.endDate,
    required this.pitstops,
    required this.peoples,
    required this.typeVei,
  });
}
