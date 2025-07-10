import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width*0.04),
      height: height*0.31,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryLight,
        width: 2),
        image: DecorationImage(
            image: AssetImage(AppAssets.birthdayLight),fit: BoxFit.fill)
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
                Text('22',
                style: AppStyles.bold20Primary,),
                Text('Nov',
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
                  child: Text('This is a Birthday Party ',
                    style: AppStyles.bold14Black,),
                ),
                InkWell(
                  onTap: (){},
                    child: Image.asset(AppAssets.favIcon,
                      color: AppColors.primaryLight,))
              ],
            ),
          ),

        ],
      ),
    );
}
}
