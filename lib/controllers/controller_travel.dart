import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projectflite/database/db.dart';
import 'package:projectflite/models/model_people.dart';
import 'package:projectflite/models/model_pitStop.dart';
import 'package:projectflite/models/model_travel.dart';
import 'package:sqflite/sqflite.dart';

class ControllerTravel extends ChangeNotifier {
  late Database db;
  List<ModelTravel> travels = [];

  ControllerTravel() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
    await _loadTravels();
  }

  // Retorna a lista de viagens ativas
  List<ModelTravel> get activeTravels {
    return travels.where((travel) => _isTravelActive(travel)).toList();
  }

  // Retorna a lista de viagens concluídas
  List<ModelTravel> get completedTravels {
    return travels.where((travel) => !_isTravelActive(travel)).toList();
  }

  // Método privado para verificar se a viagem está ativa
  bool _isTravelActive(ModelTravel travel) {
    try {
      final now = DateTime.now();
      final initDateTime = DateTime.parse(travel.initDate);
      final endDateTime = DateTime.parse(travel.endDate);

      // Considera a viagem ativa se a data atual estiver entre a data de início e a data de fim.
      // O .isAfter é ajustado para incluir o dia de início.
      // O .isBefore é ajustado para incluir o dia de fim.
      return now.isAfter(initDateTime.subtract(Duration(days: 1))) &&
          now.isBefore(endDateTime.add(Duration(days: 1)));
    } catch (e) {
      // Retorna false se houver um erro de formatação da data
      return false;
    }
  }

    Future<void> setNewTravel({
    required String title,
    required String dateInit,
    required String dateEnd,
    required String typeVei,
    required List<ModelPitstop> pitstops,
    required List<ModelPeople> peoples,
  }) async {
    try {
      await db.transaction((txn) async {
        final int groupId = await txn.insert('groupTravel', {
          'chooseVehicle': typeVei,
        });

        final int travelId = await txn.insert('travel', {
          'title': title,
          'dt_arrive': dateInit,
          'dt_go': dateEnd,
          'id_group': groupId,
        });

        // --- VERIFICAÇÃO E INSERÇÃO DE USUÁRIOS ---
        for (var person in peoples) {
          // 1. Verifica se o usuário já existe pelo nome
          final existingPeople = await txn.query(
            'people',
            where: 'name = ?',
            whereArgs: [person.Name],
          );

          int peopleId;
          if (existingPeople.isNotEmpty) {
            // 2. Se o usuário já existe, pega o ID dele
            peopleId = existingPeople.first['id_people'] as int;
            print("Usuário '${person
                .Name}' já existe. Usando o ID existente: $peopleId");
          } else {
            // 3. Se não existe, insere um novo usuário e obtém o ID
            peopleId = await txn.insert('people', {
              'name': person.Name,
              'date': person.Age,
              'pass': person.Password,
              'path_img': person.image,
            });
            print("Usuário '${person
                .Name}' adicionado com sucesso. ID: $peopleId");
          }

          // 4. Conecta o usuário ao grupo, independentemente se ele foi adicionado agora ou já existia
          // Adicionamos uma verificação para evitar duplicidade se o ID já existe no peopleGroup
          final existingPeopleGroup = await txn.query(
            'peopleGroup',
            where: 'id_people = ? AND id_group = ?',
            whereArgs: [peopleId, groupId],
          );

          if (existingPeopleGroup.isEmpty) {
            await txn.insert('peopleGroup', {
              'id_people': peopleId,
              'id_group': groupId,
            });
          }
        }
        // --- FIM DA VERIFICAÇÃO DE USUÁRIOS ---

        for (var pitstop in pitstops) {
          // Lógica para inserir ou obter id_adress (assumindo que 0 significa novo endereço)
          int currentAdressId = pitstop.idAdress;
          if (currentAdressId == 0) {
            // Esta parte depende de como você gerencia a criação de endereços.
            // Você precisaria ter a lógica de inserção aqui, por exemplo:
            /*
            currentAdressId = await txn.insert('adress', {
              'city': pitstop.adress?.city ?? '',
              'state': pitstop.adress?.state ?? '',
              'country': pitstop.adress?.country ?? '',
              'lat': pitstop.adress?.lat ?? 0.0,
              'log': pitstop.adress?.log ?? 0.0,
            });
            */
            print(
                "Aviso: Um novo endereço precisa ser criado ou o idAdress deve ser fornecido.");
          }

          final int stopId = await txn.insert('stop', {
            'dt_arrive': pitstop.initDate,
            'dt_go': pitstop.endDate,
            'path_img': pitstop.image,
            // Esta imagem é da parada, não do usuário
            'id_adress': pitstop.idAdress,
          });

          await txn.insert('stopTravel', {
            'id_stop': stopId,
            'id_travel': travelId,
          });

          for (var entry in pitstop.experiences.entries) {
            if (entry.value) {
              final existingExperience = await txn.query(
                'experience',
                where: 'ds_experience = ?',
                whereArgs: [entry.key],
              );
              int experienceId;
              if (existingExperience.isNotEmpty) {
                experienceId = existingExperience.first['id_experience'] as int;
              } else {
                experienceId = await txn.insert('experience', {
                  'ds_experience': entry.key,
                });
              }

              await txn.insert('stopExperience', {
                'id_stop': stopId,
                'id_experience': experienceId,
              });
            }
          }
        }
      });

      await _loadTravels();
      print("Viagem salva com sucesso!");
    } catch (e) {
      print("Erro ao salvar a viagem: $e");
    }

    try {
      await db.transaction((txn) async {
        final int groupId = await txn.insert('groupTravel', {
          'chooseVehicle': typeVei,
        });

        final int travelId = await txn.insert('travel', {
          'title': title,
          'dt_arrive': dateInit,
          'dt_go': dateEnd,
          'id_group': groupId,
        });

        for (var person in peoples) {
          final int peopleId = await txn.insert('people', {
            'name': person.Name,
            'date': person.Age,
            'pass': person.Password,
            'path_img': person.image,
          });
          await txn.insert('peopleGroup', {
            'id_people': peopleId,
            'id_group': groupId,
          });
        }

        for (var pitstop in pitstops) {
          // --- INÍCIO DAS MUDANÇAS EM setNewTravel ---
          // Lógica para inserir ou obter id_adress (assumindo que 0 significa novo endereço)
          int currentAdressId = pitstop.idAdress;
          if (currentAdressId == 0) { // Se for um novo endereço, insira-o primeiro.
            // Esta parte depende de como você gerencia a criação de endereços.
            // Você precisaria ter a lógica de inserção aqui, por exemplo:
            /*
            currentAdressId = await txn.insert('adress', {
              'city': pitstop.adress?.city ?? '', // Assumindo que ModelPitstop tem um campo 'adress' do tipo ModelAdress
              'state': pitstop.adress?.state ?? '',
              'country': pitstop.adress?.country ?? '',
              'lat': pitstop.adress?.lat ?? 0.0,
              'log': pitstop.adress?.log ?? 0.0,
            });
            */
            // Para este exemplo, vamos apenas prosseguir se um idAdress válido for fornecido
            // ou você precisará implementar a inserção do endereço aqui.
            // Se pitstop.idAdress já é o ID do endereço existente, este bloco não é executado.
            print("Aviso: Um novo endereço precisa ser criado ou o idAdress deve ser fornecido.");
            // Dependendo da sua regra de negócio, você pode querer lançar um erro aqui.
          }
          // --- FIM DAS MUDANÇAS EM setNewTravel ---

          final int stopId = await txn.insert('stop', {
            'dt_arrive': pitstop.initDate,
            'dt_go': pitstop.endDate,
            'path_img': pitstop.image,
            'id_adress': pitstop.idAdress, // Use pitstop.idAdress diretamente, ou currentAdressId se você o atualizou.
          });

          await txn.insert('stopTravel', {
            'id_stop': stopId,
            'id_travel': travelId,
          });

          for (var entry in pitstop.experiences.entries) {
            if (entry.value) {
              final existingExperience = await txn.query(
                'experience',
                where: 'ds_experience = ?',
                whereArgs: [entry.key],
              );
              int experienceId;
              if (existingExperience.isNotEmpty) {
                experienceId = existingExperience.first['id_experience'] as int;
              } else {
                experienceId = await txn.insert('experience', {
                  'ds_experience': entry.key,
                });
              }

              await txn.insert('stopExperience', {
                'id_stop': stopId,
                'id_experience': experienceId,
              });
            }
          }
        }
      });

      await _loadTravels();
      print("Viagem salva com sucesso!");
    } catch (e) {
      print("Erro ao salvar a viagem: $e");
    }
  }

  Future<void> _loadTravels() async {
    // 1. Consulta principal para obter todas as viagens
    final List<Map<String, dynamic>> travelMaps = await db.query('travel');

    List<ModelTravel> loadedTravels = [];

    for (var travelMap in travelMaps) {
      final int travelId = travelMap['id_travel'];

      // 2. Consulta para obter o grupo da viagem
      final List<Map<String, dynamic>> groupResult = await db.query(
        'groupTravel',
        where: 'id_group = ?',
        whereArgs: [travelMap['id_group']],
      );
      String vehicleType = groupResult.isNotEmpty ? groupResult.first['chooseVehicle'] : '';

      // 3. Consulta para obter as pessoas da viagem
      final List<Map<String, dynamic>> peopleMaps = await db.rawQuery('''
    SELECT P.name, P.date, P.pass, P.path_img FROM people AS P
    INNER JOIN peopleGroup AS PG ON P.id_people = PG.id_people
    WHERE PG.id_group = ?
  ''', [travelMap['id_group']]);

      final List<ModelPeople> peoplesList = peopleMaps.map((p) => ModelPeople(
        Name: p['name'] as String? ?? 'Nome não encontrado',
        Age: p['date'] as String? ?? '',
        image: p['path_img'] as String? ?? 'assets/user.png', // Tratamento para null
        Password: p['pass'] as String? ?? '',
      )).toList();

      // 4. Consulta para obter os pitstops da viagem com seus endereços
      final List<Map<String, dynamic>> pitstopMaps = await db.rawQuery('''
        SELECT S.id_stop, S.dt_arrive, S.dt_go, S.path_img, S.id_adress, A.lat, A.log
        FROM stop AS S
        INNER JOIN stopTravel AS ST ON S.id_stop = ST.id_stop
        LEFT JOIN adress AS A ON S.id_adress = A.id_adress
        WHERE ST.id_travel = ?
      ''', [travelId]);

      final List<ModelPitstop> pitstopsList = [];
      for (var pitstopMap in pitstopMaps) {
        final int stopId = pitstopMap['id_stop'];
        final double lat = pitstopMap['lat'] != null ? double.parse(pitstopMap['lat'].toString()) : 0.0;
        final double log = pitstopMap['log'] != null ? double.parse(pitstopMap['log'].toString()) : 0.0;

        // 5. Consulta para obter as experiências de cada pitstop (se necessário)
        // final List<Map<String, dynamic>> experienceMaps = await db.rawQuery(...);
        // final Map<String, bool> experiences = {};
        // for (var expMap in experienceMaps) {
        //   experiences[expMap['ds_experience']] = true;
        // }

        pitstopsList.add(
          ModelPitstop(
            idStop: MarkerId(stopId.toString()),
            initDate: pitstopMap['dt_arrive'],
            endDate: pitstopMap['dt_go'],
            image: pitstopMap['path_img'],
            idAdress: pitstopMap['id_adress'],
            position: LatLng(lat, log),
          ),
        );
      }

      loadedTravels.add(
        ModelTravel(
          travelId,
          title: travelMap['title'],
          initDate: travelMap['dt_arrive'],
          endDate: travelMap['dt_go'],
          pitstops: pitstopsList,
          peoples: peoplesList,
          typeVei: vehicleType,
        ),
      );
    }

    travels = loadedTravels;
    notifyListeners();
  }
}

