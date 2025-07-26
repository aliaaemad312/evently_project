import 'package:cloud_firestore/cloud_firestore.dart';

class Event{
  static const String collectionName='Events';
  String id;
  String image;
  String title;
  String description;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavourite;

  Event({this.id='',
  required this.title,
 required this.description,
    required this.eventName,
    required this.image,
    required this.dateTime,
    required this.time,
    this.isFavourite=false

  });

  Event.fromFireStore(Map<String,dynamic> data): this(
    id:data['id'],
    title:data['title']??'',
    description: data['description']??'',
    image: data['image']??'',
    eventName: data['eventName']??'',

      dateTime: data['dateTime'] is Timestamp
          ? (data['dateTime'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    time:data['time'] ??'',
    isFavourite: data['isFavourite']
  );

  Map<String,dynamic> toFireStore(){
    return {
      'id':id,
      'image':image,
      'title':title,
      'description':description,
      'eventName':eventName,
      'dateTime':dateTime,
      'time':time,
      'isFavourite':isFavourite,


    };

  }

}