
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projectflite/usecase/usecase_listPeople.dart';
import 'package:provider/provider.dart';

import '../../../controllers/controller_peoples.dart';
import '../../theme_background.dart';

Widget participants(BuildContext context) {
  return Consumer<ControllerPeoples>(
    builder: (context, people, child) => Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Background().white(),
        border: Border.all(width: 1),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Adicionar Participantes", style: TextStyle(fontSize: 16)),
                IconButton(
                  onPressed: () => openListModalUser(context),
                  icon: Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              children: [
                for (final person in people.people)
                  ActionChip(
                    onPressed: () => "",
                    autofocus: true,
                    backgroundColor: Colors.white,
                    side: BorderSide(),
                    labelStyle: TextStyle(
                       fontSize: 18,
                      color: Colors.black
                    ),
                    visualDensity: VisualDensity(vertical: 4),

                    padding: EdgeInsets.all(1),
                    label: Text(
                      person.Name.split(" ").first,
                      overflow: TextOverflow.ellipsis,
                    ),
                    avatar: CircleAvatar(
                      backgroundImage: person.image == ''
                          ? AssetImage('assets/user.png')
                          : FileImage(File(person.image)),
                      radius: 14,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
