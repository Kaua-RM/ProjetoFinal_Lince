import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projectflite/usecase/usecase_openModalPitStop.dart';
import 'package:provider/provider.dart';
import '../controllers/controller_map.dart';


Widget openMap(BuildContext context) {

  return Consumer<ControllerMap>(
    builder: (context, map, child) {

      if(map.log == 0.0){
        return const Center(child: CircularProgressIndicator());
      }

      final markers = map.pitstops.values.map((value) => Marker(
        markerId: value.idStop,
        position: value.position,
        onTap: () => openModalPitStopForm(context, value, map , value.position , value.idStop),
      )).toSet();

      return Stack(
        children : [
          GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(map.lat, map.log), zoom: 18),
          markers: markers,
          onTap: (argument) => map.setStopMarke(argument),
        ),
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 40.0 , horizontal: 20),
            child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
          )
        ]
      );
    },
  );
}



