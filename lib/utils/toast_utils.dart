import 'dart:ui';

import 'package:evently_app/utils/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils{
  static Future<bool?> toastMsg({
    required String msg,
    required Color backgroundColor,
    required Color textColor,
})
  {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0
    );


  }

}