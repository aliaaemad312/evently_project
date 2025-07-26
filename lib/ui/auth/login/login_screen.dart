import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/ui/home/tabs/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/home/tabs/widgets/custom_text_form_field.dart';
import 'package:evently_app/ui/switchers/language_switcher.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_theme_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    var themeProvider= Provider.of<AppThemeProvider>(context);

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
                      colorBorderSide:themeProvider.isDarkMode()?AppColors.primaryLight:AppColors.greyColor,
                      hintText: AppLocalizations.of(context)!.password,
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
                          style: Theme.of(context).textTheme.titleMedium,),
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
                        googleLogin();

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

  void login() async{
    if(formKey.currentState?.validate()==true){
      DialogUtils.showLoading(context: context, loadingText: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(context: context, message: 'login successfully',
            title: 'Success!',
            posActionName: 'Ok',
            posAction: (){
              Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
            });

       // print('id:${credential.user?.uid??''}');
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'network-request-failed') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(context: context, message: 'A network error has occurred.',
            title: 'Error!',
            posActionName: 'Ok',);

         } else if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(context: context, message: ' No user found for this email or wrong password',
            title: 'Error!',
            posActionName: 'Ok',);

         }

       }
      catch(e){
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(context: context, message:e.toString(),
          title: 'Error!',
          posActionName: 'Ok',);

      }


      //Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);

    }
  }

   void googleLogin() async {
       try {
         final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

         if (googleUser == null) {
           print('Login canceled by user');
           return;
         }

         final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

         final credential = GoogleAuthProvider.credential(
           accessToken: googleAuth.accessToken,
           idToken: googleAuth.idToken,
         );

         final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
         DialogUtils.showMessage(context: context, message: 'login successfully',
             title: 'Success!',
             posActionName: 'Ok',
             posAction: (){
               Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
             });

        // print('Signed in as ${userCredential.user?.displayName}');
       } catch (e) {
         print('Google Sign-In Error: $e');
       }

   }

}
