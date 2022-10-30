import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/services/database/database.dart';

class ConversationDatabase {

  ConversationDatabase();

  static CollectionReference conversationsCollection = FirebaseFirestore.instance.collection('conversations');

  Future<void> createConversation(Map<String, dynamic> conversation) async{
    try {
      final result = await conversationsCollection.add(conversation);

      await updateConversationDetails({"id" : result.id});

    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<void> updateConversationDetails(Map<String, dynamic> values) async{
    try {
      await conversationsCollection.doc(values["id"]).update(values);
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<Conversation?> getConversation(String conversationID) async {
    try {
      final result = await conversationsCollection.where("id", isEqualTo: conversationID).get();

      if (result.docs.isNotEmpty) {
        for (QueryDocumentSnapshot documentSnapshot in result.docs) {
          return Conversation.fromDocumentSnapshot(documentSnapshot);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return null;
    }
  }

  Stream<Conversation> getConversationAsStream(String conversationID) {
    return conversationsCollection
        .where("id", isEqualTo: conversationID)
        .snapshots().map((querySnapshot) {
          Conversation conversation = Conversation.empty();

          for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
            conversation = Conversation.fromDocumentSnapshot(snapshot);
          }
          return conversation;
        }
    );
  }

  Stream<Conversation> getConversationsByOrderID(String orderId) {
    return conversationsCollection
        .where("orderID", isEqualTo: orderId)
        .snapshots().map((querySnapshot) {
          Conversation conversation = Conversation.empty();

          for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
            conversation = Conversation.fromDocumentSnapshot(snapshot);
          }
          return conversation;
        }
    );
  }

  Stream<List<Conversation>> getConversationsByQuery(Query query) {
    return query.snapshots().map((querySnapshot) {
      List<Conversation> conversations = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        conversations.add(Conversation.fromDocumentSnapshot(documentSnapshot));
      }

      return conversations;
    });
  }


  Future<bool> deleteConversation(String conversationID) async {
    try {
      await conversationsCollection.doc(conversationID).delete();
      return true;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return false;
    }
  }
}