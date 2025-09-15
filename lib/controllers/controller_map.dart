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
      },
    )).toSet();
  }

  void setStopMarke(LatLng position) {
    final markerId = MarkerId(position.toString());

    final newPitstop = ModelPitstop(
      idStop: markerId,
      position: position,
      image: "",
      initDate: "",
      endDate: "",
      idAdress: 0,
    );

    pitstops[markerId] = newPitstop;
    notifyListeners();
  }

  void updateExperiences(MarkerId id, Map<String, bool> updatedExperiences) {
    pitstops[id]?.experiences = updatedExperiences;
    notifyListeners();
  }

  void setStopPresentation(MarkerId idStop , LatLng position , String initDate , String endDate , String image  , int idAdress){

    pitstopPresentation.add(ModelPitstop(idStop: idStop, position: position, initDate: initDate, endDate: endDate , idAdress: idAdress , image: image));
    notifyListeners();
  }

  String getPickerMap(LatLng position) {

    final String picke = 'https://maps.googleapis.com/maps/api/staticmap'
        '?size=400x200'
        '&zoom=18'
        '&center=${position.latitude},${position.longitude}'
        '&markers=color:red%7C${position.latitude},${position.longitude}'
        '&key=AIzaSyAgT9pV0ONamMF8ByF008OT7lf4-1oAFd0';
    return picke;
  }
  String getRouteMapImage(List<ModelPitstop> pitstops) {
    final baseUrl = 'https://maps.googleapis.com/maps/api/staticmap';
    final size = 'size=600x400';
    final markers = pitstops.map((pitstop) {
      final lat = pitstop.position.latitude;
      final lon = pitstop.position.longitude;
      return 'markers=color:blue%7C$lat,$lon';
    }).join('&');
    final path = 'path=color:0x0000ff|weight:5|' + pitstops.map((pitstop) {
      return '${pitstop.position.latitude},${pitstop.position.longitude}';
    }).join('|');
    final key = 'key=AIzaSyAgT9pV0ONamMF8ByF008OT7lf4-1oAFd0';

    return '$baseUrl?$size&$markers&$path&$key';
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

