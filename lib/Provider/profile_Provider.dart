import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoey/modal/task_modal.dart';
import 'dart:io';

class ProfileProvider extends ChangeNotifier{

  final _myBox = Hive.box('myBox');

    ProfileModel _profileModel = ProfileModel(
      about1: "Press!",
      about2: 'To Change Anything',
      image1: null,
      image2: null,);

  get getProfileModel => _profileModel;


  // fetching user images from data
  void fetchProfileData(){
    _profileModel = _myBox.get('profileData')?? _profileModel;
  }

  // pick a image by imagePicker
  Future<Uint8List?> pickImage() async{
     final _file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(_file != null){
      return _file.readAsBytes();
    }else{
      return null;
    }
  }


// changing productmodel's image1
  void getImage1()async{
    await pickImage().then((value){
      if(value != null){
        _profileModel.image1 = value;
        _myBox.put('profileData', _profileModel);
      }
    });
    notifyListeners();
  }

// changing productmodel's image1
  void getImage2()async{
     await pickImage().then((value) {
       if(value != null){
         print(value);
         _profileModel.image2 = value;
         _myBox.put('profileData', _profileModel);
       }
     });
    notifyListeners();
  }

// changing productmodel's about1
  void getAbout1(String value){
    _profileModel.about1 = value;
    _myBox.put('profileData', _profileModel);
    notifyListeners();
  }

// changing productmodel's about2
  void getAbout2(String value){
    _profileModel.about2 = value;
    _myBox.put('profileData', _profileModel);
    notifyListeners();
  }


}