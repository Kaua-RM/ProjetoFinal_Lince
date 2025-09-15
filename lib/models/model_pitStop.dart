
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model_adress.dart';

class ModelPitstop {
  late MarkerId idStop;
  late LatLng position;
  late var initDate = "";
  late var endDate = "";
  late String image = "";
  late int    idAdress;

  Map<String, bool> experiences = {
    "Conhecer novas culturas": false,
    "Experimentar novas culinarias": false,
    "Visitar locais historicos": false,
    "Visitar Estabelecimentos": false,
  };

  ModelPitstop({
    required this.idStop,
    required this.position,
    required this.initDate,
    required this.endDate,
    required this.image,
    required this.idAdress,
  });

  factory ModelPitstop.fromMap(Map<String, dynamic> map) {
    return ModelPitstop(
      idStop: map['id_stop'],
      position: map['chooseVehicle'],
      initDate: map['dt_arrive'],
      endDate:  map['dt_go'],
      image: map['path_img'],
      idAdress: map['id_adress'],
    );
  }
}
