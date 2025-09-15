

class ModelStoptravel {

  late int id_stop;
  late int id_travel;


  ModelStoptravel({required this.id_stop , required this.id_travel});

  factory ModelStoptravel.fromMap(Map<String, dynamic> map){
    return ModelStoptravel(id_stop: map['id_stop'], id_travel: map['id_experience']);
  }
}