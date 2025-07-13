import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:provider/provider.dart';

import '../../providers/app_language_provider.dart';
import '../../providers/app_theme_provider.dart';

class ThemeSwitcher extends StatefulWidget {

   ThemeSwitcher({super.key,});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    var themeProvider= Provider.of<AppThemeProvider>(context);
    bool isDark=themeProvider.isDarkMode();
    return AnimatedToggleSwitch.rolling(
      current: !isDark,
      values: [true,false],
      onChanged: (value) {
        themeProvider.changeTheme(value ? ThemeMode.light : ThemeMode.dark);
      },

      iconBuilder: (value, isSelected) {
        return
          Image.asset(
          value? AppAssets.lightIcon : AppAssets.darkIcon,
          color: isSelected?Theme.of(context).hoverColor:AppColors.primaryLight  ,
          width: 32,
          height: 32,
        );
      },
      style: ToggleStyle(
        borderColor: AppColors.primaryLight,
        backgroundColor: AppColors.whiteBgColor,
        indicatorColor: AppColors.primaryLight,

      ),
      borderWidth: 2.0,
      height: 40,





    );
  }
}
