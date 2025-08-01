import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../l10n/app_localizations.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier{
  List<Event>eventsList=[];
  List<Event>filterEventList=[];
  List<String>eventNameList=[];
  List<Event>favouriteEventList=[];
  int selectedIndex=0;

  List<String>getEventNameList(BuildContext context){
    return eventNameList= [
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
  }



  void getAllEvents(String uId)async{
    QuerySnapshot<Event> querySnapshot= await FirebaseUtils.getEventsCollection(uId).get();
    eventsList= querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    filterEventList=eventsList;
    filterEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getFilterEvents(String uId)async{
    var querySnapShot= await FirebaseUtils.getEventsCollection(uId).get();
    eventsList= querySnapShot.docs.map((doc) {
      return doc.data();
    },).toList();
    filterEventList=eventsList.where((event) {
      return event.eventName== eventNameList[selectedIndex];

    }).toList();
    filterEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();



  }
  void updateIsFavourite(Event event,String uId){
    FirebaseUtils.getEventsCollection(uId).doc(event.id).
    update({'isFavourite': !event.isFavourite})
    .then((value) {
      ToastUtils.toastMsg(msg: 'Event Updated Successfully',
          backgroundColor: AppColors.greenColor,
          textColor: AppColors.whiteColor);

      selectedIndex==0 ? getAllEvents(uId):getFilterEvents(uId);
      getAllFavouriteEvents(uId);

    },);
    //     .timeout(Duration(milliseconds: 500),
    // onTimeout: () {
    //       ToastUtils.toastMsg(msg: 'Event Updated Successfully',
    //           backgroundColor: AppColors.greenColor,
    //           textColor: AppColors.whiteColor);
    //
    //       selectedIndex==0 ? getAllEvents():getFilterEvents();
    //       getAllFavouriteEvents();
    //
    // });
    notifyListeners();

}

  void getAllFavouriteEvents(String uId)async{
    var querySnapshot =await FirebaseUtils.getEventsCollection(uId).get();
    eventsList=querySnapshot.docs.map((doc) => doc.data(),
    ).toList();
    favouriteEventList = eventsList.where((event) {
     return event.isFavourite==true;
    },).toList();
    notifyListeners();
  }


  void changeSelectedIndex(int newSelectedIndex,String uId){
    selectedIndex=newSelectedIndex;
    selectedIndex==0 ? getAllEvents(uId):getFilterEvents(uId);

  }

}