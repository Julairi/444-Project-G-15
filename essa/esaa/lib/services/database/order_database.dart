import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/services/notification.dart';

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

        final user = await UserDatabase(order.userID).getUser(order.userID);

        if(user != null) {
          await Notification().sendNotification(
              user,
              PushNotification(
                title: "طلب مرفوض",
                body: "يؤسفناإعلامك برفضك لهذه الوظيفة"
              )
          );
        }
      }
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<void> deleteAll(String postID) async{
    try {
      final querySnapshot = await ordersCollection
          .where("postID", isEqualTo: postID)
          .where("orderStatus", isEqualTo: 'pending').get();

      for(DocumentSnapshot snapshot in querySnapshot.docs){
        Order order = Order.fromDocumentSnapshot(snapshot);
        order.orderStatus = 'deleted';

        await updateOrderDetails({
          'id': order.id,
          'orderStatus': order.orderStatus
        });

        final user = await UserDatabase(order.userID).getUser(order.userID);

        if(user != null) {
          await Notification().sendNotification(
              user,
              PushNotification(
                title: " طلب مرفوض",
                body: "لقد تم حذف عرض الوظيفة من قبل الشركة"
              )
          );
        }
      }
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<List<Order>> getOrders (String postID) async{
    try {
      final querySnapshot = await ordersCollection
          .where("postID", isEqualTo: postID).get();

      List<Order> orders = [];
      for(DocumentSnapshot snapshot in querySnapshot.docs){
        Order order = Order.fromDocumentSnapshot(snapshot);

        orders.add(order);
      }

      return orders;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return [];
    }

  }

  Stream<List<Order>> getOrdersAsStream(String postID) {
    return ordersCollection
        .where("postID", isEqualTo: postID)
        .snapshots().map((querySnapshot) {

      List<Order> orders = [];
      for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
        Order order = Order.fromDocumentSnapshot(snapshot);
        orders.add(order);
      }
      return orders;
    }
    );
  }

}