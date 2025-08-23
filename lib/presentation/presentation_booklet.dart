import 'package:flutter/material.dart';
import 'package:projectflite/presentation/theme_background.dart';
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
                  subTitleDividerLanguage("book", context),
                  SearchBar(
                    leading: Icon(
                      Icons.search,
                      color: Background().orangeYellow(),
                    ),
                    hintText: "Procurar",
                  ),

                  Consumer<ControllerMap>(
                    builder: (context, map, child) => Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Background().white()),
                      child: Column(children: [
                        ListView.builder(
                          itemCount: map.pitstopPresentation.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(children: [
                              Text(map.pitstopPresentation[index].initDate),
                              Text(map.pitstopPresentation[index].endDate),
                              Text(map.pitstopPresentation[index].experienceChoose.toString())
                            ],);
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
