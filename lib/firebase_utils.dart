import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event.dart';

class FirebaseUtils{

  static CollectionReference<Event> getEventsCollection(){
   return FirebaseFirestore.instance.collection(Event.collectionName)
        .withConverter<Event>(
      fromFirestore:(snapshot, options) => Event.fromFireStore(snapshot.data()!) ,
      toFirestore: (event, options) => event.toFireStore() ,
    );
  }
  static Future<void> addEventToFireStore(Event event) async{
    CollectionReference<Event> eventsCollection=getEventsCollection();
    DocumentReference<Event> docRef =eventsCollection.doc();
    event.id = docRef.id;
   return docRef.set(event);

  }

  static Future<void> updateEventInFireStore(Event event) async{
    CollectionReference<Event> eventsCollection=getEventsCollection();
    DocumentReference<Event> docRef =eventsCollection.doc(event.id);
    docRef.update({
      'title': event.title,
      'description': event.description,
      'dateTime': event.dateTime,
      'eventName':event.eventName,
      'image':event.image,
      'time':event.time
    });

  }
  static Future<void> deleteEventFromFireStore(Event event)async{
    CollectionReference<Event> eventsCollection=getEventsCollection();
    DocumentReference<Event> docRef =eventsCollection.doc(event.id);
    docRef.delete();
  }
}