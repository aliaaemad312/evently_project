import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DialogUtils{
  static void showLoading({required BuildContext context,required String loadingText}){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.whiteBgColor,
           content: Row(
             children: [
          CircularProgressIndicator(
            color: AppColors.primaryLight,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(loadingText,
              style: AppStyles.medium16Black,),
          )
        ],
      ),
    ),
    );

}

  static void hideLoading({required BuildContext context}){
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? posActionName,
    Function?posAction,
    String? negActionName,
    Function?negAction,
    bool barrierDismissible=true
  }){
    List<Widget>? actions=[];
    if(posActionName!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posAction?.call();
      }, child: Text(posActionName,
      style: AppStyles.medium16Black,)));
    }

    if(negActionName!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        negAction?.call();
      }, child: Text(negActionName,
        style: AppStyles.medium16Black,)));
    }
    showDialog(
      barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: AppColors.whiteBgColor,
          content: Text(message,
          style: AppStyles.medium16Black,),
          title: Text(title??'',
          style: AppStyles.medium16Black,),
          actions: actions
        ));

  }
}