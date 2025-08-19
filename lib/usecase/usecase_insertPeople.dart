import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_dates.dart';
import 'package:projectflite/presentation/form/formPage/formPage_dates.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_peoples.dart';

void openModalUser(BuildContext context) {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerYears = TextEditingController();
  TextEditingController dateController = TextEditingController();

  var consumePeople = Provider.of<ControllerPeoples>(context, listen: false);

  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      width: double.infinity,
      child: Column(
        children: [
          Text("Adicionar Participante"),
          Column(
            children: [
              Text("Nome"),
              TextFormField(controller: controllerName),
              Dates(context, "Data Nascimento", dateController),
              Row(
                children: [
                  TextButton(onPressed: () => "", child: Text("Cancelar")),
                  OutlinedButton(
                    onPressed: () => consumePeople.addPeople(
                      controllerName.text,
                      dateController.text,
                    ),
                    child: Text("Ok"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}