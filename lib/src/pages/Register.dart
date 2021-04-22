import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  String username;
  String password;
  String confirmPassword;
  double fieldWidth = 350;

  var url = 'http://34.239.109.204/api/v1/registration/';

  final emailField = GlobalKey<FormState>();

  void showToast(BuildContext contexto, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(contexto).showSnackBar(snackBar);
  }

  /*void previousPage(BuildContext context) {
    Navigator.pop(context);
  }*/

  String verifyEmail(String text) {
    RegExp regExp = new RegExp(r"[\w]+@[\w]+['.'][\w]+");
    if (regExp.hasMatch(text)) {
      return null;
    } else {
      return "Corrreo invalido";
    }
  }

  String verifyPassword(String text) {
    if (text.length >= 8) {
      return null;
    } else {
      return "Contraseña muy corta";
    }
  }

  void login(BuildContext context) {
    if (password == confirmPassword) {
      register(username, password, confirmPassword, context);
    } else if (password != confirmPassword) {
      showToast(context, "Las contraseñas no coinciden");
    } else {
      showToast(context, "Ho acaba de ocurrir un error al subir");
    }
  }

  void register(String username, String password1, String password2,
      BuildContext context) async {
    var response = await http.post(url, body: {
      'username': username,
      'password1': password1,
      'password2': password2
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      print("OK");
      showToast(context, "Usuario creado");
    } else {
      showToast(context, "Error de creacion");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(130, 130, 130, 1),
      body: SingleChildScrollView(
          child: Container(
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
                            "Registro",
                            style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("Rellena todos tus datos",
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
                          onChanged: (value) => username = value,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_rounded),
                              fillColor: Colors.blue,
                              hintText: "Correo",
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
                            onChanged: (value) => password = value,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_rounded),
                                fillColor: Colors.blue,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                labelText: 'Password'),
                            validator: (text) {
                              return verifyPassword(text);
                            })),
                    SizedBox(height: 10),
                    Container(
                        width: fieldWidth,
                        height: 80,
                        child: TextFormField(
                            onChanged: (value) => confirmPassword = value,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_rounded),
                                fillColor: Colors.white,
                                hintText: "Confirmacion Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                labelText: 'Confirmacion Password'),
                            validator: (text) {
                              return verifyPassword(text);
                            })),
                    Container(
                        width: fieldWidth,
                        height: 40,
                        margin: EdgeInsets.all(25),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(
                            'Siguiente',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          color: Color.fromRGBO(120, 120, 0, 1),
                          textColor: Colors.white,
                          onPressed: () {
                            if (emailField.currentState.validate()) {
                              login(context);
                            }
                          },
                        )),
                  ],
                ),
              ))),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
