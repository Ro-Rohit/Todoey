import 'package:flutter/material.dart';
import 'package:todoey/modal/task_modal.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class TaskData extends ChangeNotifier {

  final _myBox = Hive.box('myBox');

  List<dynamic> _list = [
    {'title': 'Title', 'model': TaskModel(mainTitle: 'Title', date: 'Date', dailyWork: [],)},
  ];


  String _mainTitle = 'Title';
  String _displayDate = 'date';
   List _displayDailyTask = [];
   bool isFABVisible = true;


  get getMainTitle => _mainTitle;
  get getDate => _displayDate;
  get taskCount => _displayDailyTask.length;
  get getFABVisibility => isFABVisible;

  changeFABVisibility(bool value){
    isFABVisible = value;
    notifyListeners();
  }





  // for not repetation of NewDayTask
  bool showText = false;
  get getShowError => showText;

  showError(bool value){
    showText = value;
    notifyListeners();
  }
  // hideError(){
  //   showText = false;
  //   notifyListeners();
  // }



  List<String> getMainTitleList(){
    List<String> x = [];
    for (var element in _list) {
      TaskModel eachTaskModel = element['model'];
     x.add(eachTaskModel.mainTitle) ;
    }
    return x;
  }

  List? getDailyTask(){
    var item = _list.firstWhere((element) => element['title'] == _mainTitle, orElse: ()=> null);
    // print(item);
    if(item == null){
      return [];
    }
    TaskModel x = item['model'];
    _displayDailyTask = x.dailyWork;
    // print(_displayDailyTask);
    return _displayDailyTask;
  }




  void  fetchTasks(BuildContext ctx) {
   _list = _myBox.get('list')?? [];
   _mainTitle = _myBox.get('mainTitle')?? 'Title';
   _displayDate = _myBox.get('date') ?? 'Date';
   _displayDailyTask = _myBox.get('dailyTask')?? [];
    notifyListeners();
}


  void changeUI(String newOne) {
     _mainTitle = newOne;
     var item = _list.firstWhere((element) => element['title'] == _mainTitle,);
     TaskModel taskModel = item['model'];
     _displayDate = taskModel.date;
     _displayDailyTask = taskModel.dailyWork;
     _myBox.put('mainTitle' , _mainTitle);
     _myBox.put('date' , _displayDate);
     _myBox.put('dailyTask' , _displayDailyTask);
     notifyListeners();
  }


  void removeNewDayTask(name) {
    if(_mainTitle == name){
      _mainTitle = 'Title';
      _displayDate = 'Date';
      _displayDailyTask.clear();
    }
    _list.removeWhere((element) => element['title'] == name);
    _myBox.put('list' , _list);
    notifyListeners();
  }


    void getNewDayTask(String name,) {
      DateTime now = DateTime.now();
      String currentDate = "${now.day.toString()}-${now.month.toString()}-${now.year.toString()}";
      _list.add({
        'title': name,
        'model' : TaskModel(mainTitle: name, date: currentDate, dailyWork: [],)});

      _myBox.put('list', _list);
      notifyListeners();
    }

    void updateTask(Task task) {  //UPDATE DAILY TASK
      task.toggleDone();
      notifyListeners();
    }

    void deleteTask(Task task, BuildContext ctx) {
      var item = _list.firstWhere((element) => element['title'] == _mainTitle);
      TaskModel taskModel = item['model'];
      taskModel.dailyWork.remove(task);
      _myBox.put('list' , _list);
      notifyListeners();
    }

    void getNewWork(String newTask, BuildContext context) {
      var item = _list.firstWhere((element) => element['title'] == _mainTitle,
          orElse: (){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Choose Title first!',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                  backgroundColor: Colors.lightBlueAccent,
                  duration: Duration(seconds: 3),
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                ));
          });
      if(item != null){
        TaskModel taskModel = item['model'];
        taskModel.dailyWork.add(Task(name: newTask));
        notifyListeners();
        _myBox.put('list' , _list);
        // print(_myBox.get('list'));
      }
    }
  }




// await getStoreTitle().then((value) => mainTitle = value);
// try{DocumentSnapshot _doc = await _firebaseStorage.collection('newdaytask').doc(mainTitle).get();
//     for(var works in _doc.get('work')){
//       dailyTask.add(Task(name: works));
//     }
//     newDate = _doc.get('date');
//     taskCount;
//
// await _firebaseStorage.collection('newdaytask').get().then(
//         (QuerySnapshot taskSnapshot) {
//       for (var element in taskSnapshot.docs) {
//         titleList.add(element.get('title'));
//       }
//     });
// }catch(e){
//   errorDialog(content: e.toString(), ctx: ctx,);
// }

//  try{
//    final DocumentSnapshot _doc = await _firebaseStorage.collection('newdaytask').doc(newOne).get();
//    if(_doc == null){
//      return ;
//    }
//    tasks.putIfAbsent(_doc.get('title'), () =>
//        EverydayTask(
//          title: _doc.get('title'),
//          date: _doc.get('date').toString(),
//          work: _doc.get('work'),
//        ),
//    );
//    dailyTask.clear();
//     tasks.forEach((key, value) => {if(key == newOne){
//       newDate = value.date,
//       mainTitle = value.title,
//       dailyTask = value.work,
//     }});
//     storeTitle(newOne);
//  notifyListeners();
//  } catch(e){
// errorDialog(content: e.toString(), ctx: ctx,);
//  }


//DELETENEWDAYTASK
// titleList.remove(name);
// tasks.remove(name);
// dailyTask.clear();
// await _firebaseStorage.collection('newdaytask').doc(name).delete();



// try{
//   await _firebaseStorage.collection('newdaytask').doc(name).set({
//     'title' : name,
//     'date' : currentDate,
//     'work' : [],
//   });
// }catch(e){
//   errorDialog(content: e.toString(), ctx: ctx,);
// }


// tasks.add({'title': name, 'date': currentDate, 'work' : []});


//DELETE DAILY TASK
// dailyTask.remove(task);
// try {
//
//   await FirebaseFirestore.instance.collection('newdaytask')
//       .doc(mainTitle)
//       .update({
//     'work': FieldValue.arrayRemove([task.name]),
//   });
//
// }catch(e){
//   errorDialog(content: e.toString(), ctx: ctx,);
// }
//
//   // for (int i = 0; i < tasks.length; i++) {
//   //   if(tasks[i]['title'] == mainTitle){
//   //   List oldList = tasks[i]['work'];
//   //   oldList.remove(task);
//   //   tasks[i]['work'] = oldList;
//   // }}


//ADD DAILY TASK

// dailyTask.add(Task(name: newTask));
// try {
//   var  taskRef = await _firebaseStorage.collection('newdaytask').doc(mainTitle).get();
//   if(!taskRef.exists){
//     await getNewDayTask(mainTitle, ctx);
//   }
// }catch(e){
//   errorDialog(content: e.toString(), ctx: ctx,);
// }finally{
//   await _firebaseStorage.collection('newdaytask').doc(mainTitle).update({
//     'work': FieldValue.arrayUnion([newTask]),
//   });
// }
// for (int i = 0; i < tasks.length; i++){
//   if(tasks[i]['title'] == mainTitle){
//   List oldList = tasks[i]['work'];
//   oldList.add(Task(name: newTask));
//   tasks[i]['work'] = oldList;
// }}

