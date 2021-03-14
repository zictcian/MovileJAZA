import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:http/http.dart' as http;

class register extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

    void addData() {
    var url = "http://192.168.100.6/jaza/adddata.php";

    http.post(url, body: {
      "email": emailController.text,
      "password": passwordController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Login())),
            ),
            backgroundColor: Color.fromRGBO(255, 255, 255,1.0),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(  
                padding: EdgeInsets.all(15)
              ),
              ListTile(
                title: Text("Create Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,   // This is not so important
                  ),
                ),
                subtitle: Text("Create new account",textAlign: TextAlign.center,),
              ),
              Padding(  
                padding: EdgeInsets.all(30)
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'EMAIL',
                    fillColor: Colors.white,
                    filled: true),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    labelText: 'PASSWORD',
                    fillColor: Colors.white,
                    filled: true),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  obscureText: true,
                  controller: passwordConfirmController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    labelText: 'CONFIRM PASSWORD',
                    fillColor: Colors.white,
                    filled: true),
                ),
              ),
              ButtonTheme(
                minWidth: 300,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Color.fromRGBO(48,194,139,1.0),
                  child: Text('Register'),
                  onPressed: () {
                    var contrasenia = passwordController.text;
                    var contrasenia2 = passwordConfirmController.text;
                    if(contrasenia == contrasenia2) {
                      addData();
                      emailController.clear();
                      passwordController.clear();
                      passwordConfirmController.clear();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    }else{
                      showDialog(
                        context: context,
                        builder: (buildcontext) {
                          return AlertDialog(
                            title: Text("ERROR"),
                            content: Text("Las contraseñas no coiciden"),
                            actions: <Widget>[
                              RaisedButton(
                                textColor: Colors.white,
                                color: Color.fromRGBO(48,194,139,1.0),
                                child: Text("Aceptar", style: TextStyle(color: Colors.white),),
                                onPressed: (){ Navigator.of(context).pop(); },
                              )
                            ],
                          );
                        }
                      );
                    }
                  },
                ),
              ),
            ],
          ),
      ),
    backgroundColor: Color.fromRGBO(255, 255, 255,1.0)
    );
  }
}
