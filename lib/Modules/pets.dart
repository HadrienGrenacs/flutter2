import 'package:flutter/material.dart';

class Pets extends StatefulWidget {
  const Pets();

  @override
  _PetsState createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Pets'),
    );
  }
}