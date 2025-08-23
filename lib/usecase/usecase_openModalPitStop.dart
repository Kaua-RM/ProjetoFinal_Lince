import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projectflite/controllers/controller_adress.dart';
import 'package:projectflite/presentation/form/formPage/formPage_dates.dart';
import 'package:projectflite/web/web_api.dart';
import '../controllers/controller_map.dart';
import '../models/model_pitStop.dart';

void openModalPitStopForm(
  BuildContext context,
  ModelPitstop pitstopData,
  ControllerMap map,
  ControllerAdress controlAdress,
  LatLng postion,
  MarkerId idStop,
) async {
  Map<String, bool> localExperiences = Map.from(pitstopData.experiences);
  List<String> experienceChoose = [];
  TextEditingController dateControllerInit = TextEditingController();
  TextEditingController dateControllerEnd = TextEditingController();
  var AdressMap = await WebApi().getLocation(postion.latitude.toString(), postion.longitude.toString());


  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (modalContext) {
      return StatefulBuilder(
        builder: (BuildContext statefulContext, StateSetter setState) {
          return Container(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              spacing: 30,
              children: [
                Text("Adicionar Parada", style: TextStyle(fontSize: 20)),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: localExperiences.length,
                  itemBuilder: (context, index) {
                    final experienceKey = localExperiences.keys.toList()[index];
                    return CheckboxListTile(
                      title: Text(experienceKey),
                      value: localExperiences[experienceKey],
                      onChanged: (value) {
                        setState(() {
                          localExperiences[experienceKey] = value ?? false;
                          if (localExperiences[experienceKey] == true) {
                            experienceChoose.add(
                              localExperiences.keys.toList()[index],
                            );
                          }
                        });
                      },
                    );
                  },
                ),
                Dates(context, "Data Inicial", dateControllerInit),
                Dates(context, "Data Final", dateControllerEnd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(modalContext),
                      child: Text("Cancelar"),
                    ),
                    ElevatedButton(
                      onPressed:  ()  {
                        map.updateExperiences(
                          pitstopData.idStop,
                          localExperiences,
                        );
                        map.setStopPresentation(
                          idStop,
                          postion,
                          dateControllerInit.text,
                          dateControllerEnd.text,
                          experienceChoose,
                        );
                        controlAdress.setNewAdress(AdressMap["city"] ?? "",
                            AdressMap["state"] ?? "",
                            AdressMap["country"] ?? "",
                            postion.latitude,
                            postion.longitude);
                        Navigator.pop(modalContext);
                      },
                      child: Text("Salvar"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}


