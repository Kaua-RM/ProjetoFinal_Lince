
class ModelPeople {
  int? id_people;
  String Name;
  String Password;
  String Age;
  String  image;

  ModelPeople({this.id_people, required this.Name, required this.Age , required this.Password , required this.image});

  factory ModelPeople.fromMap(Map<String, dynamic> map) {
    return ModelPeople(
      id_people: map['id_people'],
      Name: map['name'],
      Age: map['date'],
      Password: map['pass'],
      image: map['path_img'],
    );
  }
}

