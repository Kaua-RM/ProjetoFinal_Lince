import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_group.dart';
import 'package:provider/provider.dart';

Widget meansTransports(BuildContext context) {

  var consumerVehicle =  Provider.of<ControllerGroup>(context);

  return DropdownButtonFormField(
    items: meansTransport.map((e) {
      return DropdownMenuItem(key: ValueKey(e), value: e, child: Text(e));
    }).toList(),
    onChanged: (value) {
      consumerVehicle.addGroup(value!);
    },
    hint: Text(consumerVehicle.chooseVehicle),
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: "Tipo de Veiculo" ,
      prefixIcon: Icon(Icons.car_crash),
      filled: true,
      fillColor: Colors.white
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'a forma de transporte não pode estar vazia.';
      }
      return null;
    },
  );
}

List<String> meansTransport = ["Carro", "Moto", "Onibus", "Aviao", "Cruzeiro"];