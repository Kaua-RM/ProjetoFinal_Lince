import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_group.dart';
import 'package:projectflite/controllers/controller_map.dart';
import 'package:projectflite/controllers/controller_peoples.dart';
import 'package:projectflite/controllers/controller_travel.dart';
import 'package:projectflite/presentation/form/FormPage/formPage_meanTransport.dart';
import 'package:projectflite/presentation/form/FormPage/formPage_participants.dart';
import 'package:projectflite/presentation/form/FormPage/formPage_pitStop.dart';
import 'package:projectflite/presentation/form/formPage/formPage_dates.dart';
import 'package:projectflite/presentation/theme_background.dart';
import 'package:projectflite/utils/util_presentation.dart';
import 'package:projectflite/utils/util_titlesLanguagens.dart';
import 'package:provider/provider.dart';
import '../controllers/controller_dates.dart';
import '../controllers/controller_moodapp.dart';
import '../usecase/usecase_selectDate.dart';
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

    final formKey = GlobalKey<FormState>();

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
              Form(
                key: formKey,
                child: Column(
                  spacing: 40,
                  children: [
                    Row(children: [topDown(context), iconLightMode(context)]),
                    titleLanguage("form", context),
                    Column(
                      spacing: 40,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Titulo",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins-Bold",
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: titleController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'O título não pode ser vazio.';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        participants(context),
                        Dates(context, "Data Inicio", dateControllerInit),
                        Consumer<ControllerDate>(
                          builder: (context, date, child) => Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Data Fim",
                                    style: TextStyle(fontSize: 14, fontFamily: "Poppins-Bold"),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: dateControllerEnd,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Data não pode ser vazia";
                                      }

                                      if(DateTime.parse(value).day < DateTime.now().day){
                                        return "Data não pode ser menor que hoje";
                                      }

                                      if(DateTime.parse(value).day < DateTime.parse(dateControllerInit.text).day){
                                        return "Data não pode ser menor que a data de inicio";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.date_range_outlined),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Ex:2007-07-12",
                                    ),
                                    onTap: () {
                                      selectdate(context, date, dateControllerEnd);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        meansTransports(context),
                        pitstop(context),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Formulário validado e salvo!'),
                                ),
                              );

                              consumerTravel.setNewTravel(
                                title: titleController.text,
                                dateInit: dateControllerInit.text,
                                dateEnd: dateControllerEnd.text,
                                typeVei: consumerMeansTransport.chooseVehicle,
                                pitstops: consumerPitStop.pitstopPresentation,
                                peoples: consumerPeople.people,
                              );

                              consumerPitStop.pitstopPresentation = [];
                              consumerPeople.people = [];
                              consumerMeansTransport.chooseVehicle = "";
                              consumerPitStop.pitstops = {};
                            }
                            ;
                          },
                          child: Text(
                            "Salvar",
                            style: TextStyle(
                              color: Background().white(),
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Background().strongBlue(),
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadiusGeometry.all(
                                Radius.circular(9),
                              ),
                            ),
                            fixedSize: Size(double.maxFinite, 14),
                          ),
                        ),
                      ],
                    ),
                    routesButtons(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
