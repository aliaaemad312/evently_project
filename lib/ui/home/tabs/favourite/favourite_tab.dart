import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:evently_app/ui/home/tabs/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FavouriteTab extends StatefulWidget {

   FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
   TextEditingController searchController = TextEditingController();
   late EventListProvider eventListProvider;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      eventListProvider.getAllFavouriteEvents();
    },);


  }

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    eventListProvider=Provider.of<EventListProvider>(context);
    if(eventListProvider.favouriteEventList.isEmpty){
      eventListProvider.getAllFavouriteEvents();
    }
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
              child: eventListProvider.favouriteEventList.isEmpty?
              Center(
                child: Text(AppLocalizations.of(context)!.no_favourite_events_found,
                style: AppStyles.bold20Black,),
                
              ):
              ListView.separated(
                  padding: EdgeInsets.only(top: height*0.02),
                  itemBuilder: (context, index) {
                    return EventItem(event: eventListProvider.favouriteEventList[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height*0.02);
                  },
                  itemCount: eventListProvider.favouriteEventList.length)),
                ],
              ),
        )
    );
  }
}
