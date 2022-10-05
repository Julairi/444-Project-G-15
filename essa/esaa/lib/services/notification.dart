import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Notification {
  Future<void> sendNotification (User user, PushNotification notification) async {
    notification.uID = user.id;
    notification.timeSent = DateTime.now();

    await PushNotificationDatabase().createPushNotification(notification.toFullMap());

    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    String key = "";

    key = await getKey() ?? "";

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "key=$key",
    };

    final data = {
      "registration_ids": [user.notificationToken],
      "collapse_key": "type_a",
      "notification": notification.toMap(),
    };

    try{
      final response = await http.post(
          url,
          body: json.encode(data),
          encoding: Encoding.getByName('utf-8'),
          headers: headers
      );

      if (response.statusCode != 200) {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<String?> getKey() async {
    try {
      CollectionReference dataReference = FirebaseFirestore.instance.collection("appData");
      final result = await dataReference.doc("fcmKey").get();

      return result.get("key") as String;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return null;
    }
  }
}
