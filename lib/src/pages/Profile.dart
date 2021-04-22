import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'models/User.dart';
import 'dart:async';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  static User user;
  static int userID;
  static String token;
  static bool hasLoggedIn = false;
  ProfilePage({user}) {
    if (user != null) {
      hasLoggedIn = true;
      userID = user.userid;
      token = user.token;
    }
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ProfilePage> {
  Future<Data> futureAlbum;
  int userID = ProfilePage.userID;
  String token = ProfilePage.token;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil de usuario',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color.fromRGBO(120, 120, 0, 1),
        ),
        body: Center(
          child: FutureBuilder<List<Data>>(
            future: fetchData(userID, token),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? DataList(datas: snapshot.data)
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

Future<List<Data>> fetchData(int userID, String token) async {
  var uri = Uri.http('34.239.109.204', 'api/v1/profile/profile_detail/$userID');
  Map<String, String> requestHeaders = {
    'Authorization': 'Token $token',
    'Content-type': 'application/json'
  };
  final response = await http.get(uri, headers: requestHeaders);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseData, response.body);
  } else {
    print('Response status: ${response.statusCode}');
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

List<Data> parseData(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Data>((json) => Data.fromJson(json)).toList();
}

class Data {
  final int id;
  final String name;
  final String lastName;
  final String phone;
  final String address;
  final String email;
  final int user;
  Data(
      {this.id,
      this.name,
      this.lastName,
      this.phone,
      this.address,
      this.email,
      this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        id: json['id'] as int,
        name: json['name'] as String,
        lastName: json['lastName'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String,
        email: json['email'] as String,
        user: json['user'] as int);
  }
}

class DataList extends StatelessWidget {
  final List<Data> datas;
  DataList({Key key, this.datas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(
            height: 200,
          ),
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.amber[600],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white)),
                        color: Colors.amber[600],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          datas[0].name + " " + datas[0].lastName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Usuario",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Direccion: " + (datas[0].address).toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Telefono: " + datas[0].phone,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blue),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Correo: " + datas[0].email,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ])),
      ],
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
