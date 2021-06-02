import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Theme/Theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter2/Models/Task.dart';

class TaskDetails extends StatefulWidget {
  final DocumentSnapshot task;

  const TaskDetails({Key key, this.task}) : super(key: key);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  String status;

  @override
  void initState() {
    super.initState();
    status = widget.task.data()['status'];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppTheme.ZK_Azure,
          title: Text(widget.task.data()['name'])),
      body: TaskBody(task: widget.task, status: status),
      floatingActionButton: Visibility(
        visible: widget.task.data()['status'] != 'done',
        child: FloatingActionButton.extended(
          onPressed: () {
            TaskHelper.updateTask(widget.task.id, statusAction[status])
                .then((value) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Task status updated')));
              setState(() {
                status = statusAction[status];
              });
              // Navigator.pop(context);
            });
          },
          label: new Text(statusActionText[status]),
          icon: new Icon(statusActionIcon[status]),
          backgroundColor: statusActionColor[status],
        ),
      ),
    );
  }
}

class TaskBody extends StatelessWidget {
  final DocumentSnapshot task;
  final String status;

  const TaskBody({Key key, this.task, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Text(
            "From: " +
                "${DateFormat.jm().format(task.data()['starting'].toDate())}",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.bold),
          ),
          Text(
            "To: " + "${DateFormat.jm().format(task.data()['end'].toDate())}",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text('Status: ${statusName[status]}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold)),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.brightness_1, size: 20, color: statusColor[status]),
            ],
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
