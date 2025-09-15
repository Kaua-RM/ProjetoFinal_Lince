class ModelGroup {
  int? id_group;
  String ch_vehicle;

  ModelGroup({this.id_group, required this.ch_vehicle});

  factory ModelGroup.fromMap(Map<String, dynamic> map) {
    return ModelGroup(
      id_group: map['id_group'],
      ch_vehicle: map['chooseVehicle'],
    );
  }
}
