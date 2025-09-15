class ModelExperience {
  int? id_experience;
  String ds_experience;

  ModelExperience(
     {this.id_experience,
    required this.ds_experience,
  });


  factory ModelExperience.fromMap(Map<String, dynamic> map) {
    return ModelExperience(
        id_experience: map['id_experience'],
        ds_experience: map['ds_experience'],
    );
  }

}
