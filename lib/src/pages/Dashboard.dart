import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/Profile.dart';
import 'package:http/http.dart' as http;
import 'models/User.dart';

class Dashboard extends StatelessWidget {
  //Aqui se cosumiria el servicio
  User user;
  String name;
  String lastName;
  String phone;
  String address;
  String token;
  int userID;
  String userEmail;
  double fieldWidth = 350;
  bool hasLoggedIn = false;
  var url = 'http://34.239.109.204/api/v1/profile/profile_list/';

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

  String verifyName(String text) {
    RegExp regExp = new RegExp(r'[/^[a-zA-Z\s]*$/]');
    if (regExp.hasMatch(text)) {
      return null;
    } else {
      return "Nombre invalido";
    }
  }

  String verifyLastName(String text) {
    RegExp regExp = new RegExp(r'[/^[a-zA-Z\s]*$/]');
    if (regExp.hasMatch(text)) {
      return null;
    } else {
      return "Ingresion no valida";
    }
  }

  String verifyPhoneNumber(String text) {
    if (text.length >= 10) {
      RegExp regExp = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
      if (regExp.hasMatch(text)) {
        return null;
      } else {
        return "Numero invalido";
      }
    } else {
      return "Debe contener 10 digitos";
    }
  }

  String verifyaddress(String text) {
    RegExp regExp = new RegExp(r"[\w\[\]`!@#$%\^&*()={}:;<>+'-]*");
    if (regExp.hasMatch(text)) {
      return null;
    } else {
      return "Direccion invalida";
    }
  }

  Dashboard({this.user}) {
    if (user != null) {
      hasLoggedIn = true;
    }
  }

  void updateProfile(BuildContext context) {
    hasLoggedIn = true;
    userID = user.userid;
    userEmail = user.username;
    token = user.token;
    register(name, lastName, phone, address, userID, userEmail, token, context);
    print(
        "Nombre: $name Apellido: $lastName Tel: $phone Direcc: $address Email: $userEmail");
  }

  void register(String name, String lastName, String phone, String address,
      int id, String email, String token, BuildContext context) async {
    Map<String, String> requestHeaders = {
      'Authorization': 'Token $token',
      'Content-type': 'application/json'
    };
    final msg = jsonEncode({
      'name': name,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'user': id,
      'email': email
    });
    var response = await http.post(url, headers: requestHeaders, body: msg);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      showToast(context, "Registro exitoso");
    } else {
      showToast(context, "Ha ocurrido un error");
    }
  }

  void redirectProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfilePage(
                user: user,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!hasLoggedIn) {
      Navigator.pop(context);
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(130, 130, 130, 1),
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Color.fromRGBO(120, 120, 0, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: fieldWidth,
                    height: 80,
                    child: TextFormField(
                      onChanged: (value) => name = value,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          fillColor: Colors.white,
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: 'Name'),
                      //validator: (text) {
                      //return verifyName(text);
                      // },
                    )),
                SizedBox(height: 10),
                Container(
                    width: fieldWidth,
                    height: 80,
                    child: TextFormField(
                      onChanged: (value) => lastName = value,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          fillColor: Colors.white,
                          hintText: "Last Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: 'Last Name'),
                      //validator: (text) {
                      //return verifyLastName(text);
                      //},
                    )),
                SizedBox(height: 10),
                Container(
                    width: fieldWidth,
                    height: 80,
                    child: TextFormField(
                      onChanged: (value) => phone = value,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          fillColor: Colors.white,
                          hintText: "Phone",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: 'Phone'),
                      //validator: (text) {
                      //return verifyPhoneNumber(text);
                      //},
                    )),
                SizedBox(height: 10),
                Container(
                    width: fieldWidth,
                    height: 80,
                    child: TextFormField(
                      onChanged: (value) => address = value,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          fillColor: Colors.white,
                          hintText: "address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: 'address'),
                      //validator: (text) {
                      // return verifyaddress(text);
                      //},
                    )),
                Container(
                    width: fieldWidth,
                    height: 40,
                    margin: EdgeInsets.all(25),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'Siguente',
                        style: TextStyle(fontSize: 12.0),
                      ),
                      color: Color.fromRGBO(120, 120, 0, 1),
                      textColor: Colors.white,
                      onPressed: () {
                        print("Valido!");
                        updateProfile(context);
                        redirectProfile(context);
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
