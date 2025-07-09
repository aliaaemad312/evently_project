import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  Color? backgroundColor;
  TextStyle? textStyle;
  Color? borderColor;
  bool icon;
  Widget? iconWidget;
  MainAxisAlignment? mainAxisAlignment;

   CustomElevatedButton({super.key,
    required this.onPressed,
    required this.text,
   this.backgroundColor=AppColors.primaryLight,
     this.textStyle,
     this.borderColor,
     this.icon=false,
     this.iconWidget,
     this.mainAxisAlignment= MainAxisAlignment.start
   });

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return ElevatedButton(
        onPressed: (){
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical:height*0.02 ),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: borderColor??AppColors.primaryLight
            )
          )
        ),
        child: icon ?
            Row(
              mainAxisAlignment: mainAxisAlignment!,
              children: [
                iconWidget!,
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width*0.02),
                  child: Text(text,
                    style: textStyle??AppStyles.medium20White,),
                )

              ],
            ):
        Text(text,
        style: textStyle??AppStyles.medium20White,)
    );
  }
}
