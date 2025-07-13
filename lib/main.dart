
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/ui/auth/login/login_screen.dart';
import 'package:evently_app/ui/auth/register/register_screen.dart';
import 'package:evently_app/ui/home/add_event/add_event_screen.dart';
import 'package:evently_app/ui/home/home_screen.dart';
import 'package:evently_app/ui/onboarding/intro_screen.dart';
import 'package:evently_app/ui/onboarding/onboarding_screen.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppLanguageProvider(),),
    ChangeNotifierProvider(create: (context) => AppThemeProvider(),),
  ],

      child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var themeProvider=Provider.of<AppThemeProvider>(context);
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.firstRouteName,
      routes: {
        AppRoutes.homeRouteName:(context)=>HomeScreen(),
        AppRoutes.introRouteName:(context)=>OnboardingScreen(),
        AppRoutes.firstRouteName:(context)=>IntroScreen(),
        AppRoutes.loginRouteName:(context)=>LoginScreen(),
        AppRoutes.registerRouteName:(context)=>RegisterScreen(),
        AppRoutes.addEventRouteName:(context)=>AddEventScreen(),


      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}
