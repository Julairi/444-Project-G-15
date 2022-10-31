import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late String id, conversationID, details, senderID, receiverID, senderImageUrl;
  late DateTime timestamp;
  late bool hasBeenRead ;

  Message({
    this.id = "",
    required this.conversationID,
    required this.details,
    required this.senderID,
    required this.receiverID,
    required this.senderImageUrl,
    required this.timestamp,
    this.hasBeenRead = false,
  });

  Message.empty(){
    id = "";
    conversationID = "";
    details = "";
    senderID = "";
    receiverID = "";
    senderImageUrl = "";
    timestamp = DateTime.now();
    hasBeenRead = false;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conversationID': conversationID,
      'details': details,
      'senderID': senderID,
      'receiverID': receiverID,
      'senderImageUrl': senderImageUrl,
      'timestamp': timestamp,
      'hasBeenRead': hasBeenRead,
    };
  }

  factory Message.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Timestamp timestamp = snapshot.get("timestamp") ?? Timestamp.now();
    return Message(
        id: snapshot.get('id') ?? "",
        conversationID: snapshot.get('conversationID') ?? "",
        details: snapshot.get('details') ?? "",
        senderID: snapshot.get('senderID') ?? "",
        receiverID: snapshot.get('receiverID') ?? "",
        senderImageUrl: snapshot.get('senderImageUrl') ?? "",
        timestamp: timestamp.toDate(),
        hasBeenRead: snapshot.get('hasBeenRead') ?? false
    );
  }
}