class ModelAdress {
  int? idAdress;
  String city;
  String state;
  String country;
  double lat;
  double log;

  ModelAdress({ this.idAdress, required this.city , required this.state , required this.country , required this.lat , required this.log});

  factory ModelAdress.fromMap(Map<String, dynamic> map) {
    return ModelAdress(
      idAdress: map['id_adress'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      lat: map['lat'],
      log: map['log']
    );
  }

}

