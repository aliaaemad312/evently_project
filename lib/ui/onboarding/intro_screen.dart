import 'package:evently_app/ui/home/tabs/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/switchers/theme_switcher.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/app_theme_provider.dart';
import '../switchers/language_switcher.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var themeProvider= Provider.of<AppThemeProvider>(context);
    return  SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.introLogo),
              themeProvider.isDarkMode()?Image.asset(AppAssets.introDark1):Image.asset(AppAssets.introLight1),
              Text(
                "Personalize Your Experience",
                style: AppStyles.bold20Primary,
              ),
              SizedBox(height: height * 0.01),
              Text(
                "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                style: themeProvider.isDarkMode()?AppStyles.medium16White: AppStyles.medium16Black,
                overflow: TextOverflow.clip,
              ),
              SizedBox(height: height * 0.01),
              Row(
                children: [
                  Text(AppLocalizations.of(context)!.language,style: AppStyles.medium20Primary,),
                  Spacer(),
                  LanguageSwitcher(),
                ],
              ),
              SizedBox(height: height * 0.01),
              Row(
                children: [
                  Text(AppLocalizations.of(context)!.theme,style: AppStyles.medium20Primary,),
                  Spacer(),
                  ThemeSwitcher(),

                ],
              ),
              SizedBox(height: height * 0.02),
              CustomElevatedButton(onPressed: (){
                Navigator.of(context).pushReplacementNamed(AppRoutes.introRouteName);
                },
                  text: AppLocalizations.of(context)!.start)
            ],
          ),
        ),
      ),
    );
  }
}
