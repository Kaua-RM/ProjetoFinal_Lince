import 'package:flutter/material.dart';
import 'package:projectflite/presentation/routes.dart';
import 'package:projectflite/presentation/theme_background.dart';
import 'package:provider/provider.dart';
import '../controllers/controller_moodapp.dart';

Widget routesButtons(BuildContext context){

  var changeMood = Provider.of<MoodsApp>(context);

  
  if(changeMood.isLight == true) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border(
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Background().white(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: () => Routes.routeHome(context),
              icon: Icon(Icons.home)),
          IconButton(onPressed: () => Routes.routeForm(context),
              icon: Icon(Icons.travel_explore)),
        ],
      ),
    );
  }else{
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border(
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromRGBO(0, 0, 0, 0.60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: () => Routes.routeHome(context),
              icon: Icon(Icons.home) , color: Background().white(),),
          IconButton(onPressed: () => Routes.routeForm(context),
              icon: Icon(Icons.travel_explore , color: Background().white())),
          IconButton(onPressed: () => Routes.routeBook(context),
              icon: Icon(Icons.camera_alt_outlined) , color: Background().white()),
        ],
      ),
    );
  }
}