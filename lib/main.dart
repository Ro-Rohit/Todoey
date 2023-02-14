import 'package:flutter/material.dart';
import 'package:todoey/Provider/profile_Provider.dart';
import 'modal/task_modal.dart';
import 'screens/taskscreen.dart';
import 'package:provider/provider.dart';
import 'Provider/task_data.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(ProfileModelAdapter());
   await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> TaskData()),
          ChangeNotifierProvider(create: (_)=> ProfileProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  TasksScreen(),
          routes: {
            TasksScreen.id : (context) => TasksScreen(),
          },
        ),
      );
  }
}




