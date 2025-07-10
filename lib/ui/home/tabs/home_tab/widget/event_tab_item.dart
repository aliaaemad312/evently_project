import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EventTabItem extends StatelessWidget {
  bool isSelected;
  String eventName;
  Color? borderColor;
  Color selectedBgColor;
  TextStyle selectedTextStyle;
  TextStyle unSelectedTextStyle;


   EventTabItem({super.key,
     required this.isSelected,
     required this.eventName,
   this.borderColor,
   required this.selectedBgColor,
     required this.selectedTextStyle,
     required this.unSelectedTextStyle
   });

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Container(
      margin:EdgeInsets.symmetric(horizontal: width*0.01) ,
      padding: EdgeInsets.symmetric(horizontal: width*0.03,
      vertical: height*0.003),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: borderColor ?? Theme.of(context).focusColor,
          width: 2
        ),
        color: isSelected? selectedBgColor : AppColors.transparentColor
      ),
      child: Text(eventName,
      style: isSelected? selectedTextStyle : unSelectedTextStyle),
    );
  }
}
