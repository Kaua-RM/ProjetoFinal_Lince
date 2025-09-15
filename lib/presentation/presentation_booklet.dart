import 'package:flutter/material.dart';
import 'package:projectflite/utils/util_topdown.dart';
import 'package:provider/provider.dart';
import '../controllers/controller_map.dart';
import '../controllers/controller_moodapp.dart';
import '../utils/util_backgroundimage.dart';
import '../utils/util_presentation.dart';
import '../utils/util_routesbuttons.dart';
import '../utils/util_subtitledividerlanguage.dart';
import '../utils/util_titlesLanguagens.dart';

class PresentationBooklet extends StatelessWidget {
  const PresentationBooklet({super.key});

  @override
  Widget build(BuildContext context) {
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
                  titleLanguage("book", context),
                  Consumer<ControllerMap>(
                    builder: (context, map, child) => Container(
                      width: double.infinity,
                      child: Column(children: [
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: map.pitstopPresentation.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              shape: OutlineInputBorder(),
                              child: Column(children: [
                                Text("Parada nº ${index + 1}"),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(map.pitstopPresentation[index].image),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 1,
                                  children: [
                                    Text(map.pitstopPresentation[index].initDate , style: TextStyle(fontSize: 16)),
                                    Text(map.pitstopPresentation[index].endDate , style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ],),
                            );
                          },)
                      ]),
                    ),
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
