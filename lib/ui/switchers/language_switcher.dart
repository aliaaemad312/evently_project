import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:provider/provider.dart';

import '../../providers/app_language_provider.dart';

class LanguageSwitcher extends StatefulWidget {

   LanguageSwitcher({super.key,});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  @override
  Widget build(BuildContext context) {
    var languageProvide= Provider.of<AppLanguageProvider>(context);
    bool isEnglish=languageProvide.appLanguage=='en';
    return AnimatedToggleSwitch.rolling(
      current: isEnglish,
      values: [true,false],
      onChanged: (value) {
        var newLanguage=value? 'en':'ar';
        languageProvide.changeLanguage(newLanguage);
      },

      iconBuilder: (value, isSelected) {
        return Image.asset(
          value  ? AppAssets.usIcon : AppAssets.egIcon,
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
