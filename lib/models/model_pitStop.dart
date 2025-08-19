import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class ModelPitstop {
  late MarkerId idStop;
  late LatLng position;
  late var initDate = "";
  late var endDate = "";
  late List<String> experienceChoose;

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
    required this.experienceChoose
  });



}
