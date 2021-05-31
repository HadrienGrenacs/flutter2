import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Theme/Theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter2/Models/Task.dart';
import 'package:flutter2/Models/User.dart';

class PendingTaskDetails extends StatelessWidget {
  final DocumentSnapshot task;

  const PendingTaskDetails({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppTheme.ZK_Azure, title: Text(task.data()['name'])),
      body: TaskBody(task: task),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
              onPressed: () {
                TaskHelper.updateTask(task.id, 'done').then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Task status updated')));
                  Navigator.pop(context);
                });
              },
              label: new Text('Validate'),
              icon: new Icon(Icons.thumb_up),
              backgroundColor: Colors.green,
              heroTag: null),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
              onPressed: () {
                TaskHelper.updateTask(task.id, 'to_do').then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Task status updated')));
                  Navigator.pop(context);
                });
              },
              label: new Text('Cancel'),
              icon: new Icon(Icons.thumb_down),
              backgroundColor: Colors.red,
              heroTag: null),
        ],
      ),
    );
  }
}

class TaskBody extends StatelessWidget {
  final DocumentSnapshot task;

  const TaskBody({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: UserHelper.getUser(task.data()['user_id']),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError)
          return Center(child: Text('Error: ${snapshot.error}'));

        return Container(
            padding: EdgeInsets.all(16.0),
            child: new ListView(children: [
              ListTile(
                title: Text('Employee'),
                subtitle: Text(
                    '${snapshot.data.data()['name']} / ${snapshot.data.data()['email']}'),
                leading: Icon(Icons.account_circle),
              ),
              ListTile(
                title: Text('Task name'),
                subtitle: Text(task.data()['name']),
                leading: Icon(Icons.drive_file_rename_outline),
              ),
              ListTile(
                title: Text('Description'),
                subtitle: Text(task.data()['description']),
                leading: Icon(Icons.description),
              ),
              ListTile(
                title: Text('Type'),
                subtitle: Text(task.data()['type']),
                leading: Icon(Icons.file_copy),
              ),
              ListTile(
                title: Text('Planning'),
                subtitle: Text(
                    '${DateFormat.yMd().add_jm().format(task.data()['starting'].toDate())} > ${DateFormat.yMd().add_jm().format(task.data()['end'].toDate())}'),
                leading: Icon(Icons.calendar_today),
              ),
              ListTile(
                title: Text('Status'),
                subtitle: Text('Pending'),
                leading: Icon(Icons.pending),
                trailing:
                    Icon(Icons.brightness_1, size: 15, color: Colors.orange),
              )
            ]));
      },
    );
  }
}
