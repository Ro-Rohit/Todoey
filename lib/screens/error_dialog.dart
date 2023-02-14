import 'package:flutter/material.dart';


void textDialog(
    {
      required String title,
      required BuildContext ctx,
      required TextEditingController controller,
      required Function fnc,
    }
    ) async{
  await showDialog(context: ctx,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title:  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          content: TextField(
            decoration: const InputDecoration(
              hoverColor: Colors.white,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent)),
            ),
            controller: controller,
            style: const TextStyle(color: Colors.white, fontSize: 18,),
          ),
          actions: [

            TextButton(onPressed: (){
              if(Navigator.canPop(context)){
                Navigator.pop(context);}
            },
                child:  const Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 18),)
            ),

            TextButton(onPressed: (){
              fnc();
              Navigator.pop(context);
              },
                child:  const Text('OK', style: TextStyle(color: Colors.white, fontSize: 18),)
            ),
          ],

        );
      });
}











