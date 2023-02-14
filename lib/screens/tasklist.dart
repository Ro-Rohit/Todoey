import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'tasktile.dart';
import 'package:provider/provider.dart';
import '../Provider/task_data.dart';


class Tasklist extends StatefulWidget {


  @override
  State<Tasklist> createState() => _TasklistState();
}

class _TasklistState extends State<Tasklist> {
  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskData>(context);
    List workList = taskData.getDailyTask()?? [];

   List<Widget> updateUI() {
      List <Widget> UI = [];
      if (workList.isEmpty) {
        return UI;
      }else{
        for (var work in workList) {
          UI.add(
              TaskTile(
                isChecked: work.isDone,
                taskTitle: work.name,
                CheckBoxCallBack: () {
                  taskData.updateTask(work);
                },
                onLongPressCallBack: () {
                  taskData.deleteTask(work, context);
                },
              ));
        }
      }
      return UI;
    }


    return NotificationListener<UserScrollNotification>(
      onNotification: (notification){
        if(notification.direction == ScrollDirection.forward){
          if(!taskData.isFABVisible) {
            taskData.changeFABVisibility(true);
            print(taskData.isFABVisible);
          }
        }else if(notification.direction == ScrollDirection.reverse){
          if(taskData.isFABVisible) {
            taskData.changeFABVisibility(false);
          }
        }
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
            children: [
                const Text('Add you daily Task', style: TextStyle(
                color: Colors.grey, fontStyle: FontStyle.italic,),),
              const SizedBox(height: 10,),
              updateUI().isNotEmpty
                  ? Column(children: updateUI(),)
                  : const Text('click on the Button down below')
            ]),
      ),
    );
  }
}


