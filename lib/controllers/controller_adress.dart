import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projectflite/database/db.dart';
import 'package:projectflite/models/model_adress.dart';
import 'package:sqflite/sqflite.dart';

class ControllerAdress  extends ChangeNotifier{
  late Database db;
  List<ModelAdress> adress = [];
  Map<LatLng, dynamic> _cache = {};

  ControllerAdress() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
  }

  Future<int> setNewAdress(String city, String state, String country, double lat, double log) async {
    final int id = await db.insert('adress', {
      'city': city,
      'state': state,
      'country': country,
      'lat': lat,
      'log': log,
    });
    adress.add(ModelAdress(idAdress: id, city: city, state: state, country: country, lat: lat, log: log));
    notifyListeners();
    return id;
  }

  // Novo método para adicionar ao cache
  void addToCache(LatLng position, dynamic data) {
    _cache[position] = data;
  }

  // Novo método para obter do cache
  dynamic getFromCache(LatLng position) {
    return _cache[position];
  }

  // Novo método para LIMPAR o cache
  void clearCache() {
    _cache = {};
  }

  Future<List<Map<String, dynamic>>> adressSelect(int idAdress) async {
    final List<Map<String, dynamic>> mapAdress = await db.query(
      'adress',
      where: 'id_adress = ?',
      whereArgs: [idAdress],
    );


    return mapAdress;
  }
}