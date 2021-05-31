import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Map icons = {
  'Feeding': 59662,
  'Cleaning': 58971,
  'Reception': 59530,
  'Other': 59842
};

Map statusName = {
  'pending': 'Pending',
  'done': 'Done',
  'to_do': 'To do',
};

Map statusColor = {
  'pending': Colors.orange,
  'done': Colors.green,
  'to_do': Colors.red,
};

Map statusActionColor = {
  'pending': Colors.red,
  'done': Colors.red,
  'to_do': Colors.green,
};

Map statusActionIcon = {
  'pending': Icons.thumb_down,
  'done': Icons.thumb_down,
  'to_do': Icons.thumb_up,
};

Map statusAction = {
  'pending': 'to_do',
  'done': 'to_do',
  'to_do': 'pending',
};

Map statusActionText = {
  'pending': 'Cancel',
  'done': 'Cancel',
  'to_do': 'Validate',
};

class TaskHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> updateTask(id, status) {
    return _db
        .collection('tasks')
        .doc(id)
        .update({'status': status})
        .then((value) => print("task Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> addTask(name, type, starting, end, id, description) {
    return _db
        .collection('tasks')
        .add({
          'name': name,
          'type': type,
          'starting': starting,
          'end': end,
          'user_id': id,
          'description': description,
          'icon': icons[type],
          'status': 'to_do',
        })
        .then((value) => print("task Created"))
        .catchError((error) => print("Failed to add task: $error"));
  }
}
