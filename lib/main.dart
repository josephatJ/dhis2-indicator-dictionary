import 'package:DHIS2Dictionary/pages/home.dart';
import 'package:DHIS2Dictionary/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    title: '',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => LoginPage(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/home': (context) => HomePage(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DHIS2 Indicator Dictionary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: 'Login'),
    );
  }
}
