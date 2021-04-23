import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/Register.dart';
import 'package:flutter_application_1/src/pages/Dashboard.dart';
import 'package:http/http.dart' as http;

import 'models/User.dart';

class Login extends StatelessWidget {
  String apiUrl = "http://34.239.109.204/api/v1/login/";
  String usernameValue;
  String passwordValue;
  double fieldWidth = 350;

  final emailField = GlobalKey<FormState>();

  void showToast(BuildContext contexto, String text) {
    //Sólo para testear (AQUI SE CONSUMIRÍA EL SERVICIO)
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Cerrar',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(contexto).showSnackBar(snackBar);
  }

  void previousPage(BuildContext context) {
    Navigator.pop(context);
  }

  String verifyEmail(String text) {
    RegExp regExp = new RegExp(r"[\w]+@[\w]+['.'][\w]+");
    if (regExp.hasMatch(text)) {
      return null;
    } else {
      return "Correo invalido";
    }
  }

  String verifyPassword(String text) {
    if (text.length >= 8) {
      return null;
    } else {
      return "Contraseña muy corta";
    }
  }

  void login(BuildContext context) async {
    var response = await http.post(apiUrl,
        body: {'username': usernameValue, 'password': passwordValue});

    if (response.statusCode == 200) {
      var body = response.body;
      Map decodedJson = jsonDecode(body);
      User user = User.fromJson(decodedJson);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard(user: user)),
      );
    } else {
      showToast(context, "Valores incorrectos");
    }
  }

  void redirectRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  void redirectForgotPassword(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(233, 224, 207, 1),
      body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.white.withOpacity(0.2), BlendMode.dstATop),
                  image: AssetImage("assets/graphics/background.jfif"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: emailField,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 80,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "APIREST",
                            style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("Inicio de secion",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: fieldWidth,
                        height: 80,
                        child: TextFormField(
                          onChanged: (value) => usernameValue = value,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_rounded),
                              fillColor: Colors.blue,
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              labelText: 'Email'),
                          validator: (text) {
                            return verifyEmail(text);
                          },
                        )),
                    SizedBox(height: 10),
                    Container(
                        width: fieldWidth,
                        height: 80,
                        child: TextFormField(
                            onChanged: (value) => passwordValue = value,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_rounded),
                                fillColor: Color.fromRGBO(76, 0, 23, 1),
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                labelText: 'Contraseña'),
                            validator: (text) {
                              return verifyPassword(text);
                            })),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Container(
                        height: 35,
                        child: TextButton(
                            onPressed: () {
                              //Redireccionamiento al olvidar contraseña
                              redirectForgotPassword(context);
                            },
                            child: Text(
                              "Olvido su contraseña?",
                              style: TextStyle(
                                  color: Color.fromRGBO(76, 0, 23, 1),
                                  fontSize: 16,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ]),
                    Container(
                        width: fieldWidth,
                        height: 40,
                        margin: EdgeInsets.all(25),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            // For border color= side: BorderSide(color: Colors.red)
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          color: Color.fromRGBO(180, 2, 32, 1),
                          textColor: Colors.white,
                          onPressed: () {
                            if (emailField.currentState.validate()) {
                              login(context);
                            }
                          },
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Crear una cuenta",
                            style:
                                TextStyle(fontSize: 16, fontFamily: "Roboto")),
                        TextButton(
                            onPressed: () {
                              //Redireccionamiento al register
                              redirectRegister(context);
                            },
                            child: Text(
                              "Cree su cuenta aqui!",
                              style: TextStyle(
                                  color: Color.fromRGBO(76, 0, 23, 1),
                                  fontSize: 17,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.normal),
                            ))
                      ],
                    ),
                  ],
                ),
              ))),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
