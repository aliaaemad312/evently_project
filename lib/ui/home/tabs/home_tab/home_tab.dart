import 'package:evently_app/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_tab_item.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    List<String>eventNameList=
    [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(AppLocalizations.of(context)!.welcome_back,
            style: AppStyles.regular14White,),
            Text('Route Academy',
            style: AppStyles.bold24White,),
          ],
        ),
        actions: [
          ImageIcon(AssetImage(AppAssets.lightThemeIcon),
            color: AppColors.whiteBgColor,
          size: 24,),
          Container(
            margin: EdgeInsets.only(right: width*0.04,left: width*0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteBgColor,
            ),
            padding: EdgeInsets.all(height*0.01),
            child: Text('EN',style: AppStyles.bold14Primary,),
          )
        ],
        bottom: AppBar(
          toolbarHeight: height*0.1,
          title: Column(
            children: [
              Row(
                children: [
                  ImageIcon(AssetImage(AppAssets.mapUnselectedIcon),
                    color: AppColors.whiteBgColor,size: 24,),
                  SizedBox(width: width*.01,),
                  Text('Cairo , Egypt',style: AppStyles.medium14White,)
                ],
              ),
              SizedBox(height: height*0.01,),
              DefaultTabController(length: eventNameList.length,
                  child: TabBar(
                    onTap: (index){
                      selectedIndex=index;
                      setState(() {

                      });
                    },
                    indicatorColor: AppColors.transparentColor,
                    isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.zero,
                      dividerColor: AppColors.transparentColor,
                      tabs: eventNameList.map((eventName) {
                    return EventTabItem(isSelected: selectedIndex==eventNameList.indexOf(eventName), eventName: eventName);
                  },).toList()
                  )
              )
            ],
          ),
        ),

      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(top: height*0.02),
                  itemBuilder: (context, index) {
                    return EventItem();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height*0.02);
                  },
                  itemCount: 20)),
        ],
      ),

    );
  }
}
