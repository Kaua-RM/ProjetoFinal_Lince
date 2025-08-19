import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_dates.dart';

Future<String> selectdate(BuildContext context , ControllerDate date , TextEditingController dateControll) async {
 final dateSelect =  await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1960),
    lastDate: DateTime(2100),
  );

if(dateSelect != null){
  date.setDate(dateSelect.toString());
  dateControll.text = date.dateInit.split(" ").first;
}

return date.dateInit;

}