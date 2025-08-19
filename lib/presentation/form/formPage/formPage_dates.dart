import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_dates.dart';
import 'package:projectflite/usecase/usecase_selectDate.dart';
import 'package:provider/provider.dart';

Widget Dates(BuildContext context, String title , TextEditingController dateController) {



  return Consumer<ControllerDate>(builder: (context, date, child) =>  Column(
    children: [
      Column(
        children: [
          Text(title),
          TextFormField(
            controller: dateController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range_outlined),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(),
            ),
            onTap: () {
             selectdate(context , date , dateController);
            },
          ),
        ],
      ),
    ],
  ));
}