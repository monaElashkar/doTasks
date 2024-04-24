import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime chosenDate=DateTime.now();
  var titleController=TextEditingController();
  var descriptionController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Add New Task",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              label: const Text("Title"),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  )),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              label: const Text("Description"),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  )),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Select Time",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          InkWell(
            onTap: () {
              selectDate(context);
            },
            child:  Text(
              "${chosenDate.toString().substring(1,10)}",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                TaskModel model=TaskModel(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    title: titleController.text,
                    description: descriptionController.text,
                    date:DateUtils.dateOnly(chosenDate).millisecondsSinceEpoch);
                FirebaseFunctions.addTask(model);
                Navigator.pop(context);
              },
              child: const Text(
                "Add Task",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  selectDate(BuildContext context)async {
   DateTime? selectedDate=await showDatePicker(
      context: context,
      initialDate: chosenDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 360),
      ),
      // builder: (context,child){
      //   return Theme(data: Theme.of(context).copyWith(
      //     colorScheme: ColorScheme.light(
      //       primary: Colors.cyan,
      //     )
      //   ),
      //       child: child!);
      // },
      selectableDayPredicate: (day) =>
          day !=
          DateTime.now().add(
            Duration(days: 2),
          ),
    );
   if(selectedDate!=null){
     chosenDate=selectedDate!;
     setState(() {});
   }

  }
}
