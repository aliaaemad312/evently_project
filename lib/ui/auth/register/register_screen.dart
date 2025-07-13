import 'package:evently_app/ui/home/tabs/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/home/tabs/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_routes.dart';
import '../../switchers/language_switcher.dart';

class RegisterScreen extends StatefulWidget {
   RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   TextEditingController emailController = TextEditingController();

   TextEditingController passwordController = TextEditingController();

   TextEditingController rePasswordController = TextEditingController();

   TextEditingController nameController = TextEditingController();

   var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var themeProvider= Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).canvasColor
        ),
        title: Text(AppLocalizations.of(context)!.register,
        style: Theme.of(context).textTheme.labelMedium,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.04),
          child: Column(
            children: [
              Image.asset(AppAssets.logo,
              height: height*0.22,),
              SizedBox(height: height*0.02,),
              Form(
                key: formKey,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    hintText: AppLocalizations.of(context)!.name,
                    colorBorderSide:themeProvider.isDarkMode()?AppColors.primaryLight:AppColors.greyColor,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    prefixIcon: Image.asset(AppAssets.nameIcon,
                      color: themeProvider.isDarkMode()?AppColors.whiteBgColor:AppColors.greyColor,),
                    controller: nameController,
                    validator: (text) {
                      if(text==null || text.trim().isEmpty){
                        return AppLocalizations.of(context)!.please_enter_name;
                      }
                      return null;

                    },
                  ),

                  SizedBox(height: height*0.02,),
                  CustomTextFormField(
                    hintText: AppLocalizations.of(context)!.email,
                    colorBorderSide:themeProvider.isDarkMode()?AppColors.primaryLight:AppColors.greyColor,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    prefixIcon: Image.asset(AppAssets.emailIcon,
                      color: themeProvider.isDarkMode()?AppColors.whiteBgColor:AppColors.greyColor,),
                  controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if(text==null || text.trim().isEmpty){
                        return AppLocalizations.of(context)!.please_enter_email;
                      }
                      final bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text.trim());
                      if(!emailValid){
                        return AppLocalizations.of(context)!.please_enter_valid_email;
                      }
                      return null;

                    },
                  ),

                  SizedBox(height: height*0.02,),

                  CustomTextFormField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    hintText: AppLocalizations.of(context)!.password,
                    colorBorderSide:themeProvider.isDarkMode()?AppColors.primaryLight:AppColors.greyColor,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    prefixIcon: Image.asset(AppAssets.passwordIcon,
                      color: themeProvider.isDarkMode()?AppColors.whiteBgColor:AppColors.greyColor,),
                    suffixIcon: InkWell(onTap: (){

                    },
                        child: Image.asset(AppAssets.hidePassIcon,
                          color: themeProvider.isDarkMode()?AppColors.whiteBgColor:AppColors.greyColor,)),
                    controller:passwordController ,
                    validator: (text) {
                      if(text==null || text.trim().isEmpty){
                        return AppLocalizations.of(context)!.please_enter_password;
                      }
                      if(text.length<6){
                        return AppLocalizations.of(context)!.please_enter_valid_password;
                      }


                      return null;

                    },
                  ),
                  SizedBox(height: height*0.02,),
                  CustomTextFormField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    colorBorderSide:themeProvider.isDarkMode()?AppColors.primaryLight:AppColors.greyColor,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    keyboardType: TextInputType.number,
                    hintText: AppLocalizations.of(context)!.re_password,
                    prefixIcon: Image.asset(AppAssets.passwordIcon,
                      color: themeProvider.isDarkMode()?AppColors.whiteBgColor:AppColors.greyColor,),
                    suffixIcon: InkWell(onTap: (){

                    },
                        child: Image.asset(AppAssets.hidePassIcon,
                          color: themeProvider.isDarkMode()?AppColors.whiteBgColor:AppColors.greyColor,)),
                    controller:rePasswordController ,
                    validator: (text) {
                      if(text==null || text.trim().isEmpty){
                        return AppLocalizations.of(context)!.please_enter_password;
                      }
                      if(text.length<6){
                        return AppLocalizations.of(context)!.please_enter_valid_password;
                      }
                      if(passwordController.text!=text){
                        return "Re-password doesn\'t match password.";
                      }
                      return null;

                    },
                  ),
                  SizedBox(height: height*0.02,),
                  CustomElevatedButton(onPressed:(){
                    register();

                  }
                    ,text: AppLocalizations.of(context)!.create_account,),
                  SizedBox(height: height*0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.have_account,
                        style: Theme.of(context).textTheme.titleMedium,),
                      SizedBox(width: width*0.01,),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.login,
                          style: AppStyles.boldItalic16Primary,),
                      ),

                    ],
                  ),
                ],
              )),
              SizedBox(height: height*0.03,),
              LanguageSwitcher(),
            ],

          ),
        ),
      ),


    );
  }

  void register() {
    if(formKey.currentState?.validate()==true){
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
    }
  }
}
