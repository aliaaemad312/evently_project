
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/home/tabs/language/language_bottom_sheet.dart';
import 'package:evently_app/ui/home/tabs/theme/theme_bottom_sheet.dart';
import 'package:evently_app/ui/home/tabs/widgets/custom_elevated_button.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/app_language_provider.dart';
import '../../../../../providers/app_theme_provider.dart';
import '../../../../providers/user_provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var height =MediaQuery.of(context).size.height;
    var width =MediaQuery.of(context).size.width;
    var languageProvide= Provider.of<AppLanguageProvider>(context);
    var themeProvider= Provider.of<AppThemeProvider>(context);
    var userProvider= Provider.of<UserProvider>(context);
    var eventListProvider= Provider.of<EventListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: height*0.2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70))
        ),
        title: Padding(
          padding:  EdgeInsets.only(bottom: height*0.01),
          child: Row(
            children: [
              Image(image: AssetImage(AppAssets.routeLogo)),
              SizedBox(width: width*0.04,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userProvider.currentUser!.name,style: AppStyles.bold24White,),
                  SizedBox(height: height*0.01,),
                  Text(userProvider.currentUser!.email,
                      style: AppStyles.medium16White,
                      overflow: TextOverflow.ellipsis)
                ],
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.04,vertical:height*0.04 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.language,
              style:Theme.of(context).textTheme.headlineLarge ,),
            Container(
              margin: EdgeInsets.symmetric(vertical: height*0.02),
              padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.03),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight,
                      width: 2)
              ),
              child: InkWell(
                onTap: (){
                  showLanguageBottomSheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(languageProvide.appLanguage=='en'?
                    AppLocalizations.of(context)!.english:
                    AppLocalizations.of(context)!.arabic
                      ,
                      style: AppStyles.bold20Primary,),
                    Icon(Icons.arrow_drop_down_outlined,
                      size: 35,
                      color: AppColors.primaryLight,)

                  ],
                ),
              ),
            ),
            SizedBox(height: height*0.02,),
            Text(AppLocalizations.of(context)!.theme,
              style:Theme.of(context).textTheme.headlineLarge ,),
            Container(
              margin: EdgeInsets.symmetric(vertical: height*0.02),
              padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.03),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight,
                      width: 2)
              ),
              child: InkWell(
                onTap: (){
                  showThemeBottomSheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(themeProvider.isDarkMode()?
                    AppLocalizations.of(context)!.dark:
                    AppLocalizations.of(context)!.light
                      ,
                      style: AppStyles.bold20Primary,),
                    Icon(Icons.arrow_drop_down_outlined,
                      size: 35,
                      color: AppColors.primaryLight,)

                  ],
                ),
              ),
            ),
            Spacer(),
            CustomElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginRouteName, (route) => false,);
                },
                backgroundColor: AppColors.redColor,
                borderColor: AppColors.redColor,
                icon: true,
                iconWidget: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width*0.02),
                  child: Icon(Icons.logout,
                  color: AppColors.whiteBgColor,
                  size: 24,),
                ),
                text: AppLocalizations.of(context)!.logout)
            
            

          ],
        ),
      ),

    );
  }
  void showLanguageBottomSheet() {
    showModalBottomSheet(context: context,
        builder: (context) => LanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(context: context,
        builder: (context) => ThemeBottomSheet());
  }

}

/*
ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(vertical: height*0.02,
                        horizontal: width*0.04)

                ),
                onPressed: (){},
                child: Row(
                  children: [
                    Icon(Icons.logout,color: AppColors.whiteColor,size: 30,),
                    SizedBox(width: 0.03,),
                    Text(AppLocalizations.of(context)!.logout,style: AppStyles.regular20White,
                    )
                  ],
                ))*/