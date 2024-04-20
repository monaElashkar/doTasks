import 'package:flutter/material.dart';
import 'package:todo/home/tabs/settings_tab.dart';
import 'package:todo/home/tabs/tasks_tab.dart';

import 'add_task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xffdfecdb),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "ToDo",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      body:tabs[index] ,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        height: 60,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          currentIndex: 0,
          onTap: (value){
            index=value;
            setState(() {

            });
          },
          showUnselectedLabels:false,
          showSelectedLabels: false,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.shade400,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.task,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: "",
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked ,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder:(context){
                 return Container(
                   padding: EdgeInsets.only(
                     bottom: MediaQuery.of(context).viewInsets.bottom,
                   ),
                     child: AddTaskBottomSheet(),
                 );
              });
        },
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: Colors.white,
            width: 3
          )
        ) ,
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
  List<Widget>tabs=[TasksTab(),SettingsTab()];
}
