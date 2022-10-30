import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  late String id, title, orderID;
  late List<String> members = [], messages = [];
  late DateTime lastUpdated;

  Conversation({
    this.id = "",
    required this.title,
    required this.orderID,
    required this.members,
    required this.messages,
    required this.lastUpdated,
  });

  Conversation.empty(){
    id = "";
    title = "";
    orderID = "";
    members = [];
    messages = [];
    lastUpdated = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'orderID': orderID,
      'members': members,
      'messages': messages,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
    };
  }

  Conversation.fromDocumentSnapshot(DocumentSnapshot snapshot){
    id = snapshot.get('id') ?? "";
    title = snapshot.get('title') ?? "";
    orderID = snapshot.get('orderID') ?? "";
    members = _dynamicToString(snapshot.get('members') ?? []);
    messages = _dynamicToString(snapshot.get('messages') ?? []);
    final Timestamp timestamp = snapshot.get("lastUpdated") ?? Timestamp.now();
    lastUpdated = timestamp.toDate();
  }

  List<String> _dynamicToString(List<dynamic> input){
    List<String> output = [];
    for(dynamic d in input){
      output.add(d as String);
    }
    return output;
  }
}