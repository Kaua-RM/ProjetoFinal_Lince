import 'package:flutter/material.dart';
import 'package:projectflite/presentation/presentation_booklet.dart';
import 'package:projectflite/presentation/presentation_forms.dart';
import 'package:projectflite/presentation/presentation_home.dart';

class Routes {

  static routeHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => PresentationHome()),
  );

  static routeForm(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => PresentationForms(),
  )
  );

  static routeBook(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PresentationBooklet(),
      )
  );

}
