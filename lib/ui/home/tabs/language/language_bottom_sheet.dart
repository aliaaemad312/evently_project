
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height =MediaQuery.of(context).size.height;
    var width =MediaQuery.of(context).size.width;
    var languageProvide= Provider.of<AppLanguageProvider>(context);

    return Padding(
      padding:  EdgeInsets.symmetric(vertical: height*0.04,horizontal: width*0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: (){
                languageProvide.changeLanguage('en');

              },
              child:languageProvide.appLanguage=='en'?
              getSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.english):
              getUnSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.english)
          ),
          SizedBox(height: height*0.02,),
          InkWell(
              onTap: (){
                languageProvide.changeLanguage('ar');

              },
              child:languageProvide.appLanguage=='ar'?
              getSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.arabic):
              getUnSelectedLanguageItem(textLanguage:AppLocalizations.of(context)!.arabic)
          ),
        ],
      ),
    );
  }

  Widget getSelectedLanguageItem({required String textLanguage}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textLanguage,
          style: AppStyles.bold20Primary,),
        Icon(Icons.check,size: 35,
          color: AppColors.primaryLight,)
      ],
    );
  }

  Widget getUnSelectedLanguageItem({required String textLanguage}){
    return Text(textLanguage,
      style: AppStyles.bold20Black,);
  }
}
