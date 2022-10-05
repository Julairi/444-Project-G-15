import 'package:cloud_firestore/cloud_firestore.dart';

class Order {

  late String id, postID, skills, summary, userID, userName, orderStatus;
  late DateTime timeApplied;
  late bool hasBeenPaid;

  Order({required this.id, required this.postID, required this.skills,
    required this.summary, required this.userID, required this.userName,
    required this.orderStatus, required this.timeApplied, this.hasBeenPaid = false});

  Order.empty() {
    id = "";
    postID = "";
    skills = "";
    summary = "";
    userID = "";
    userName = "";
    orderStatus = "";
    timeApplied = DateTime.now();
    hasBeenPaid = false;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postID': postID,
      'skills': skills,
      'summary': summary,
      'userID': userID,
      'userName': userName,
      'orderStatus': orderStatus,
      "timeApplied": Timestamp.fromDate(timeApplied),
      "hasBeenPaid": hasBeenPaid,
    };
  }

  factory Order.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Timestamp timestamp = snapshot.get("timeApplied") ?? Timestamp.now();
    return Order(
      id: snapshot.get('id') ?? "",
      postID: snapshot.get('postID') ?? "",
      skills: snapshot.get('skills') ?? "",
      summary: snapshot.get('summary') ?? "",
      userID: snapshot.get('userID') ?? "",
      userName: snapshot.get('userName') ?? "",
      orderStatus: snapshot.get('orderStatus') ?? "",
      timeApplied: timestamp.toDate(),
      hasBeenPaid: snapshot.get('hasBeenPaid') ?? false,
    );
  }
}