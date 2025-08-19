

import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_map.dart';
import 'package:provider/provider.dart';
import '../../../usecase/usecase_openMap.dart';
import '../../theme_background.dart';

Widget pitstop(BuildContext context) {
  return Consumer<ControllerMap>(builder: (context, map, child) => Container(
    width: double.infinity,
    decoration: BoxDecoration(color: Background().white()),
    child: Column(
      children: [
        Row(
          children: [
            Text("Adicionar Parada"),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => openMap(context)),
              ),
              icon: Icon(Icons.add_circle_outline),
            ),
          ],
        ),
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
      ],
    ),
  ));
}