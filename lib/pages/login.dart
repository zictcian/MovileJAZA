
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatelessWidget {
var fail = 0;
final navigatorKey = GlobalKey<NavigatorState>();

TextEditingController email = new TextEditingController();
TextEditingController pass = new TextEditingController();
Future<List> _login() async {
  final response = await http.post("http://192.168.100.6/jaza/login.php", body: {
    "email": email.text,
    "password": pass.text,

  });
  fail = 0;
  var datauser;
  if (response.statusCode == 200) {
        datauser = json.decode(response.body);
        print("Conexion exitosa");
    } else {
       print('Error de conexion');
       fail = 1;
    }
  if(datauser.length == 0){
    fail = 1;
  }else{
    fail = 0;
  }
  return datauser;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle_outlined,
                        size: 160.0,
                        color: Colors.grey,
                        ),
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "Sign to continue",
                          style: 
                            TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                            ),
                        )
                      ),
                      
                      SizedBox(height: 30.0),
                      _email(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _password(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Color.fromRGBO(50, 205, 50, 1.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () async {
                            await _login();
                              if(fail == 1){
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('ERROR'),
                                      content: Text(
                                          'usuario y/o contraseña incorrecto'),
                                      actions: <Widget>[
                                        new FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: new Text('ok'))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          padding: EdgeInsets.all(15.0),
                          color: Color.fromRGBO(48, 194, 139, 1.0),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white ,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      _signUpButton()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Email
  Widget _email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.grey,
              ),
              hintText: 'Enter your Email',
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: pass,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              hintText: 'PASSWORD',
            ),
          ),
        ),
      ],
    );
  }

  Widget _signUpButton() {
    return GestureDetector(
      onTap: () => print('Aqui va el metodo de andy'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,

              ),
            ),
            TextSpan(
              text: 'create a new account',
              style: TextStyle(
                color: Color.fromRGBO(50, 205, 50, 1.0),
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

}