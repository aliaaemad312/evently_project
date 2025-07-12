import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier{
  static const String languageKey='app_language';
  String appLanguage='en';

  AppLanguageProvider(){
    loadSavedLanguage();
  }

  void loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString(languageKey);

    if (savedLanguage != null && savedLanguage != appLanguage) {
      appLanguage = savedLanguage;
      notifyListeners();
    }
  }

  void changeLanguage(String newLanguage)async{
    if(newLanguage==appLanguage){
      return;
    }
    appLanguage=newLanguage;
    notifyListeners();
     SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setString(languageKey, newLanguage);

  }


}