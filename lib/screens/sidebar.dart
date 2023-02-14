
import 'package:todoey/Provider/profile_Provider.dart';
import 'package:todoey/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/modal/task_modal.dart';
import 'package:todoey/screens/error_dialog.dart';
import '../Provider/task_data.dart';

class myDrawer extends StatefulWidget {
  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  final textEditor = TextEditingController();
  final titleEditor = TextEditingController();
  final subtitleEditor = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    textEditor.dispose();
    titleEditor.dispose();
    subtitleEditor.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskData>(context);
    final profileData = Provider.of<ProfileProvider>(context);
    List<String> modelList = taskData.getMainTitleList();
    ProfileModel profileModel = profileData.getProfileModel;


    void checkCondition() {
        if (modelList.any((element) => element == textEditor.text)) {
          taskData.showError(true);
      }
      else {
        if (textEditor.text.isNotEmpty) {
          taskData.showError(false);
          taskData.getNewDayTask(textEditor.text);
          textEditor.clear();
        }
      }
    }

    return Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        elevation: 5,
        width: 270,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              onDetailsPressed: (){ profileData.getImage1();},
              accountName: GestureDetector(
                  onLongPress: (){
                    textDialog(
                        title: 'Your Name',
                        ctx: context,
                        controller: titleEditor,
                        fnc: (){
                          profileData.getAbout1(titleEditor.text);
                        });
                    },
                  child:  Text(
                    profileModel.about1,
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
                  )),
              accountEmail: GestureDetector(
                onLongPress: (){
                  textDialog(
                      title: 'About',
                      ctx: context,
                      controller: subtitleEditor,
                      fnc: (){
                        profileData.getAbout2(subtitleEditor.text);
                      });
                },
                  child:  Text(
                    profileModel.about2,
                    maxLines: 1, overflow: TextOverflow.ellipsis,)),
              currentAccountPicture: GestureDetector(
                onLongPress: (){profileData.getImage2();},
                child: CircleAvatar(
                  child: ClipOval(
                    child: profileModel.image2 != null
                        ? Image.memory(profileModel.image2!, fit: BoxFit.cover, height: 90, width: 90,)
                        : Image.asset(
                      'Image/mine.png',
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
              ),
              decoration:  BoxDecoration(
                  color: Colors.lightBlueAccent,
                  image: DecorationImage(
                    image: profileModel.image1 != null
                        ? MemoryImage(profileModel.image1!) as ImageProvider
                        : const AssetImage('Image/starwork.jpg'),
                    fit: BoxFit.cover,
                  )),
            ),

            const SizedBox(height: 15,),

            ListTile(
              trailing: Transform.scale(
                scale: 0.8,
                child: FloatingActionButton(
                  onPressed: () {
                    checkCondition();
                  },
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              ),
              title: TextField(
                controller: textEditor,
                textAlign: TextAlign.center,
                decoration: kdecorationTextstyle,
                textInputAction: TextInputAction.done,
                onSubmitted: (value)=> checkCondition(),
              ),
            ),

            const SizedBox(height: 10,),

            Visibility(
              visible: taskData.getShowError,
              child: const Padding(
                padding: EdgeInsets.only(right: 60),
                child: Text('This Task is already exists!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                  ),
                ),
              ),
            ),

            const Divider(color: Colors.lightBlueAccent, thickness: 4,),

            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: modelList.length,
                  itemBuilder: (context, i){
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: Text(
                    modelList[i],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    taskData.changeUI(modelList[i],);
                    Navigator.pop(context);
                  },
                  onLongPress: () {
                    taskData.removeNewDayTask(modelList[i]);
                  },
                  trailing: const Icon(
                    Icons.add_box_rounded,
                    size: 30,
                    color: Colors.lightBlue,
                  ),
                );

              }),
            )
          ],
        ));
  }
}
