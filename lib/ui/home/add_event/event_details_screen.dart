import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/event.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/toast_utils.dart';

class EventDetailsScreen extends StatefulWidget {
   EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late Event event;
  late EventListProvider eventListProvider;
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    eventListProvider=Provider.of<EventListProvider>(context);
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    event = ModalRoute
        .of(context)!
        .settings
        .arguments as Event;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparentColor,
          iconTheme: IconThemeData(
            color: AppColors.primaryLight,

          ),
          title: Text(AppLocalizations.of(context)!.event_details,
            style: AppStyles.medium20Primary,),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.editEventRouteName,
                    arguments: event);
              },
              child: Image.asset(AppAssets.updateIcon),
            ),
            SizedBox(width: width * 0.03,),
            InkWell(
              onTap: () {
                deleteEvent();
              },
              child: Image.asset(AppAssets.deleteIcon),
            ),
            SizedBox(width: width * 0.04,),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04,
              vertical: height * 0.02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                      event.image),
                ),
                SizedBox(height: height * 0.02,),
                Text(event.title
                  , style: AppStyles.medium22Primary,),
                SizedBox(height: height * 0.02,),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.01, horizontal: width * 0.02),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: AppColors.primaryLight,
                          width: 1
                      )
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * .04, vertical: width * .04),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryLight
                        ),
                        child: Image.asset(AppAssets.dateIcon,
                          color: Theme
                              .of(context)
                              .hoverColor,),
                      ),
                      SizedBox(width: width * 0.02,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat('yMMMMd').format(event.dateTime),
                            style: AppStyles.medium16Primary,),
                          Text(event.time, style: AppStyles.medium16Black,)

                        ],
                      )

                    ],
                  ),
                ),
                SizedBox(height: height * 0.02,),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.01, horizontal: width * 0.02),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppColors.primaryLight,
                            width: 1
                        )
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * .035, vertical: width * .035),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.primaryLight
                          ),
                          child: Image.asset(AppAssets.locationIcon),
                        ),
                        SizedBox(width: width * 0.02,),
                        Text(
                          AppLocalizations.of(context)!.choose_event_location,
                          style: AppStyles.medium16Primary,),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded,
                          color: AppColors.primaryLight,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(AppAssets.mapImage),
                ),
                SizedBox(height: height * 0.02,),
                Text(AppLocalizations.of(context)!.description,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,),

                Text(event.description,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,),


              ],
            ),
          ),
        ));
  }

  void deleteEvent()async {
    userProvider=Provider.of<UserProvider>(context);
   await FirebaseUtils.deleteEventFromFireStore(event,userProvider.currentUser!.id);
          ToastUtils.toastMsg(
              msg: AppLocalizations.of(context)!.event_deleted_successfully,
              backgroundColor: AppColors.redColor,
              textColor: AppColors.whiteColor
          );
          eventListProvider.getAllEvents(userProvider.currentUser!.id);
          Navigator.pop(context);

  }
}
