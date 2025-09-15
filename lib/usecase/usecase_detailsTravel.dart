import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projectflite/controllers/controller_image.dart';
import 'package:projectflite/controllers/controller_travel.dart';
import 'package:projectflite/usecase/usecase_createPdf.dart';
import 'package:provider/provider.dart';

import '../presentation/theme_background.dart';

void openDetailsTravel(BuildContext context, int index) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Consumer<ControllerTravel>(
      builder: (context, travel, child) => Container(
        decoration: BoxDecoration(color: Background().white()),
        width: double.infinity,
        // Envolve a Column principal com SingleChildScrollView
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 80,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 12,
                      children: [
                        Text(
                          "${travel.travels[index].title}",
                          style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            fontSize: 30,
                          ),
                        ),
                        Row(
                          spacing: 20,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${travel.travels[index].initDate}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${travel.travels[index].endDate}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            spacing: 8,
                            children: [
                              for (final person in travel.travels[index].peoples)
                                ActionChip(
                                  onPressed: () {
                                    // Lógica para quando o chip é pressionado, se houver
                                  },
                                  autofocus: true,
                                  backgroundColor: Colors.white,
                                  side: BorderSide(),
                                  labelStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  visualDensity: VisualDensity(vertical: 4),
                                  padding: EdgeInsets.all(1),
                                  label: Text(
                                    person.Name.split(" ").first,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontFamily: "Poppins-Regular"),
                                  ),
                                  avatar: person.image != '' && File(person.image).existsSync()
                                      ? CircleAvatar(
                                    backgroundImage: FileImage(File(person.image)),
                                    radius: 14,
                                  )
                                      : CircleAvatar(
                                    backgroundImage: AssetImage('assets/user.png'),
                                    radius: 14,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              for (final person in travel.travels[index].pitstops)
                                Consumer<ControllerImage>(
                                  builder: (context, imagens, child) => Card(
                                    shape: OutlineInputBorder(),
                                    color: Colors.white,
                                    margin: EdgeInsets.all(15),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                    Image.network(
                                                      person.image,
                                                    ).image,
                                                    radius: 40,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Adicionar imagem"),
                                                      IconButton(
                                                        onPressed: () {
                                                          imagens.addImageData(
                                                            0,
                                                            int.parse(
                                                              person.idStop.value,
                                                            ),
                                                          );
                                                        },
                                                        icon: Icon(Icons.add),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                                spacing: 20,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Wrap(
                                                  children: [
                                                    FutureBuilder(
                                                      future: imagens
                                                          .imagesSelect(
                                                        int.parse(
                                                          person.idStop.value,
                                                        ),
                                                      ),
                                                      builder: (context, asyncSnapshot) {
                                                        if (asyncSnapshot
                                                            .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Center(
                                                            child:
                                                            CircularProgressIndicator(),
                                                          );
                                                        }

                                                        if (!asyncSnapshot
                                                            .hasData ||
                                                            asyncSnapshot
                                                                .data!
                                                                .isEmpty) {
                                                          return Text(
                                                            "Imagem não encotrada",
                                                          );
                                                        } else {
                                                          return Wrap(
                                                            children: asyncSnapshot
                                                                .data!
                                                                .map<Widget>((
                                                                file,
                                                                ) {
                                                              return Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                  8.0,
                                                                ),
                                                                child: CircleAvatar(
                                                                  backgroundImage:
                                                                  Image.file(
                                                                    file,
                                                                  ).image,
                                                                  radius: 14,
                                                                ),
                                                              );
                                                            })
                                                                .toList(),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
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
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: () => createPdf(travel, index, context), child: Text('Gerar Pdf', style: TextStyle(color: Background().white())), style: OutlinedButton.styleFrom(
                  backgroundColor: Background().strongBlue(),
                  fixedSize: Size(double.maxFinite, 60),
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: () => createBook(travel, index, context, ControllerImage()), child: Text('Gerar Livreto' , style: TextStyle(color: Background().white()),), style: OutlinedButton.styleFrom(
                    backgroundColor: Background().strongBlue(),
                    fixedSize: Size(double.maxFinite, 60),

                ),),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
