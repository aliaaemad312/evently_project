import 'package:evently_app/model/event.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  Event event;
   EventItem({super.key,required this.event});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var eventListProvider=Provider.of<EventListProvider>(context);
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(AppRoutes.eventDetailsRouteName,arguments: event);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width*0.04),
        height: height*0.31,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryLight,
          width: 2),
          image: DecorationImage(
              image: AssetImage(event.image),fit: BoxFit.fill)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: width*.02,
              vertical: height*.01),
              padding: EdgeInsets.symmetric(horizontal: width*.02,
                  vertical: height*.001),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteBgColor
              ),
              child: Column(
                children: [
                  Text(event.dateTime.day.toString(),
                  style: AppStyles.bold20Primary,),
                  Text(
                    DateFormat('MMM').format(event.dateTime),
                    style: AppStyles.bold14Primary,)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width*.02,
                  vertical: height*.01),
              padding: EdgeInsets.symmetric(horizontal: width*.02,
                  vertical: height*.01),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.whiteBgColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(event.title,
                      style: AppStyles.bold14Black,),
                  ),
                  InkWell(
                    onTap: (){
                      eventListProvider.updateIsFavourite(event);
                    },
                      child:event.isFavourite == true ?
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset(AppAssets.favIconFill,
                              color: AppColors.primaryLight,),
                          )
                          :
                      Image.asset(AppAssets.favIconEmpty,
                        color: AppColors.primaryLight,))
                ],
              ),
            ),

          ],
        ),
      ),
    );
}
}
