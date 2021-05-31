import 'package:flutter/material.dart';
import 'package:flutter2/Modules/Planning/DatePicker.dart';
import 'package:flutter2/Theme/Theme.dart';

class Planning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Planning'),
        backgroundColor: AppTheme.ZK_Azure,
      ),
      body: DatePicker(),
    );
  }
}
