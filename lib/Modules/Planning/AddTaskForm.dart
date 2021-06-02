import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Theme/Theme.dart';
import 'package:flutter2/Components/DropdownInput.dart';
import 'package:flutter2/Components/DateTimeField.dart';
import 'package:flutter2/Models/Task.dart';

class AddTaskForm extends StatelessWidget {
  final DocumentSnapshot member;

  const AddTaskForm({Key key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Add a task';

    return Scaffold(
      appBar: AppBar(backgroundColor: AppTheme.ZK_Azure, title: Text(appTitle)),
      body: TaskForm(member: member),
    );
  }
}

class TaskForm extends StatefulWidget {
  final DocumentSnapshot member;
  const TaskForm({Key key, this.member}) : super(key: key);

  @override
  TaskFormState createState() {
    return TaskFormState();
  }
}

class TaskFormState extends State<TaskForm> {
  String type;
  DateTime starting;
  DateTime end;
  String user_id;
  String name;
  String description;
  int icon;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          buildName(),
          const SizedBox(height: 16),
          AppDropdownInput(
            hintText: "Type",
            options: ["Feeding", "Other", "Cleaning", "Reception"],
            value: type,
            onChanged: (String value) {
              setState(() {
                type = value;
              });
            },
            getLabel: (String value) => value,
          ),
          const SizedBox(height: 16),
          buildDescription(),
          const SizedBox(height: 16),
          BasicDateTimeField(
            hintText: "Start",
            value: starting,
            onChanged: (DateTime value) {
              setState(() {
                starting = value;
              });
            },
          ),
          const SizedBox(height: 16),
          BasicDateTimeField(
            hintText: "End",
            value: end,
            onChanged: (DateTime value) {
              setState(() {
                end = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  TaskHelper.addTask(name, type, starting, end,
                          widget.member.id, description)
                      .then((value) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Task added')));
                    Navigator.pop(context);
                  }).catchError((error) => print("Failed to add task: $error"));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildName() => TextFormField(
        decoration:
            InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
        onChanged: (value) => setState(() => name = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      );

  Widget buildDescription() => TextFormField(
        decoration: InputDecoration(
            labelText: 'Description', border: OutlineInputBorder()),
        onChanged: (value) => setState(() => description = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      );
}
