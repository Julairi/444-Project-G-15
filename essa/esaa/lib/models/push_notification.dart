import 'package:cloud_firestore/cloud_firestore.dart';

class PushNotification {
  late String id, uID, title, body;
  late DateTime? timeSent;

  PushNotification({
    this.id = "",
    this.uID = "",
    required this.title,
    required this.body,
    this.timeSent,
  }){
    timeSent = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
    };
  }

  Map<String, dynamic> toFullMap() {
    return {
      'id': id,
      'uID': uID,
      'title': title,
      'body': body,
      "timeSent": Timestamp.fromDate(timeSent!),
    };
  }

  PushNotification.empty() {
    id = "";
    uID = "";
    title = "";
    body = "";
    timeSent = DateTime.now();
  }

  factory PushNotification.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Timestamp timestamp = snapshot.get("timeSent") ?? Timestamp.now();
    return PushNotification(
      id: snapshot.get('id') ?? "",
      uID: snapshot.get('uID') ?? "",
      title: snapshot.get('title') ?? "",
      body: snapshot.get('body') ?? "",
      timeSent: timestamp.toDate(),
    );
  }
}