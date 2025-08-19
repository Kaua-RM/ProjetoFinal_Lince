import 'package:flutter/material.dart';
import 'package:projectflite/usecase/usecase_insertPeople.dart';
import 'package:provider/provider.dart';

import '../../../controllers/controller_peoples.dart';
import '../../theme_background.dart';

Widget participants(BuildContext context) {
  return Consumer<ControllerPeoples>(
    builder: (context, people, child) => Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Background().white()),
      child: Column(
        children: [
          Row(
            children: [
              Text("Adicionar Participantes"),
              IconButton(
                onPressed: () => openModalUser(context),
                icon: Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          ListView.builder(
            itemCount: people.people.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text("Nome : ${people.people[index].Name}"),
                  Text("Data Nasciemnto : ${people.people[index].Age}")
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}