import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_group.dart';
import 'package:provider/provider.dart';

Widget meansTransports(BuildContext context) {

  var consumerVehicle =  Provider.of<ControllerGroup>(context);

  return DropdownButton(
    items: meansTransport.map((e) {
      return DropdownMenuItem(key: ValueKey(e), value: e, child: Text(e));
    }).toList(),
    onChanged: (value) {
      consumerVehicle.addGroup(value!);
    },
    hint: Text(consumerVehicle.chooseVehicle),
  );
}

List<String> meansTransport = ["Carro", "Moto", "Onibus", "Aviao", "Cruzeiro"];