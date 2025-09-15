import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectflite/database/db.dart';
import 'package:sqflite/sqflite.dart';

class ControllerImage extends ChangeNotifier {
  File? image;
  late Database db;
  late int qtd;
  final ImagePicker picker = ImagePicker();

  ControllerImage() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
  }

  Future<void> getPicker() async {
    final response = await picker.pickImage(source: ImageSource.gallery);
    if (response == null) {
      return;
    } else {
      image = File(response.path);
    }
    notifyListeners();
  }

  Future<void> addImageData(int idpeople, int idstop) async {

    File? imageStop;

    final response = await picker.pickImage(source: ImageSource.gallery);
    if (response == null) {
      return;
    } else {
      imageStop = File(response.path);
    }

    if (idpeople.isNaN || idstop.isNaN) {
      print("Exception is go");
    } else {
      final insert = await db.insert('image', {
        'id_stop': idstop,
        'id_people': idpeople,
        'path': imageStop.path
      });
    }

    notifyListeners();
  }

  Future<List<File>> imagesSelect(int idstop) async {
    final List<Map<String, dynamic>> mapImagens = await db.query(
      'image',
      where: 'id_stop = ?',
      whereArgs: [idstop],
    );

    final List<File> listImagens = mapImagens.map((map) => File(map['path'] as String)).toList();

    qtd = listImagens.length;

    return listImagens;
  }
}