import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/ui/home/tabs/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/home/tabs/widgets/custom_text_form_field.dart';
import 'package:evently_app/ui/switchers/language_switcher.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   TextEditingController emailController = TextEditingController();

   TextEditingController passwordController = TextEditingController();

   var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var languageProvide= Provider.of<AppLanguageProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: height*.05,horizontal: width*0.04),
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
                      hintText: AppLocalizations.of(context)!.email,
                      prefixIcon: Image.asset(AppAssets.emailIcon),
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
                      prefixIcon: Image.asset(AppAssets.passwordIcon),
                      suffixIcon: InkWell(onTap: (){

                      },
                          child: Image.asset(AppAssets.hidePassIcon)),
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
                    SizedBox(height: height*0.005,),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: (){},
                          child: Text('${AppLocalizations.of(context)!.forget_password}?',
                            style: AppStyles.boldItalic16Primary,

                          )),
                    ),
                    SizedBox(height: height*0.01,),
                    CustomElevatedButton(onPressed: () {
                      login();
                    },text: AppLocalizations.of(context)!.login,),
                    SizedBox(height: height*0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.no_account,
                          style: AppStyles.medium16Black,),
                        SizedBox(width: width*0.01,),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(AppRoutes.registerRouteName);
                          },
                          child: Text(AppLocalizations.of(context)!.create_account,
                            style: AppStyles.boldItalic16Primary,),
                        ),

                      ],
                    ),
                    SizedBox(height: height*0.02,),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            indent: width*0.10,
                            endIndent: width*0.04,
                            thickness: 2,
                            color: AppColors.primaryLight,

                          ),
                        ),
                        Text(AppLocalizations.of(context)!.or,
                          style: AppStyles.medium16Primary,),
                        Expanded(
                          child: Divider(
                            indent: width*0.04,
                            endIndent: width*0.10,
                            thickness: 2,
                            color: AppColors.primaryLight,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height*0.02,),
                    CustomElevatedButton(
                      mainAxisAlignment: MainAxisAlignment.center,
                      icon: true,
                      iconWidget: Image.asset(AppAssets.googleIcon),
                      backgroundColor: AppColors.transparentColor,
                      textStyle: AppStyles.medium20Primary,
                      onPressed: () {
                        login();

                      },text: AppLocalizations.of(context)!.login_google,
                    ),
                  ],
                )),
                SizedBox(height: height*0.03,),
                LanguageSwitcher(),


              ],
            ),
          ),
        ),
      ),


    );
  }

  void login() {
    if(formKey.currentState?.validate()==true){
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);

    }
  }
}
