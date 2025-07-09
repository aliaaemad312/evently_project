import 'package:evently_app/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:evently_app/ui/home/tabs/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteTab extends StatelessWidget {
   FavouriteTab({super.key});
   TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          body: Column(
                children: [
                  SizedBox(height: height*0.02,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: width*0.04),
            child: CustomTextFormField(
                controller:searchController  ,
                colorBorderSide: AppColors.primaryLight,
            hintText: AppLocalizations.of(context)!.search_event,
            hintStyle: AppStyles.bold14Primary,
              prefixIcon: ImageIcon(AssetImage(AppAssets.searchIcon),color: AppColors.primaryLight,)
            ),
          ),
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
        )
    );
  }
}
