import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_styles.dart';

class OnboardingScreen extends StatefulWidget {

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
    // pushReplacement(
    //     MaterialPageRoute(builder: (_) => HomeScreen()),
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var pageDecoration = PageDecoration(
      titleTextStyle: AppStyles.bold20Primary,
      bodyTextStyle: AppStyles.medium16Black,
      pageColor: AppColors.whiteBgColor,
      bodyAlignment: Alignment.center,
      pageMargin: EdgeInsets.zero,
    );
    return IntroductionScreen(
      globalBackgroundColor: AppColors.whiteBgColor,
      allowImplicitScrolling: true,
      autoScrollDuration: 2000,
      infiniteAutoScroll: true,
      globalHeader: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Image.asset(AppAssets.introLogo),
        ),
      ),
      pages: [
        PageViewModel(
          image: null,
          title: '',
          bodyWidget: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppAssets.introLight2),
                SizedBox(height: height * 0.02),
                Text(
                  "Find Events That Inspire You",
                  style: AppStyles.bold20Primary,

                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
                  style: AppStyles.medium16Black,

                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          image: null,
          title: '',
          bodyWidget: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppAssets.introLight3),
                SizedBox(height: height * 0.02),
                Text(
                  "Effortless Event Planning",
                  style: AppStyles.bold20Primary,
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
                  style: AppStyles.medium16Black,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          image: null,
          title: '',
          bodyWidget: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppAssets.introLight4),
                SizedBox(height: height * 0.02),
                Text(
                  "Connect with Friends & Share Moments",
                  style: AppStyles.bold20Primary,

                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
                  style: AppStyles.medium16Black,

                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
          decoration: pageDecoration,
        ),
      ],

      onDone: () => _onIntroEnd(context),

      showBackButton: true,
      back: Text('Back', style: AppStyles.bold16Primary),
      next: Text('Next', style: AppStyles.bold16Primary),
      done: Text('Finish', style: AppStyles.bold16Primary),

      dotsDecorator: DotsDecorator(
        size: Size(8.0, 8.0),
        color: AppColors.blackColor,
        activeColor: AppColors.primaryLight,
        activeSize: Size(20.0, 8.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(27.0)),
        ),
      ),
      dotsFlex: 2,
    );
  }
}
