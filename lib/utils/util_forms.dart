import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectflite/presentation/theme_background.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_languageapp.dart';
import '../l10n/app_localizations_en.dart';
import '../l10n/app_localizations_es.dart';
import '../l10n/app_localizations_pt.dart';



Widget title(){
  return Column(
    children: [
      Text("Titulo"),
      TextFormField()
    ],
  );
}

Widget Dates(BuildContext context , String title){
  return Column(
    children: [
      Column(
        children: [
          Text(title),
      TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.date_range_outlined),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
          ),
        ),
        onTap: () { selectdate(context); },
      )]),
    ],
  );
}

Widget participants( BuildContext context){
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Background().white()
    ),
    child: Column(children: [
      Row(
        children: [
          Text("Adicionar Participantes"),
          IconButton(onPressed: () => openModalUser(context), icon: Icon(Icons.add_circle_outline))
        ],
      )
    ],),
  );
}


Widget meansTransports(BuildContext context){
  return DropdownButton(items: meansTransport.map((e) {
    return DropdownMenuItem(key: ValueKey(e), value: e,  child: Text(e));
  },).toList(), onChanged: (value) {
  },);
}

Widget experiences(BuildContext context){
  return DropdownButton(items: experinces.map((e) {
    return DropdownMenuItem(key: ValueKey(e), value: e,  child: Text(e));
  },).toList(), onChanged: (value) {
  },);
}


Widget pitstop(BuildContext context){
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: Background().white()
    ),
    child: Column(children: [
      Row(
        children: [
          Text("Adicionar Parada"),
          IconButton(onPressed: () => openModalPitStop(context), icon: Icon(Icons.add_circle_outline))
        ],
      )
    ],),
  );
}



Future<void> selectdate(BuildContext context) async{
   await showDatePicker(context: context, initialDate: DateTime.now() , firstDate: DateTime(2025), lastDate: DateTime(2100));
}



List<String> meansTransport = ["Carro","Moto","Onibus","Aviao","Cruzeiro"];

List<String> experinces = ["Conhecer novas culturas","Experimentar novas culinarias","Visitar locais historicos","Visitar Estabelecimentos"];


void openModalUser( BuildContext context){
  showModalBottomSheet(context: context, builder: (context) => Container(
    width: double.infinity,

    child: Column(
      children: [
        Text("Adicionar Participante"),
        Column(children: [
          Text("Nome"),
          TextFormField(),
          Text("Idade"),
          TextFormField(),
          Row(
            children: [
              TextButton(onPressed: () => "", child: Text("Cancelar")),
              OutlinedButton(onPressed: () => "", child: Text("Ok"))
            ],
          )
        ],)
      ],
    ),
  ));
}


void openModalPitStop( BuildContext context){
  showModalBottomSheet(context: context, builder: (context) => Container(
    width: double.infinity,
    child: Column(
      children: [

      ],
    ),
  ));
}