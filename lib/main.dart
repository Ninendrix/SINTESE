import 'package:flutter/material.dart';
import 'package:loguinsintese_app/Phome.dart';
import 'package:loguinsintese_app/plogin.dart';




void main (){
  runApp(MaterialApp(
    home: plogin(),
    theme: ThemeData(
      primaryColor: Colors.red,
      accentColor: Colors.red
    ),
    debugShowCheckedModeBanner: false,
  ));


}


