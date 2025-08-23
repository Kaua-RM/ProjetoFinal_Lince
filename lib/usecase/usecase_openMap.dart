import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projectflite/controllers/controller_adress.dart';
import 'package:projectflite/usecase/usecase_openModalPitStop.dart';
import 'package:provider/provider.dart';
import '../controllers/controller_map.dart';
import '../presentation/theme_background.dart';


Widget openMap(BuildContext context) {

  var consumerController = Provider.of<ControllerAdress>(context , listen: false);

  return Consumer<ControllerMap>(
    builder: (context, map, child) {

      if(map.log == 0.0){
        return const Center(child: CircularProgressIndicator());
      }

      final markers = map.pitstops.values.map((value) => Marker(
        markerId: value.idStop,
        position: value.position,
        onTap: () => openModalPitStopForm(context, value, map , consumerController , value.position , value.idStop ),
      )).toSet();

      return Stack(
        children : [
          GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(map.lat, map.log), zoom: 18),
          markers: markers,
          onTap: (argument) => map.setStopMarke(argument),
        ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40 , horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SearchBar(
                    leading: Icon(
                      Icons.search,
                      color: Background().orangeYellow(),
                    ),
                    hintText: "Procurar",
                  ),
                ),
              ],
            ),
          )
        ]
      );
    },
  );
}



