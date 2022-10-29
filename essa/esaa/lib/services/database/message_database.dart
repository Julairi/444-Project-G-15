import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/app.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/services/database/database.dart';

class MessageDatabase {

  MessageDatabase();

  static CollectionReference messagesCollection = FirebaseFirestore.instance.collection('messages');

  Future<String> addMessage(Map<String, dynamic> message) async{
    try {
      final result = await messagesCollection.add(message);

      await updateMessageDetails({"id" : result.id});

      return result.id;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return "";
    }
  }

  Future<void> updateMessageDetails(Map<String, dynamic> values) async{
    try {
      await messagesCollection.doc(values["id"]).update(values);
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<Message?> getMessage(String messageId) async {
    try {
      final result = await messagesCollection.where("id", isEqualTo: messageId).get();

      if (result.docs.isNotEmpty) {
        for (QueryDocumentSnapshot documentSnapshot in result.docs) {
          return Message.fromDocumentSnapshot(documentSnapshot);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return null;
    }
  }

  Stream<Message> getLastMessage(String conversationID) {
    return  messagesCollection
        .where("conversationID", isEqualTo: conversationID)
        .orderBy("timestamp", descending: true).limit(1)
        .snapshots().map((querySnapshot) {
      Message message = Message.empty();

      for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
        message = Message.fromDocumentSnapshot(snapshot);
      }

      return message;
    });
  }
  Stream<int> getUnreadMessages(String conversationID) {
    return  messagesCollection
        .where("conversationID", isEqualTo: conversationID)
        .where("hasBeenRead", isEqualTo: false)
        .where("receiverID", isEqualTo: App.user.id)
        .snapshots().map((querySnapshot) {
      int unreadMessages = 0;
      for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
        unreadMessages = unreadMessages + 1;
      }

      return unreadMessages;
    });
  }

  Stream<List<Message>> getMessagesByQuery(Query query) {
    return query.snapshots().map((querySnapshot) {
      List<Message> messages = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        messages.add(Message.fromDocumentSnapshot(documentSnapshot));
      }

      return messages;
    });
  }

  Future<bool> deleteMessage(String messageId) async {
    try {
      await messagesCollection.doc(messageId).delete();
      return true;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return false;
    }
  }
}