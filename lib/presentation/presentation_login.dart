import 'package:flutter/material.dart';
import 'package:projectflite/utils/util_backgroundimage.dart';
import 'package:projectflite/utils/util_buttomlogin.dart';
import 'package:projectflite/utils/util_formloginlanguage.dart';
import 'package:projectflite/utils/util_loginlanguage.dart';
import 'package:projectflite/utils/util_topdown.dart';

import '../utils/util_presentation.dart';



class PresentationLogin extends StatefulWidget {
  const PresentationLogin({super.key});

  @override
  State<PresentationLogin> createState() => _PresentationLoginState();
}

class _PresentationLoginState extends State<PresentationLogin> {

  // Declare os controladores como variáveis de estado
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerYears = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImageLogin(context),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      topDown(context),
                      iconLightMode(context),
                    ],
                  ),
                  Image.asset("assets/Logo.png"),
                  textLogin(context),
                  SizedBox(height: 40,),
      Column(
        children: [
          TextFormField(decoration: InputDecoration(hintText: "login") , controller: controllerName,),
          SizedBox(height: 20),
          TextFormField(decoration: InputDecoration(hintText: "pass") , controller:  controllerYears,),
        ],
      ),
                  SizedBox(height: 40,),
                  buttomLogin(context, controllerName.text, controllerYears.text)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
