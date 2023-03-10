import 'package:flutter/material.dart';


class TaskTile extends StatelessWidget {


  final bool isChecked;
  final String taskTitle;
  final Function CheckBoxCallBack;
  final Function onLongPressCallBack;


  TaskTile({required this.isChecked, required this.taskTitle, required this.CheckBoxCallBack, required this.onLongPressCallBack,});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () =>{onLongPressCallBack()},
      title: Text(taskTitle,  style: TextStyle(fontSize: 18, decoration: isChecked? TextDecoration.lineThrough : null)),
      trailing: Checkbox(activeColor: Colors.lightBlueAccent, value: isChecked,
        onChanged: (newValue) => {CheckBoxCallBack()},)
      );
  }
}









