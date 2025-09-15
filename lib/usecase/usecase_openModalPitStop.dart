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
  TextEditingController dateControllerInit = TextEditingController();
  TextEditingController dateControllerEnd = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var AdressMap = controlAdress.getFromCache(postion);
  if (AdressMap == null) {
    AdressMap = await WebApi().getLocation(postion);
    controlAdress.addToCache(postion, AdressMap);
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Essencial para que o modal possa ocupar a altura total
    builder: (modalContext) {
      return StatefulBuilder(
        builder: (BuildContext statefulContext, StateSetter setState) {
          return Form(
            key: formKey,
            // Envolve todo o conteúdo do modal em um SingleChildScrollView
            child: SingleChildScrollView(
              // Adiciona padding na parte inferior para que o teclado não cubra os campos
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(modalContext).viewInsets.bottom,
              ),
              child: Container(
                padding: EdgeInsets.all(20), // Ajuste o padding geral
                child: Column(
                  mainAxisSize: MainAxisSize.min, // O Column se ajusta ao conteúdo
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os elementos horizontalmente
                  children: [
                    SizedBox(height: 10), // Espaço no topo
                    Text(
                      "Adicionar Parada",
                      style: TextStyle(fontSize: 20, fontFamily: "Poppins-Bold"),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${AdressMap["city"] ?? AdressMap["town"] ?? 'Endereço desconhecido'}",
                      style: TextStyle(fontSize: 15, fontFamily: "Poppins-SemiBold"),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${AdressMap["country"] ?? 'País desconhecido'}",
                      style: TextStyle(fontSize: 15, fontFamily: "Poppins-SemiBold"),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Dates(modalContext, "Data Inicial", dateControllerInit),
                    Dates(modalContext, "Data Final", dateControllerEnd),
                    SizedBox(height: 20),
                    Text("Experiências", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ListView.builder(
                      shrinkWrap: true, // O ListView se ajusta ao número de itens
                      physics: NeverScrollableScrollPhysics(), // Desabilita o scroll do ListView interno, pois o pai já tem scroll
                      itemCount: localExperiences.length,
                      itemBuilder: (context, index) {
                        final experienceKey = localExperiences.keys.toList()[index];
                        return CheckboxListTile(
                          title: Text(experienceKey),
                          value: localExperiences[experienceKey],
                          onChanged: (value) {
                            setState(() {
                              localExperiences[experienceKey] = value ?? false;
                            });
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(modalContext),
                          child: Text("Cancelar"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final int newAddressId = await controlAdress.setNewAdress(
                              AdressMap["city"] ?? AdressMap["town"] ?? "",
                              AdressMap["state"] ?? "",
                              AdressMap["country"] ?? "",
                              postion.latitude,
                              postion.longitude,
                            );

                            map.setStopPresentation(
                              idStop,
                              postion,
                              dateControllerInit.text,
                              dateControllerEnd.text,
                              map.getPickerMap(postion),
                              newAddressId,
                            );

                            map.updateExperiences(pitstopData.idStop, localExperiences);
                            Navigator.pop(modalContext);
                          },
                          child: Text("Salvar"),
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Um pouco de espaço no final
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

