import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return  SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.04),
          child: Column(
            children: [
              Image.asset(AppAssets.introLogo),
              SizedBox(height: height * 0.02),
              Image.asset(AppAssets.introLight1),
              SizedBox(height: height * 0.02),
              Text(
                "Personalize Your Experience",
                style: AppStyles.bold20Primary,
              ),
              SizedBox(height: height * 0.02),
              Text(
                "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                style: AppStyles.medium16Black,
                overflow: TextOverflow.clip,
              ),
              SizedBox(height: height * 0.02),
              Row(
                children: [
                  Text(AppLocalizations.of(context)!.language,style: AppStyles.medium20Primary,)
                ],
              ),
              SizedBox(height: height * 0.01),
              Row(
                children: [
                  Text(AppLocalizations.of(context)!.theme,style: AppStyles.medium20Primary,)
        
                ],
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                  Navigator.of(context).pushReplacementNamed(AppRoutes.introRouteName);
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                    padding: EdgeInsets.symmetric(vertical: height*.015),
                  ),
                  child: Text(AppLocalizations.of(context)!.start,style: AppStyles.medium20White,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
