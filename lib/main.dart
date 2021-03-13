import 'package:flutter/material.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Jaza corp',
      home: LoginList(),
      routes: <String,WidgetBuilder(

      )>,
    );
  }
}