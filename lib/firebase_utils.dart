import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/model/my_user.dart';

class FirebaseUtils{

  static CollectionReference<Event> getEventsCollection(String uId){
   return getUsersCollection().doc(uId)
       .collection(Event.collectionName)
        .withConverter<Event>(
      fromFirestore:(snapshot, options) => Event.fromFireStore(snapshot.data()!) ,
      toFirestore: (event, options) => event.toFireStore() ,
    );
  }
  static Future<void> addEventToFireStore(Event event,String uId) async{
    CollectionReference<Event> eventsCollection=getEventsCollection(uId);
    DocumentReference<Event> docRef =eventsCollection.doc();
    event.id = docRef.id;
   return docRef.set(event);

  }
    static Future<void> updateEventInFireStore(Event event,String uId) async{
    CollectionReference<Event> eventsCollection=getEventsCollection(uId);
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
  static Future<void> deleteEventFromFireStore(Event event,String uId)async{
    CollectionReference<Event> eventsCollection=getEventsCollection(uId);
    DocumentReference<Event> docRef =eventsCollection.doc(event.id);
    docRef.delete();
  }

  static CollectionReference<MyUser> getUsersCollection(){
   return FirebaseFirestore.instance.collection(MyUser.collectionName)
    .withConverter<MyUser>(
        fromFirestore: (snapshot, options) => MyUser.fromFireStore(snapshot.data()!) ,
        toFirestore:(myUser, options) =>myUser.toFireStore() ,
    );
  }
  static Future<void> addUserToFireStore(MyUser myUser){
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String id)async{
    var querySnapShot = await getUsersCollection().doc(id).get();
    return querySnapShot.data();

  }
}