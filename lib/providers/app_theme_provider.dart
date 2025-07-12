import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier{
  static const String themeKey='app_theme';
  ThemeMode appTheme=ThemeMode.light;

  AppThemeProvider(){
    loadSavedTheme();
  }

  void loadSavedTheme ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? savedTheme=prefs.getBool(AppThemeProvider.themeKey);
    if(savedTheme==isDarkMode()){
      appTheme=ThemeMode.dark;
    }else{
      appTheme=ThemeMode.light;
    }
    notifyListeners();


  }

  void changeTheme(ThemeMode newTheme)async{
    if(appTheme==newTheme){
      return;
    }
    appTheme=newTheme;
    notifyListeners();
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppThemeProvider.themeKey, newTheme==ThemeMode.light?true:false);
    
    
    
  }

  bool isDarkMode(){
    return appTheme==ThemeMode.dark;
  }
  bool isLightMode(){
    return appTheme==ThemeMode.light;
  }

}