import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{

  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async{
    if(_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async{
    return await openDatabase(
      join(await getDatabasesPath() , 'flite.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate( Database db ,int  versao) async{
    await db.execute(_people);
    await db.execute(_group);
    await db.execute(_adress);
    await db.execute(_experience);
    await db.execute(_stop);
    await db.execute(_travel);
    await db.execute(_peopleGroup);
    await db.execute(_stopTravel);
    await db.execute(_stopExperience);
    await db.execute(_avalition);
    await db.execute(_image);
    await db.insert('people', {
      'name':'adm',
      'date':'2000-09-12',
      'pass':'adm',
      'path_img':'assets/user.png'});
  }

  String get _people => '''
   CREATE TABLE people(
   id_people INTEGER PRIMARY KEY AUTOINCREMENT,
   name      TEXT NOT NULL,
   date      TEXT NOT NULL,
   pass      TEXT NOT NULL,
   path_img  TEXT NOT NULL
   ); 
   ''';



  String get _group => '''
   CREATE TABLE groupTravel(
   id_group       INTEGER PRIMARY KEY AUTOINCREMENT,
   chooseVehicle  TEXT    NOT NULL
   ); 
   ''';

  String get _adress => '''
   CREATE TABLE adress(
   id_adress   INTEGER PRIMARY KEY AUTOINCREMENT,
   city        TEXT    NOT NULL,
   state       TEXT    NOT NULL,
   country     TEXT    NOT NULL,
   lat         REAL    NOT NULL,
   log         REAL    NOT NULL
   ); 
   ''';

  String get _experience => '''
   CREATE TABLE experience(
   id_experience  INTEGER PRIMARY KEY AUTOINCREMENT,
   ds_experience  TEXT    NOT NULL
   ); 
   ''';

  String get _stop => '''
   CREATE TABLE stop(
   id_stop  INTEGER PRIMARY KEY AUTOINCREMENT,
   dt_arrive      TEXT NOT NULL,
   dt_go          TEXT NOT NULL,
   path_img       TEXT NOT NULL,
   id_adress      INTEGER NOT NULL
   ); 
   ''';

  String get _travel =>'''
   CREATE TABLE travel(
   id_travel  INTEGER PRIMARY KEY AUTOINCREMENT,
   title      TEXT,
   dt_arrive  TEXT,
   dt_go      TEXT,
   id_group   INTEGER
   ); 
   ''';

  String get _avalition => '''
   CREATE TABLE avalition(
   id_avalition  INTEGER PRIMARY KEY AUTOINCREMENT,
   descripition      TEXT,
   score  TEXT,
   id_stop INTEGER
   ); 
   ''';

  String get _stopTravel => '''
   CREATE TABLE stopTravel(
   id_stop        INTEGER,
   id_travel      INTEGER
   ); 
   ''';

  String get _stopExperience => '''
   CREATE TABLE stopExperience(
   id_stop        INTEGER,
   id_experience  INTEGER
   ); 
   ''';


  String get _peopleGroup => '''
   CREATE TABLE peopleGroup(
   id_people INTEGER,
   id_group  INTEGER
   ); 
   ''';


  String get _image => '''
   CREATE TABLE image(
   id_stop INTEGER,
   id_people  INTEGER,
   path       TEXT
   ); 
   ''';






}