import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_application_1/pages/login.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
=======

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{
>>>>>>> 5287739824252159f8ab08fc5a3567be2633e44c
  @override
  Widget build(BuildContext context){
    return MaterialApp(
<<<<<<< HEAD
      home: Center(child: Login()),
=======
      title: 'Jaza corp',
      home: LoginList(),
      routes: <String,WidgetBuilder(

      )>,
>>>>>>> 5287739824252159f8ab08fc5a3567be2633e44c
    );
  }
}