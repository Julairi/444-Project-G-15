import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserDatabase{

  String id;

  UserDatabase(this.id){
    if(id == ""){
      id = Auth().uID;
    }
  }

  static CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(Map<String, dynamic> values) async {
    try {
      await usersCollection.doc(id).set(values);

      String? token = await FirebaseMessaging.instance.getToken();

      await updateDetails({
        "id" : values['id'],
        "notificationToken" : token ?? ""
      });

    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<void> updateDetails(Map<String, dynamic> values) async {
    try {
      await usersCollection.doc(id).update(values);
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Stream<User> get user {
    if(id.isNotEmpty) {
      return usersCollection.doc(id).snapshots().map((documentSnapshot) {
        return User.fromDocumentSnapshot(documentSnapshot);
      });
    }else{
      return const Stream<User>.empty();
    }
  }

  Future<User?> getUser (String id) async {
    try {
      final result = await usersCollection.where("id", isEqualTo: id).get();
      if(result.docs.isNotEmpty){
        for (QueryDocumentSnapshot documentSnapshot in result.docs) {
          return User.fromDocumentSnapshot(documentSnapshot);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return null;
    }
  }

}