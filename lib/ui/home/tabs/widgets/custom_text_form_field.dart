import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  Color colorBorderSide;
  String? hintText;
  TextStyle? hintStyle;
  String? labelText;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
   CustomTextFormField({super.key,
     this.colorBorderSide=AppColors.greyColor,
     this.hintText,
     this.hintStyle,
     this.labelText,
     this.labelStyle,
     this.prefixIcon,
     this.suffixIcon
   });

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.04),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: builtDecorationBorder(colorBorderSide: colorBorderSide),
          focusedBorder: builtDecorationBorder(colorBorderSide: colorBorderSide),
          errorBorder: builtDecorationBorder(colorBorderSide: AppColors.redColor),
          focusedErrorBorder: builtDecorationBorder(colorBorderSide: AppColors.redColor),
          hintText: hintText,
          hintStyle: hintStyle?? AppStyles.medium16Grey,
          labelText: labelText,
          labelStyle: hintStyle?? AppStyles.medium16Grey,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon
        ),
      ),
    );
  }
  OutlineInputBorder builtDecorationBorder({required colorBorderSide}){
    return  OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            width: 1,
            color: colorBorderSide
        )
    );
  }
}
