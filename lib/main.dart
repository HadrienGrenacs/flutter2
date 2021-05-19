import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Models/Pet.dart';
import 'login.dart';
import 'navbar.dart';

// ignore: unused_element
Widget _defaultHome = new LoginScreen();

void main() async {
  _defaultHome = HomePage();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initilization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initilization,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  User user = snapshot.data;

                  if (user == null) {
                    return LoginScreen();
                  } else {
                    return HomePage();
                  }
                }

                return Scaffold(
                  body: Center(
                    child: Text("Cheking auth ...."),
                  ),
                );
              },
            );
          }

          return Scaffold(
            body: Center(
              child: Text("Connecting to the app..."),
            ),
          );
        });
  }
}
