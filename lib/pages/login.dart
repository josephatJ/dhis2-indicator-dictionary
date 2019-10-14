import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

TextEditingController instanceController = new TextEditingController()
  ..text = "https://play.dhis2.org/2.29";
TextEditingController usernameController = new TextEditingController()
  ..text = "admin";
TextEditingController passwordController = new TextEditingController()
  ..text = "district";

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final instanceField = TextField(
      controller: instanceController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Address"),
    );

    final usernameField = TextField(
      controller: usernameController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username"),
    );

    final passwordField = TextFormField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password"),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          print({
            "username": usernameController.text,
            "password": passwordController.text
          });
          final instanceAddress = instanceController.text;
          final username = usernameController.text;
          final password = passwordController.text;
          final credentials = '$username:$password';
          final stringToBase64 = utf8.fuse(base64);
          final encodedCredentials = stringToBase64.encode(credentials);
          Map<String, String> headers = {
            HttpHeaders.contentTypeHeader: "application/json", // or whatever
            HttpHeaders.authorizationHeader: "Basic $encodedCredentials",
          };
          var response = http.get(
              instanceAddress + "/api/indicators.json?paging=false",
              headers: headers);
          response.then((onValue) {
            var data = onValue.body;
            var statusCode = onValue.statusCode;
            if (statusCode.toString() == "200") {
              print("here");
              Navigator.pushNamed(context, '/home', arguments: {
                username: username,
                password: password,
                instanceAddress: instanceAddress,
                data: data
              });
            }
            // print("data => " + data.toString());
          });
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                instanceField,
                SizedBox(height: 25.0),
                usernameField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
