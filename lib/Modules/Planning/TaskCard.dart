import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Models/Task.dart';

class TaskCard extends StatelessWidget {
  final DocumentSnapshot task;
  final Function press;

  const TaskCard({
    Key key,
    this.task,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: ListTile(
          title: Text(task.data()['name']),
          subtitle: Text(task.data()['type']),
          leading:
              Icon(IconData(task.data()['icon'], fontFamily: 'MaterialIcons')),
          trailing: Icon(Icons.brightness_1,
              size: 15, color: statusColor[task.data()['status']]),
        ));
  }
}
