class ModelPeoplegroup {

late int id_people;
late int  id_group ;

ModelPeoplegroup({required this.id_people , required this.id_group});

factory ModelPeoplegroup.fromMap(Map<String, dynamic> map){
  return ModelPeoplegroup(id_people: map['id_people'], id_group: map['id_group']);
}

}