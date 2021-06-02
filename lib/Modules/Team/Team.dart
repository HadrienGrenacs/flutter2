import 'package:flutter/material.dart';
import 'package:flutter2/Theme/Theme.dart';
import 'package:flutter2/Modules/Team/TeamList.dart';

class Team extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Team'),
        backgroundColor: AppTheme.ZK_Azure,
      ),
      body: TeamList(),
    );
  }
}
