import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_tab_item.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/event.dart';
import '../../../../providers/user_provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {



  @override
  Widget build(BuildContext context) {
    var eventListProvider=Provider.of<EventListProvider>(context);
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var userProvider= Provider.of<UserProvider>(context);
    eventListProvider.getEventNameList(context);
    if(eventListProvider.eventsList.isEmpty){
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }




    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(AppLocalizations.of(context)!.welcome_back,
            style: AppStyles.regular14White,),
            Text(userProvider.currentUser!.name,
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
              DefaultTabController(length: eventListProvider.eventNameList.length,
                  child: TabBar(
                    onTap: (index){
                     eventListProvider.changeSelectedIndex(index,userProvider.currentUser!.id);
                    },
                    indicatorColor: AppColors.transparentColor,
                    isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.zero,
                      dividerColor: AppColors.transparentColor,
                      tabs: eventListProvider.eventNameList.map((eventName) {
                    return EventTabItem(selectedBgColor: Theme.of(context).focusColor,
                        selectedTextStyle: Theme.of(context).textTheme.headlineMedium!,
                        unSelectedTextStyle: Theme.of(context).textTheme.headlineSmall!,

                        isSelected: eventListProvider.selectedIndex==eventListProvider.eventNameList.indexOf(eventName), eventName: eventName);
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
              child: Visibility(
                child: eventListProvider.filterEventList.isEmpty?
                    Center(child: Text(AppLocalizations.of(context)!.no_events_found,
                    style: AppStyles.bold20Black,),):
                ListView.separated(
                  padding: EdgeInsets.only(top: height*0.02),
                    itemBuilder: (context, index) {
                      return EventItem(event:eventListProvider.filterEventList[index] ,);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height*0.02);
                    },
                    itemCount: eventListProvider.filterEventList.length),
              )),
        ],
      ),

    );
  }

}
