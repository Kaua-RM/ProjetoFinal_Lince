

import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_map.dart';
import 'package:provider/provider.dart';
import '../../../usecase/usecase_openMap.dart';
import '../../theme_background.dart';

Widget pitstop(BuildContext context) {
  return Consumer<ControllerMap>(
    builder: (context, map, child) => Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Background().white(),
        border: Border.all(width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ),
          for(final travel in map.pitstopPresentation)
            Card(
              shape: OutlineInputBorder(),
              color: Colors.white,
              margin: EdgeInsets.all(15),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(travel.image),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 1,
                  children: [
                    Text(travel.initDate , style: TextStyle(fontSize: 16)),
                    Text(travel.endDate , style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],),
            )
        ],
      ),
    ),
  );
}
