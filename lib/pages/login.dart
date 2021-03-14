import 'package:flutter/material.dart';

class LoginList extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginList())),
            ),
            backgroundColor: Color.fromRGBO(255, 255, 255,1.0),
        )
    );
  }
}