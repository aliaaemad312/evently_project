
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/app_theme_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height =MediaQuery.of(context).size.height;
    var width =MediaQuery.of(context).size.width;
    var themeProvider= Provider.of<AppThemeProvider>(context);

    return Padding(
      padding:  EdgeInsets.symmetric(vertical: height*0.04,horizontal: width*0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: (){
                themeProvider.changeTheme(ThemeMode.dark);

              },
              child:themeProvider.isDarkMode()?
              getSelectedThemeItem(textTheme: AppLocalizations.of(context)!.dark):
              getUnSelectedThemeItem(textTheme: AppLocalizations.of(context)!.dark)
          ),
          SizedBox(height: height*0.02,),
          InkWell(
              onTap: (){
                themeProvider.changeTheme(ThemeMode.light);

              },
              child:themeProvider.isLightMode()?
              getSelectedThemeItem(textTheme: AppLocalizations.of(context)!.light):
              getUnSelectedThemeItem(textTheme:AppLocalizations.of(context)!.light)
          ),
        ],
      ),
    );
  }

  Widget getSelectedThemeItem({required String textTheme}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textTheme,
          style: AppStyles.bold20Primary,),
        Icon(Icons.check,size: 35,
          color: AppColors.primaryLight,)
      ],
    );
  }

  Widget getUnSelectedThemeItem({required String textTheme}){
    return Text(textTheme,
      style: AppStyles.bold20Black,);
  }
}
