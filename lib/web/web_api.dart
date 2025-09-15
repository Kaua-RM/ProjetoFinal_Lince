import "dart:convert";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:http/http.dart" as http;
import "package:projectflite/web/web_url.dart";




class WebApi {

  Future<Map<String, dynamic>> getLocation(LatLng position) async {
    try {
      var response = await http.get(
        Uri.parse(WebUrl.urlBase(position)),
        headers: {
          'User-Agent': 'projectflite/1.0.0 (krodriguesmellato@gmail.com)'
        },
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

        if (json.containsKey("address")) {
          return json["address"];
        } else {
          return {};
        }
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

}