import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter2/Modules/Planning/TaskCard.dart';
import 'package:flutter2/Modules/Planning/TaskDetails.dart';
import 'package:flutter2/Models/Task.dart';
import 'package:flutter2/Theme/Theme.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  /// Which holds the selected date
  /// Defaults to today's date.
  DateTime selectedDate = DateTime.now();

  /// This decides which day will be enabled
  /// This will be called every time while displaying day in calender.
  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 7))))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Query tasks = FirebaseFirestore.instance
        .collection('tasks')
        .where('starting', isGreaterThanOrEqualTo: selectedDate)
        .where('starting', isLessThan: selectedDate.add(Duration(days: 1)));

    return Scaffold(
      appBar: AppBar(
        title: Text('Planning'),
        backgroundColor: AppTheme.ZK_Azure,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "${selectedDate.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text(
              'View planning',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: tasks.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("You don't have the Rights to do that");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new TaskCard(
                      task: document,
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskDetails(
                                    task: document,
                                  ))));
                }).toList(),
              );
            },
          )
        ],
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   final tasksOfTheDay =
  //       tasks.where((element) => element.date.day == selectedDate.day);

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Planning'),
  //       backgroundColor: AppTheme.ZK_Azure,
  //     ),
  //     resizeToAvoidBottomInset: false,
  //     body: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Text(
  //           "${selectedDate.toLocal()}".split(' ')[0],
  //           style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(
  //           height: 20.0,
  //         ),
  //         ElevatedButton(
  //           onPressed: () => _selectDate(context),
  //           child: Text(
  //             'View planning',
  //             style:
  //                 TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //           ),
  //         ),
  //         Container(
  //             width: (MediaQuery.of(context).size.width),
  //             height: (MediaQuery.of(context).size.height * .50),
  //             child: (tasksOfTheDay.isEmpty)
  //                 ? Align(
  //                     alignment: Alignment.center,
  //                     child: Text('Nothing to display for today'))
  //                 : ListView.separated(
  //                     padding: EdgeInsets.all(8),
  //                     separatorBuilder: (context, index) => Divider(),
  //                     itemCount: tasksOfTheDay.length,
  //                     itemBuilder: (context, index) => TaskCard(
  //                         task: tasksOfTheDay.elementAt(index),
  //                         press: () =>
  //                             Navigator.of(context).push(MaterialPageRoute(
  //                                 builder: (context) => TaskDetails(
  //                                       task: tasksOfTheDay.elementAt(index),
  //                                     ))))))
  //       ],
  //     ),
  //   );
  // }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select date',
      cancelText: 'Cancel',
      confirmText: 'Choose',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Date',
      fieldHintText: 'Month/Date/Year',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
