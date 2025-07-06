import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:evently_app/ui/home/tabs/favourite/favourite_tab.dart';
import 'package:evently_app/ui/home/tabs/home_tab/home_tab.dart';
import 'package:evently_app/ui/home/tabs/map/map_tab.dart';
import 'package:evently_app/ui/home/tabs/profile/profile_tab.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen ({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  // void _onTap(int index) {
  //   setState((){
  //     activeIndex = index;
  //   });
  // }
  List<String> iconPathsSelected = [
    AppAssets.homeSelectedIcon,
    AppAssets.mapSelectedIcon,
    AppAssets.favSelectedIcon,
    AppAssets.profileSelectedIcon,
  ];
  List<String> iconPathsUnselected = [
    AppAssets.homeUnselectedIcon,
    AppAssets.mapUnselectedIcon,
    AppAssets.favUnselectedIcon,
    AppAssets.profileUnselectedIcon,
  ];


  List<Widget>tabs=[HomeTab(),MapTab(),FavouriteTab(),ProfileTab()];

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    List<String>labels=[AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.map,
      AppLocalizations.of(context)!.favourite,
      AppLocalizations.of(context)!.profile];
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () { },
          backgroundColor: Theme.of(context).primaryColor,
          shape: StadiumBorder(side: BorderSide(color: AppColors.whiteColor,width: 5,)),
          child: Icon(Icons.add,size: 35,color: AppColors.whiteColor,),
        //params
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: AnimatedBottomNavigationBar.builder(
      splashColor: AppColors.transparentColor,
      splashRadius: 0,
      height: 60,
      notchMargin: 0,
      backgroundColor: Theme.of(context).primaryColor,
    activeIndex: selectedIndex,
    gapLocation: GapLocation.center,
    notchSmoothness: NotchSmoothness.sharpEdge,
    leftCornerRadius: 0,
    rightCornerRadius: 0,
    onTap: (index) => setState(() => selectedIndex = index),
    itemCount: iconPathsUnselected.length,
    tabBuilder: (int index, bool isActive) {

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isActive? ImageIcon(
            AssetImage(iconPathsSelected[index]),
            size: 24,
            color: AppColors.whiteColor,
          ):ImageIcon(
            AssetImage(iconPathsUnselected[index]),
            size: 24,
            color: AppColors.whiteColor,
          )
          ,
          const SizedBox(height: 4),
          Text(
            labels[index],
            style:AppStyles.bold12White,
          )
        ],
      );
    }),
      body: tabs[selectedIndex],
    );
  }
}
