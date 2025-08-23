import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_group.dart';
import 'package:projectflite/controllers/controller_map.dart';
import 'package:projectflite/controllers/controller_peoples.dart';
import 'package:projectflite/controllers/controller_travel.dart';
import 'package:projectflite/models/model_group.dart';
import 'package:projectflite/models/model_people.dart';
import 'package:projectflite/presentation/form/FormPage/formPage_participants.dart';
import 'package:projectflite/presentation/form/FormPage/formPage_meanTransport.dart';
import 'package:projectflite/presentation/form/FormPage/formPage_pitStop.dart';
import 'package:projectflite/presentation/form/formPage/formPage_dates.dart';
import 'package:projectflite/utils/util_presentation.dart';
import 'package:projectflite/utils/util_subtitledividerlanguage.dart';
import 'package:projectflite/utils/util_titlesLanguagens.dart';
import 'package:provider/provider.dart';
import '../controllers/controller_moodapp.dart';
import '../utils/util_backgroundimage.dart';
import '../utils/util_routesbuttons.dart';
import '../utils/util_topdown.dart';

class PresentationForms extends StatelessWidget {
  const PresentationForms({super.key});

  @override
  Widget build(BuildContext context) {
    var consumerPeople = Provider.of<ControllerPeoples>(context, listen: false);
    var consumerPitStop = Provider.of<ControllerMap>(context, listen: false);
    var consumerMeansTransport = Provider.of<ControllerGroup>(
      context,
      listen: false,
    );
    var consumerTravel = Provider.of<ControllerTravel>(context);

    TextEditingController titleController = TextEditingController();
    TextEditingController dateControllerInit = TextEditingController();
    TextEditingController dateControllerEnd = TextEditingController();

    return Consumer<MoodsApp>(
      builder: (context, change, child) => Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: backgroundImage(context),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Column(
                spacing: 40,
                children: [
                  Row(children: [topDown(context), iconLightMode(context)]),
                  titleLanguage("form", context),
                  subTitleDividerLanguage("form", context),
                  Column(
                    spacing: 40,
                    children: [
                      Column(
                        children: [
                          Text("Titulo"),
                          TextFormField(controller: titleController),
                        ],
                      ),
                      participants(context),
                      Dates(context, "Data Inicio", dateControllerInit),
                      Dates(context, "Data Fim", dateControllerEnd),
                      meansTransports(context),
                      pitstop(context),
                      ElevatedButton(
                        onPressed: () {
                          consumerTravel.setNewTravel(
                          titleController.text,
                          dateControllerInit.text,
                          dateControllerEnd.text,
                          consumerMeansTransport.chooseVehicle,
                          consumerPitStop.pitstopPresentation,
                          consumerPeople.people,);

                          consumerPitStop.pitstopPresentation = [];
                          consumerPeople.people = [];
                          consumerMeansTransport.chooseVehicle = "";
                          consumerPitStop.pitstops = {};
                        },
                        child: Text("Salvar"),

                      ),
                    ],
                  ),
                  routesButtons(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
