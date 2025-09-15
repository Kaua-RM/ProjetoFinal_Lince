import 'dart:io';

import 'package:flutter/material.dart';

import 'package:projectflite/controllers/controller_dates.dart';
import 'package:projectflite/controllers/controller_image.dart';
import 'package:projectflite/presentation/theme_background.dart';
import 'package:projectflite/usecase/usecase_selectDate.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_peoples.dart';

void openModalUser(BuildContext context) {
  TextEditingController passController = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

    var consumePeople = Provider.of<ControllerPeoples>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(color: Background().white()),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Adicionar Participante",
                style: TextStyle(fontSize: 20, fontFamily: "Poppins-Bold"),
              ),
            ),
            Consumer<ControllerImage>(
              builder: (context, consumerImage, child) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: 12,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: consumerImage.image == null
                                ? AssetImage('assets/user.png')
                                : FileImage(File(consumerImage.image!.path)),
                            radius: 40,
                          ),
                          Positioned(
                            top: -30,
                            bottom: -70,
                            left: 34,
                            child: IconButton(
                              onPressed: () => consumerImage.getPicker(),
                              icon: Icon(Icons.edit),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: CircleBorder(side: BorderSide(width: 1)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Nome",
                        style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        controller: controllerName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Background().white(),
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "nome não pode estar vazio";
                          }

                          if(value.length <= 3){
                            return "nome não pode ter menos do que 3 caracteres";
                          }

                          return null;
                        },
                      ), Text(
                        "Senha",
                        style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        controller: passController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Background().white(),
                        ),
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return "senha não pode estar vazia";
                            }

                            if(value.length < 3){
                              return "senha não pode ter menos do que 3 caracteres";
                            }

                            return null;
                          }
                      ),

                      Consumer<ControllerDate>(
                        builder: (context, date, child) => Column(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Data de Nascimento",
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

                                    if(DateTime.parse(value).year > DateTime.now().year){
                                      return "O ano não pode ser maior que o ano atual";
                                    }

                                    if(DateTime.parse(value).year == DateTime.now().year){
                                      return "O ano não pode ser igual  ao ano atual";
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancelar"),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                consumePeople.addPeople(
                                  controllerName.text,
                                  dateController.text,
                                  passController.text,
                                  consumerImage.image?.path ?? "",
                                );
                                Navigator.pop(context);
                              }
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

}
