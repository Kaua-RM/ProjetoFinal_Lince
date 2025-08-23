import "dart:convert";

import "package:http/http.dart" as http;
import "package:projectflite/web/web_url.dart";


void main(){

  WebApi().getLocation("34.4391708", "58.7064573");

}


class WebApi {

  Future<Map<String , dynamic>> getLocation(String lat , String log) async{
    try{
      var response = await http.get(Uri.parse(WebUrl.urlBase(lat, log)));
      if(response.statusCode == 200){
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String , dynamic>;
        print(json["address"]);
        return json["address"];
      }else{
        print(response.statusCode);
        return {};
      }
    }catch (e){
      print("Erro : $e");
      return {};
    }
  }

}