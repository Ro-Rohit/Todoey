import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todoey/Provider/profile_Provider.dart';
import 'package:todoey/Provider/task_data.dart';
import 'tasklist.dart';
import 'add_task.dart';
import 'package:provider/provider.dart';
import 'sidebar.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TasksScreen extends StatefulWidget {
  static const id = 'taskScreen';

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(milliseconds: 5), () {
       Provider.of<TaskData>(context, listen: false).fetchTasks(context);
       Provider.of<ProfileProvider>(context, listen: false).fetchProfileData();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskData>(context);
    return SafeArea(
      child: Scaffold(
        drawer: myDrawer(),
        backgroundColor: Colors.lightBlueAccent,
        floatingActionButton: taskData.getFABVisibility
            ? FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(),
              ),
              isScrollControlled: true,
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
            : null,
        body: Builder(
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 60, bottom: 30, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: const CircleAvatar(backgroundColor: Colors.white, radius: 30,
                          child: Icon(Icons.list, size: 30,),
                        )),

                    const SizedBox(height: 15,),

                    const Text('Todoey',
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700, color: Colors.white,),
                    ),

                    Text(taskData.getMainTitle,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: Colors.white,),
                    ),

                    Text(taskData.getDate,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w100, color: Colors.white,),
                    ),
                    Text('${taskData.taskCount}tasks',
                      style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Tasklist(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
