import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'Theme/Theme.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

enum FormType {
  login,
  register,
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType;
  bool _animate;

  @override
  void initState() {
    super.initState();

    _animate = true;
    _formType = FormType.login;

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      if (mounted) {
        setState(() {
          _animate = !_animate;
        });
      }
    });
  }

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Future<void> _createUser() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((user) {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(user.user.uid);
      userRef.set(
          {'email': user.user.email, 'name': user.user.email.split('@')[0]});
      List rightsList = [
        {'type': "USERS_ROLES_READ", 'id': "4XnFCLp5WADadFZCADNC"},
        {'type': "USER_READ", 'id': "hR35ZILf9Rwt3wnDrrsh"},
        {'type': "TASKS_READ", 'id': "NlXL9KyWGL5vXTxx0rQd"},
        {'type': "TASKS_UPDATE", 'id': "tzLuwsi95t0yqnLj9M4F"},
        {'type': "ANIMALS_CREATE", 'id': "uwtIOVhR4gbF5wwyI2V4"},
        {'type': "ANIMALS_UPDATE", 'id': "z1TkyZi3OvhhsmeEICBB"},
        {'type': "ANIMALS_READ", 'id': "QBCAwvDeqSVKsSOp5tD5"},
      ];
      rightsList.forEach((right) {
        DocumentReference userRight = FirebaseFirestore.instance
            .collection("users_right")
            .doc(user.user.uid + "_" + right['id']);
        userRight.set({'right_id': right['id'], 'user_id': user.user.uid});
      });
      DocumentReference userRoles = FirebaseFirestore.instance
          .collection('users_roles')
          .doc(user.user.uid + "_" + "EPl2ABTEs2aoZzRth1MC");
      userRoles
          .set({'user_id': user.user.uid, 'role_id': "EPl2ABTEs2aoZzRth1MC"});
      DocumentReference usersGroups = FirebaseFirestore.instance
          .collection('users_groups')
          .doc(user.user.uid + "_" + "87uq48goyVrRtXZ1xbHl");
      usersGroups
          .set({'user_id': user.user.uid, 'group_id': "87uq48goyVrRtXZ1xbHl"});
    }).catchError((e) {
      throw Exception('$e');
    });
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        // final BaseAuth auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          _login();
        } else {
          _createUser();
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: AppTheme.ZK_Azure, title: Text('Login')),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: buildImage() + buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  buildImage() {
    return <Widget>[
      (Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: AnimatedContainer(
            width: _animate
                ? MediaQuery.of(context).size.height * 0.25
                : MediaQuery.of(context).size.height * 0.20,
            height: _animate
                ? MediaQuery.of(context).size.height * 0.25
                : MediaQuery.of(context).size.height * 0.20,
            child: Image.asset('assets/images/zookeeper.png'),
            duration: Duration(seconds: 2)),
      ))
    ];
  }

  List<Widget> buildInputs() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          key: Key('email'),
          decoration: InputDecoration(labelText: 'Email'),
          validator: EmailFieldValidator.validate,
          onSaved: (String value) => _email = value,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          key: Key('password'),
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: PasswordFieldValidator.validate,
          onSaved: (String value) => _password = value,
        ),
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return <Widget>[
        ElevatedButton(
          key: Key('signIn'),
          child: Text('Login', style: TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        ElevatedButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return <Widget>[
        ElevatedButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        ElevatedButton(
          child:
              Text('Have an account? Login', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter2/Register.dart';
// import 'Theme/Theme.dart';
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   String _email;
//   String _password;
//   bool _animate;

//   @override
//   void initState() {
//     super.initState();

//     _animate = true;

//     Timer.periodic(Duration(seconds: 2), (Timer t) {
//       if (mounted) {
//         setState(() {
//           _animate = !_animate;
//         });
//       }
//     });
//   }

  // Future<void> _login() async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: _email, password: _password);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   } catch (e) {
  //     print("error: $e");
  //   }
  // }

//     Future<void> _createUser() async {
//     FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: _email, password: _password)
//         .then((user) {
//       DocumentReference userRef =
//           FirebaseFirestore.instance.collection('users').doc(user.user.uid);
//       userRef.set({'email': user.user.email, 'name': _name});
//       List rightsList = [
//         {'type': "USER_READ", 'id': "hR35ZILf9Rwt3wnDrrsh"},
//         {'type': "TASKS_READ", 'id': "NlXL9KyWGL5vXTxx0rQd"},
//         {'type': "TASKS_UPDATE", 'id': "tzLuwsi95t0yqnLj9M4F"},
//         {'type': "ANIMALS_CREATE", 'id': "uwtIOVhR4gbF5wwyI2V4"},
//         {'type': "ANIMALS_UPDATE", 'id': "z1TkyZi3OvhhsmeEICBB"},
//         {'type': "ANIMALS_READ", 'id': "QBCAwvDeqSVKsSOp5tD5"},
//         {'type': "USERS_ROLES_READ", 'id': "4XnFCLp5WADadFZCADNC"},
//       ];
//       rightsList.forEach((right) {
//         print(right['id']);
//         DocumentReference userRight = FirebaseFirestore.instance
//             .collection("users_right")
//             .doc(user.user.uid + "_" + right['id']);
//         userRight.set({'right_id': right['id'], 'user_id': user.user.uid});
//       });
//       DocumentReference userRoles = FirebaseFirestore.instance
//           .collection('users_roles')
//           .doc(user.user.uid + "_" + "EPl2ABTEs2aoZzRth1MC");
//       userRoles
//           .set({'user_id': user.user.uid, 'role_id': "EPl2ABTEs2aoZzRth1MC"});
//       DocumentReference usersGroups = FirebaseFirestore.instance
//           .collection('users_groups')
//           .doc(user.user.uid + "_" + "87uq48goyVrRtXZ1xbHl");
//       usersGroups
//           .set({'user_id': user.user.uid, 'group_id': "87uq48goyVrRtXZ1xbHl"});
//     }).catchError((e) {
//       throw Exception('$e');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(backgroundColor: AppTheme.ZK_Azure, title: Text('Login')),
//       body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.25,
//                 child: AnimatedContainer(
//                     width: _animate
//                         ? MediaQuery.of(context).size.height * 0.25
//                         : MediaQuery.of(context).size.height * 0.20,
//                     height: _animate
//                         ? MediaQuery.of(context).size.height * 0.25
//                         : MediaQuery.of(context).size.height * 0.20,
//                     child: Image.asset('assets/images/zookeeper.png'),
//                     duration: Duration(seconds: 2)),
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                     labelText: 'Email', border: OutlineInputBorder()),
//                 onChanged: (value) => setState(() => _email = value),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: InputDecoration(
//                     labelText: 'Password', border: OutlineInputBorder()),
//                 onChanged: (value) => setState(() => _password = value),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 26.0,
//               ),
//               Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(AppTheme.ZK_Azure),
//                   ),
//                   onPressed: _login,
//                   child: Text("Sign in"),
//                 ),
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(AppTheme.ZK_Olive),
//                   ),
//                   onPressed: () {
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context) => Register()));
//                   },
//                   child: Text("Sign up"),
//                 ),
//               ]),
//             ],
//           )),
//     );
//   }
// }
