import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Fact> fetchFact() async {
  final response =
      await http.get(Uri.parse('https://catfact.ninja/fact?max_length=140'));

  if (response.statusCode == 200) {
    print(response.body);
    return Fact.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load fact');
  }
}

class Fact {
  final String fact;

  Fact({
    this.fact,
  });

  factory Fact.fromJson(Map<String, dynamic> json) {
    return Fact(
      fact: json['fact'],
    );
  }
}

class DisplayFact extends StatefulWidget {
  DisplayFact({Key key}) : super(key: key);

  @override
  _DisplayFactState createState() => _DisplayFactState();
}

class _DisplayFactState extends State<DisplayFact> {
  Future<Fact> futureFact;

  @override
  void initState() {
    super.initState();
    futureFact = fetchFact();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Fact>(
        future: futureFact,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                snapshot.data.fact,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
