import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/services/services.dart';

class UserDatabase{

  String id;

  UserDatabase(this.id){
    if(id == ""){
      id = Auth().uID;
    }
  }

  static CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(Map<String, dynamic> values) async {
    try {
      await userCollection.doc(id).set(values);
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<void> updateDetails(Map<String, dynamic> values) async {
    try {
      await userCollection.doc(id).update(values);
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Stream<User> get user {
    if(id.isNotEmpty) {
      return userCollection.doc(id).snapshots().map((documentSnapshot) {
        return User.fromDocumentSnapshot(documentSnapshot);
      });
    }else{
      return const Stream<User>.empty();
    }
  }

}