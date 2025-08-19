import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projectflite/models/model_pitStop.dart';


class ControllerMap extends ChangeNotifier {
  double lat = 0.0;
  double log = 0.0;
  var error = "";

   Map<MarkerId, ModelPitstop> pitstops = {};

   List<ModelPitstop> pitstopPresentation = [];

  Set<Marker> get stopMarke {
    return pitstops.values.map((data) => Marker(
      markerId: data.idStop,
      position: data.position,
      onTap: () {
        // Nada aqui. A lógica de abrir o modal está no widget.
      },
    )).toSet();
  }

  void setStopMarke(LatLng position) {
    final markerId = MarkerId(position.toString());

    final newPitstop = ModelPitstop(
      idStop: markerId,
      position: position,
      initDate: "",
      endDate: "",
      experienceChoose: []
    );

    pitstops[markerId] = newPitstop;
    notifyListeners();
  }

  void updateExperiences(MarkerId id, Map<String, bool> updatedExperiences) {
    pitstops[id]?.experiences = updatedExperiences;
    notifyListeners();
  }

  void setStopPresentation(MarkerId idStop , LatLng position , String initDate , String endDate , List<String> experinceChoose){

    pitstopPresentation.add(ModelPitstop(idStop: idStop, position: position, initDate: initDate, endDate: endDate , experienceChoose:  experinceChoose));
    notifyListeners();
  }



  ControllerMap(){
    getPosicao();
  }

  getPosicao() async {
    try {
      Position position = await actualPossiton();
      lat =  position.latitude;
      log =  position.longitude;
      notifyListeners();
    } catch (e) {
      print(e);
    }

  }

  Future<Position> actualPossiton() async {
    LocationPermission permission;

    bool isActived = await Geolocator.isLocationServiceEnabled();

    if (!isActived) {
      return Future.error("Por favor , habilite a localização");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Você não habilitou a localização");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        "Por favor , habilite a localização nas configurações",
      );
    }
    return await Geolocator.getCurrentPosition();
  }
}