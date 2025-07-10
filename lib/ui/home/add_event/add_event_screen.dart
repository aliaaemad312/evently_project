import 'package:evently_app/ui/home/add_event/widget/date_or_time_widget.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_tab_item.dart';
import 'package:evently_app/ui/home/tabs/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/home/tabs/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_theme_provider.dart';

class AddEventScreen extends StatefulWidget {
   AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedIndex=0;
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  DateTime? selectedDate;
  String formatedDate='';
  TimeOfDay? selectedTime;
  String formatedTime='';


  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var themeProvider= Provider.of<AppThemeProvider>(context);

    List<String>eventNameList=
    [
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
    List<String>eventImageListLight=[
      AppAssets.sportLight,
      AppAssets.birthdayLight,
      AppAssets.meetingLight,
      AppAssets.gamingLight,
      AppAssets.workshopLight,
      AppAssets.bookClubLight,
      AppAssets.exhibitionLight,
      AppAssets.holidayLight,
      AppAssets.eatingLight,

    ];

    List<String>eventImageListDark=[
      AppAssets.sportDark,
      AppAssets.birthdayDark,
      AppAssets.meetingDark,
      AppAssets.gamingDark,
      AppAssets.workshopDark,
      AppAssets.bookClubDark,
      AppAssets.exhibitionDark,
      AppAssets.holidayDark,
      AppAssets.eatingDark,

    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
     appBar: AppBar(
       backgroundColor: AppColors.transparentColor,
       iconTheme: IconThemeData(
         color: AppColors.primaryLight,

       ),
       title: Text(AppLocalizations.of(context)!.create_event,
       style: AppStyles.medium20Primary,),
       centerTitle: true,
     ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                    themeProvider.isDarkMode()? eventImageListDark[selectedIndex]: eventImageListLight[selectedIndex]),
              ),
              SizedBox(height: height*0.02,),
              SizedBox(
                height: height*0.04,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        selectedIndex=index;
                        setState(() {
          
                        });
                      },
                      child: EventTabItem(
                        selectedTextStyle: Theme.of(context).textTheme.headlineSmall!,
                        unSelectedTextStyle: Theme.of(context).textTheme.headlineMedium!,
                        selectedBgColor: AppColors.primaryLight,
                        borderColor: AppColors.primaryLight,
                          isSelected: selectedIndex==index,
                          eventName: eventNameList[index]),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: width*0.01,);
                  },
                  itemCount: eventNameList.length)),
              SizedBox(height: height*0.02,),
              Text(AppLocalizations.of(context)!.title,
              style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: height*0.01,),
              CustomTextFormField(controller: titleController,
                colorBorderSide:themeProvider.isDarkMode()?AppColors.primaryLight:AppColors.greyColor,
                hintText: AppLocalizations.of(context)!.event_title,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                prefixIcon: Image.asset(AppAssets.editIcon,
                color: themeProvider.isDarkMode()?AppColors.whiteBgColor:AppColors.greyColor,),
          
              ),
              SizedBox(height: height*0.02,),
              Text(AppLocalizations.of(context)!.description,
                style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: height*0.01,),
              CustomTextFormField(controller: descriptionController,
                hintText: AppLocalizations.of(context)!.event_description,
                colorBorderSide:themeProvider.isDarkMode()?AppColors.primaryLight:AppColors.greyColor,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                maxLines: 4,
          
          
              ),
              SizedBox(height: height*0.01,),
              DateOrTimeWidget(
                  iconDateOrTimeName: AppAssets.dateIcon,
                  eventDateOrTime: AppLocalizations.of(context)!.event_date,
                  chooseDateOrTime: selectedDate==null ? AppLocalizations.of(context)!.choose_date : formatedDate,
                  // '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                  onChooseDateOrTimeClicked: chooseDate),
              DateOrTimeWidget(
                  iconDateOrTimeName: AppAssets.timeIcon,
                  eventDateOrTime: AppLocalizations.of(context)!.event_time,
                  chooseDateOrTime: selectedTime==null? AppLocalizations.of(context)!.choose_time : formatedTime,
                  onChooseDateOrTimeClicked: chooseTime),
              SizedBox(height: height*0.01,),
              Text(AppLocalizations.of(context)!.location,
              style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: height*0.01,),
              Container(
                padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.02),
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
                      padding: EdgeInsets.symmetric(horizontal: width*.03,vertical: width*.03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryLight
                      ),
                      child: Image.asset(AppAssets.locationIcon),
                    ),
                    SizedBox(width: width*0.02,),
                    Text(AppLocalizations.of(context)!.choose_event_location,
                    style: AppStyles.medium16Primary,),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded,
                      color: AppColors.primaryLight,)
                  ],
                ),
              ),
              SizedBox(height: height*0.02,),
              CustomElevatedButton(
                  onPressed: (){
                    addEvent();
                  },
                  text: AppLocalizations.of(context)!.add_event),
              SizedBox(height: height*0.02,),
            ],
          ),
        ),
      ),
    );
  }
  void chooseDate()async{
    var chooseDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: DateTime.now()
    );
    selectedDate=chooseDate;
    if(selectedDate!=null){
      formatedDate=DateFormat('dd/MM/yyyy').format(selectedDate!);
      setState(() {

      });
    }


  }
  void chooseTime()async{
    var chooseTime= await showTimePicker(
        context: context,
        initialTime:TimeOfDay.now(),
    );
    selectedTime=chooseTime;
    if(selectedTime!=null){
      formatedTime=selectedTime!.format(context);
      setState(() {

      });
    }


  }

  void addEvent() {

  }
}
