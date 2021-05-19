import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter2/Models/Task.dart';
import 'package:flutter2/Theme/Theme.dart';

class TaskDetails extends StatelessWidget {
  final DocumentSnapshot task;

  const TaskDetails({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppTheme.ZK_Azure, title: Text(task.data()['name'])),
      body: TaskBody(task: task),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Validate'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class TaskBody extends StatelessWidget {
  final DocumentSnapshot task;

  const TaskBody({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "From: " + "${task.data()['starting'].toLocal()}".split(' ')[1],
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "To: " + "${task.data()['end'].toLocal()}".split(' ')[1],
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold),
              ),
              Container(
                  width: (MediaQuery.of(context).size.width),
                  height: (MediaQuery.of(context).size.height * .50),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(task.data()['description'])))
            ]));
  }
}
