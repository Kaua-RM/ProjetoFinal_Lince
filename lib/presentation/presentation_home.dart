import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_moodapp.dart';
import 'package:projectflite/controllers/controller_travel.dart';
import 'package:projectflite/utils/util_presentation.dart';
import 'package:projectflite/presentation/theme_background.dart';
import 'package:projectflite/utils/util_subtitledividerlanguage.dart';
import 'package:provider/provider.dart';
import '../controllers/controller_languageapp.dart';
import '../utils/util_backgroundimage.dart';
import '../utils/util_routesbuttons.dart';
import '../utils/util_titlesLanguagens.dart';
import '../utils/util_topdown.dart';

class PresentationHome extends StatelessWidget {
  const PresentationHome({super.key});

  @override
  Widget build(BuildContext context) {
    var consumerTravel = Provider.of<ControllerTravel>(context);

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
              Row(children: [topDown(context), iconLightMode(context)]),

              SizedBox(height: 20),
              Column(
                spacing: 60,
                children: [
                  titleLanguage("home", context),
                  subTitleDividerLanguage("home", context),
                  SearchBar(
                    leading: Icon(
                      Icons.search,
                      color: Background().orangeYellow(),
                    ),
                    hintText: "Procurar",
                  ),
                  SizedBox(height: 200),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: consumerTravel.travels.length,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        Text(consumerTravel.travels[index].title),
                        Text(consumerTravel.travels[index].pitstops.length.toString()),
                      ],);
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
