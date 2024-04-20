import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

import '../../firebase/firebase_functions.dart';
import '../../task_model.dart';
import '../task_item.dart';

class TasksTab extends StatefulWidget {
  static const String routeName = "Tasks";

   TasksTab({Key? key}) : super(key: key);

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
   DateTime selectedDate=DateTime .now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          initialSelectedDate: selectedDate,
          selectionColor: Colors.blue,
          selectedTextColor: Colors.white,
          height: 90,
          locale: 'en',
          dateTextStyle: TextStyle(fontSize: 12),
          monthTextStyle: TextStyle(fontSize: 12),
          dayTextStyle: TextStyle(fontSize: 12),
          onDateChange: (date) {
            selectedDate=date;
            setState(() {

            });
            // New date selected
            // setState(() {
            //   _selectedValue = date;
            // });
          },
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseFunctions.getTasks(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text("Somthing went wrong"),
                    ElevatedButton(onPressed: () {}, child: Text("try Again"))
                  ],
                );
              }
              var tasks = snapshot.data?.docs.map((e) => e.data()).toList()??[];
              if (tasks.isEmpty) {
                return Center(child: Text("No tasks"));
              }
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 12,
                ),
                itemBuilder: (context, index) {
                  return TaskItem(taskModel: tasks[index],);
                },
                itemCount: tasks.length,
              );
            },
          ),
        )
      ],
    );
  }
}
