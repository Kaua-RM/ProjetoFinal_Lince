import 'package:http/http.dart' as http;



class WebUrl {
  static String urlBase(String lat , String log) => "https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$log&format=json";
 /// static String urlSearc(String city , String country) => "https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$log&format=json";
}