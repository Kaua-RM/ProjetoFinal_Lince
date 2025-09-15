import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_dates.dart';
import 'package:projectflite/usecase/usecase_selectDate.dart';
import 'package:provider/provider.dart';



Widget Dates(
  BuildContext context,
  String title,
  TextEditingController dateController,
) {
  return Consumer<ControllerDate>(
    builder: (context, date, child) => Column(
      children: [
        Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, fontFamily: "Poppins-Bold"),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: dateController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data não pode ser vazia";
                }

                if(DateTime.parse(value).day < DateTime.now().day){
                  return "Data não pode ser menor que hoje";
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range_outlined),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
                hintText: "Ex:2007-07-12",
              ),
              onTap: () {
                selectdate(context, date, dateController);
              },
            ),
          ],
        ),
      ],
    ),
  );
}
