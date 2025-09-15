import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projectflite/usecase/usecase_insertPeople.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_peoples.dart';
import '../models/model_people.dart';
import '../presentation/theme_background.dart';

void openListModalUser(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Consumer<ControllerPeoples>(
      builder: (context, people, child) {
        return FutureBuilder<List<ModelPeople>>(
          future: people.getPeople(),
          builder: (context, snapshot) {
            // Verifica o estado da conexão do Future
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Lida com erros
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Quando não há dados
              return Center(child: Text('Nenhum participante encontrado.'));
            } else {
              // Os dados foram carregados com sucesso
              var dataPeople = snapshot.data!;

              return Container(
                decoration: BoxDecoration(color: Background().white()),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        // `spacing` is not a property of Row, it might be a custom widget
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Adicionar Participante",
                            style: TextStyle(
                                fontSize: 20, fontFamily: "Poppins-Bold"),
                          ),
                          IconButton(
                            onPressed: () => openModalUser(context),
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
                          for (final person in dataPeople)
                            ActionChip(
                              onPressed: () => people.addPeople(person.Name, person.Age, person.Password, person.image),
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
                                person.Name
                                    .split(" ")
                                    .first,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancelar"),
                        ),
                        ElevatedButton(onPressed: () {}, child: Text("Salvar")),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    ),
  );
}
