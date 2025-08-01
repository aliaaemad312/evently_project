import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/home/add_event/widget/date_or_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../firebase_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../../../model/event.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../providers/event_list_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/toast_utils.dart';
import '../tabs/home_tab/widget/event_tab_item.dart';
import '../tabs/widgets/custom_elevated_button.dart';
import '../tabs/widgets/custom_text_form_field.dart';

class EditEventScreen extends StatefulWidget {

   EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
   int selectedIndex=0;

  TextEditingController titleController=TextEditingController();

  TextEditingController descriptionController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  DateTime? selectedDate;

  String formatedDate='';

  TimeOfDay? selectedTime;

  String formatedTime='';

  String selectedImage='';

  String selectedEventName='';

  late EventListProvider eventListProvider;

  late Event event;
   late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var themeProvider= Provider.of<AppThemeProvider>(context);
    eventListProvider=Provider.of<EventListProvider>(context);
    event=ModalRoute.of(context)!.settings.arguments as Event;


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
    selectedImage=themeProvider.isDarkMode()?eventImageListDark[selectedIndex]:eventImageListLight[selectedIndex];
    selectedEventName=eventNameList[selectedIndex];
    selectedIndex=eventNameList.indexOf(event.eventName);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        iconTheme: IconThemeData(
          color: AppColors.primaryLight,

        ),
        title: Text(AppLocalizations.of(context)!.edit_event,
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
                   selectedIndex==0?event.image:selectedImage),
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
              Form(
                  key: formKey,
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(AppLocalizations.of(context)!.title,
                        style: Theme.of(context).textTheme.titleMedium,),
                      SizedBox(height: height*0.01,),
                      CustomTextFormField(
                        validator: (text) {
                          if(text==null || text.trim().isEmpty){
                            return AppLocalizations.of(context)!.please_enter_event_title;
                          }
                          return null;

                        },
                        controller: titleController,
                        colorBorderSide:themeProvider.isDarkMode()?AppColors.primaryLight:AppColors.greyColor,
                        hintText: event.title,
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        prefixIcon: Image.asset(AppAssets.editIcon,
                          color: themeProvider.isDarkMode()?AppColors.whiteBgColor:AppColors.greyColor,),

                      ),
                      SizedBox(height: height*0.02,),
                      Text(AppLocalizations.of(context)!.description,
                        style: Theme.of(context).textTheme.titleMedium,),
                      SizedBox(height: height*0.01,),
                      CustomTextFormField(
                        validator: (text) {
                          if(text==null || text.trim().isEmpty){
                            return AppLocalizations.of(context)!.please_add_description;
                          }
                          return null;

                        },
                        controller: descriptionController,
                        hintText: event.description,
                        colorBorderSide:themeProvider.isDarkMode()?AppColors.primaryLight:AppColors.greyColor,
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 4,


                      ),
                      SizedBox(height: height*0.01,),
                      DateOrTimeWidget(
                          iconDateOrTimeName: AppAssets.dateIcon,
                          eventDateOrTime: AppLocalizations.of(context)!.event_date,
                          chooseDateOrTime: selectedDate==null ? DateFormat('dd/MM/yyyy').format(event.dateTime): formatedDate,
                          // '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                          onChooseDateOrTimeClicked: chooseDate),
                      DateOrTimeWidget(
                          iconDateOrTimeName: AppAssets.timeIcon,
                          eventDateOrTime: AppLocalizations.of(context)!.event_time,
                          chooseDateOrTime: selectedTime==null? event.time : formatedTime,
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
                            updateEvent();
                          },
                          text: AppLocalizations.of(context)!.update_event),
                    ],
                  )),

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

  void updateEvent()async {
    if(formKey.currentState?.validate()==true){
      event.title=titleController.text;
      event.image=selectedImage;
      event.eventName=selectedEventName;
      event.dateTime=selectedDate!;
      event.description=descriptionController.text;
      event.time=selectedTime!=null ?formatedTime:event.time;
       userProvider=Provider.of<UserProvider>(context);
      await FirebaseUtils.updateEventInFireStore(event,userProvider.currentUser!.id);

            ToastUtils.toastMsg(
                msg:AppLocalizations.of(context)!.event_updated_successfully,
                backgroundColor: AppColors.primaryLight,
                textColor: AppColors.whiteColor
            );
            eventListProvider.getAllEvents(userProvider.currentUser!.id);

            Navigator.pop(context);



    }

  }
}
