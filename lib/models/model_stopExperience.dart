
class ModelStopexperience {
  late int id_stop;
  late int id_experience;

  ModelStopexperience({required this.id_stop , required this.id_experience});

  factory ModelStopexperience.fromMap(Map<String, dynamic> map){
    return ModelStopexperience(id_stop: map['id_stop'], id_experience: map['id_travel']);
  }
}