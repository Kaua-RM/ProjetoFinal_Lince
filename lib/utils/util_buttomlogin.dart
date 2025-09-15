import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_languageapp.dart';
import '../controllers/controller_peoples.dart';
import '../l10n/app_localizations_en.dart';
import '../l10n/app_localizations_es.dart';
import '../l10n/app_localizations_pt.dart';
import '../presentation/routes.dart';
import '../presentation/theme_background.dart';

Widget buttomLogin(BuildContext context , String name , String pass ){

  String language =  Provider.of<ChangeLanguage>(context).chooseLanguage;
  if(language == "pt"){
    return Buttom(AppLocalizationsPt().buttomLogin, context , name , pass);
  }else if(language == "en"){
    return Buttom(AppLocalizationsEn().buttomLogin, context , name , pass);
  }else{
    return Buttom(AppLocalizationsEs().buttomLogin, context , name , pass);
  }
}


Widget Buttom(String text, BuildContext context, String name, String pass) {
  return ElevatedButton(
    onPressed: () async {
      final consumerPeople = Provider.of<ControllerPeoples>(context, listen: false);

      // Aguarda o resultado da busca de usuário.
      final peopleList = await consumerPeople.findUserByNameAndAge(name, pass);

      // Verificação correta: se a lista estiver vazia, o login falhou.
      if (peopleList == []) {
        // Login FALHOU
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login ou senha inválidos.')),
        );
        // Não navega para a home se o login falhar.
      } else {
        // Login BEM-SUCEDIDO: a lista não está vazia.
        Routes.routeHome(context); // Navega para a home APENAS se o login for bem-sucedido.
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Background().strongBlue(),
    ),
    child: Text(
      text,
      style: TextStyle(color: Background().orangeYellow(), fontSize: 18),
    ),
  );
}