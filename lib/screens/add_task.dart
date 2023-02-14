import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/task_data.dart';

class AddTaskScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final textEditor = TextEditingController();
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Add Task', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.lightBlueAccent,
                fontWeight: FontWeight.w700),),


            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              controller: textEditor,
            textInputAction: TextInputAction.done,
              onSubmitted: (newTxt){
                if(newTxt.isNotEmpty){
                  Provider.of<TaskData>(context, listen: false).getNewWork(textEditor.text, context);
                  textEditor.clear();
                  Navigator.pop(context);
                }
              },
            ),

            const SizedBox(height: 10,),

            ElevatedButton(
              onPressed: (){
                  if(textEditor.text.isNotEmpty){
                    Provider.of<TaskData>(context, listen: false).getNewWork(textEditor.text, context);
                    textEditor.clear();
                    Navigator.pop(context);
                   }
                  },
              child: const Text('ADD', style: TextStyle(fontSize: 10),),
              ),

          ],
        ),
      ),
    );
  }
}
