import 'package:flutter/cupertino.dart';
import 'package:projectflite/database/db.dart';
import 'package:projectflite/models/model_people.dart';
import 'package:sqflite/sqflite.dart';

class ControllerPeoples  extends ChangeNotifier{

  late Database db;

  bool _isInitialized = false;

  ControllerPeoples() {
    _initRepository();
  }


  _initRepository() async {
    db = await DB.instance.database;
    _isInitialized = true;
  }


  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await _initRepository();
    }
  }

  List<ModelPeople> people = [];

  void addPeople(String name ,String years ,String pass ,  String image) async{

    people.add(ModelPeople(Name: name, Age: years,Password: pass ,image: image));

    notifyListeners();
  }


  Future<List<ModelPeople>> getPeople() async{
    var query = await db.query('people');
    return query.map((e) => ModelPeople.fromMap(e)).toList();
  }

  Future<List<ModelPeople>> findUserByNameAndAge(String name, String pass) async {
    // CORREÇÃO: Aguarde a inicialização do banco de dados
    await _ensureInitialized();

    final result = await db.query(
      'people',
      where: 'name = ? AND pass = ?', // Usando 'date' como campo para a idade/anos
      whereArgs: [name, pass],
      limit: 1,
    );

    return result.map((e) => ModelPeople.fromMap(e)).toList();
  }

}