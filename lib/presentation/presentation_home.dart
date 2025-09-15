import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_travel.dart';
import 'package:projectflite/models/model_travel.dart';
import 'package:projectflite/usecase/usecase_detailsTravel.dart';
import 'package:projectflite/utils/util_presentation.dart';
import 'package:projectflite/presentation/theme_background.dart';
import 'package:provider/provider.dart';
import '../controllers/controller_adress.dart';
import '../utils/util_backgroundimage.dart';
import '../utils/util_routesbuttons.dart';
import '../utils/util_titlesLanguagens.dart';
import '../utils/util_topdown.dart';

class PresentationHome extends StatefulWidget {
  const PresentationHome({super.key});

  @override
  State<PresentationHome> createState() => _PresentationHomeState();
}

class _PresentationHomeState extends State<PresentationHome> {
  @override
  void initState() {
    super.initState();
    // Garante que o ControllerTravel seja inicializado ao criar o widget
    Provider.of<ControllerTravel>(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ControllerTravel>(
      builder: (context, consumerTravel, child) => Scaffold(
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
              Row(children: [topDown(context), iconLightMode(context)]),
              SizedBox(height: 20),
              Column(
                children: [
                  titleLanguage("home", context),
                  SizedBox(height: 30),
                  Consumer<ControllerAdress>(
                    builder: (context, consumerAdress, child) {
                      if (consumerTravel.travels.isEmpty) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: consumerTravel.travels.length,
                          itemBuilder: (context, index) {
                            final travel = consumerTravel.travels[index];

                            // Lógica de verificação de data para determinar o status da viagem
                            final now = DateTime.now();
                            final initDateTime = DateTime.parse(travel.initDate);
                            final endDateTime = DateTime.parse(travel.endDate);

                            // A viagem é ativa se a data atual estiver entre a de início e a de fim.
                            final isTripActive = now.isAfter(initDateTime.subtract(Duration(days: 1))) && now.isBefore(endDateTime.add(Duration(days: 1)));

                            return InkWell(
                              onTap: () => openDetailsTravel(context, index),
                              child: Card(
                                color: isTripActive ? Colors.white : Colors.grey[200], // Cor do card
                                shadowColor: isTripActive ? Colors.black : Colors.transparent, // Sombra
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.mode_of_travel, color: isTripActive ? Colors.black : Colors.grey),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              travel.title,
                                              style: TextStyle(
                                                fontSize: 23,
                                                fontFamily: "Poppins-Bold",
                                                color: isTripActive ? Colors.black : Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            isTripActive ? 'ATIVA' : 'CONCLUÍDA',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: isTripActive ? Colors.green : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(Icons.date_range_outlined, color: isTripActive ? Colors.black : Colors.grey),
                                          SizedBox(width: 8),
                                          Text(
                                            "${travel.initDate} & ${travel.endDate}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontStyle: isTripActive ? FontStyle.normal : FontStyle.italic,
                                              color: isTripActive ? Colors.black : Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(Icons.car_crash_outlined, color: isTripActive ? Colors.black : Colors.grey),
                                          SizedBox(width: 8),
                                          Text(
                                            travel.typeVei,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: isTripActive ? Colors.black : Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
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
