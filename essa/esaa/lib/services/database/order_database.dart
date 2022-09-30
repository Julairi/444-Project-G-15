import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/models/models.dart';

import 'database.dart';

class OrderDatabase {

  OrderDatabase();

  static CollectionReference ordersCollection = FirebaseFirestore.instance.collection('orders');

  Future<bool> doesOrderExist(Order order) async {
    try {
      final result = await ordersCollection
          .where("postID", isEqualTo: order.postID)
          .where("userID", isEqualTo: order.userID)
          .get();
      return result.size > 0;
    } on FirebaseException catch (e) {
        Default.showDatabaseError(e);
        return Future.delayed(const Duration(seconds: 0), (){ return false;});
    }
  }

  Future<void> createOrder(Map<String, dynamic> order) async{
    try {
      final result = await ordersCollection.add(order);

      await updateOrderDetails({"id" : result.id});

    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<void> updateOrderDetails(Map<String, dynamic> values) async{
    try {
      await ordersCollection.doc(values["id"]).update(values);
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<void> rejectAll(String postID) async{
    try {
      final querySnapshot = await ordersCollection
          .where("postID", isEqualTo: postID)
          .where("orderStatus", isEqualTo: 'pending').get();

      for(DocumentSnapshot snapshot in querySnapshot.docs){
        Order order = Order.fromDocumentSnapshot(snapshot);
        order.orderStatus = 'rejected';
        await updateOrderDetails({
          'id': order.id,
          'orderStatus': order.orderStatus
        });
      }
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }


}