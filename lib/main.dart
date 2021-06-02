import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'navbar.dart';

// ignore: unused_element
Widget _defaultHome = new LoginScreen();

void main() async {
  _defaultHome = HomePage();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
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
                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users_roles")
                          .where('user_id', isEqualTo: user.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final userRole = snapshot.data.docs.first['role_id'];
                          print(userRole);
                          if (userRole == '8FxDRBZEw6Y8H3ApNVtl' ||
                              userRole == 'f1c93yXH0JFwHPcVbcdW') {
                            return ManagerHomePage();
                          } else {
                            return HomePage();
                          }
                        } else {
                          return Material(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    );
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
