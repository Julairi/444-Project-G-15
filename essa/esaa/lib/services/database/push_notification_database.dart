import 'package:cloud_firestore/cloud_firestore.dart';

import 'database.dart';

class PushNotificationDatabase {

  PushNotificationDatabase();

  static CollectionReference pushNotificationsCollection = FirebaseFirestore.instance.collection('pushNotifications');

  Future<void> createPushNotification(Map<String, dynamic> notification) async{
    try {
      final result = await pushNotificationsCollection.add(notification);

      await updatePushNotificationDetails({"id" : result.id});

    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<void> updatePushNotificationDetails(Map<String, dynamic> values) async{
    try {
      await pushNotificationsCollection.doc(values["id"]).update(values);
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

}