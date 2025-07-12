import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DateOrTimeWidget extends StatelessWidget {
  String iconDateOrTimeName;
  String eventDateOrTime;
  String chooseDateOrTime;
  VoidCallback onChooseDateOrTimeClicked;
   DateOrTimeWidget({super.key,
   required this.iconDateOrTimeName,
     required this.eventDateOrTime,
     required this.chooseDateOrTime,
     required this.onChooseDateOrTimeClicked
   });

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(iconDateOrTimeName,
        color: Theme.of(context).dividerColor,),
        SizedBox(width: width*0.03,),
        Text(eventDateOrTime,
        style: Theme.of(context).textTheme.titleMedium,),
        Spacer(),
        TextButton(
            onPressed: (){
              onChooseDateOrTimeClicked();
            },
            child: Text(chooseDateOrTime,
                style: AppStyles.medium16Primary))

      ],
    );
  }
}
