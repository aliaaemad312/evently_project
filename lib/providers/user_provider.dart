import 'package:evently_app/model/my_user.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier{
  MyUser? currentUser;

  void updateUser(MyUser newUser){
    currentUser=newUser;
    notifyListeners();
  }
}