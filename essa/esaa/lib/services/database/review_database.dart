import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/services/database/database.dart';

class ReviewDatabase {

  String uID;
  ReviewDatabase(this.uID);

  static CollectionReference reviewsCollection = FirebaseFirestore.instance.collection('reviews');

  Future<String> createReview(Map<String, dynamic> review) async{
    try {
      final result = await reviewsCollection.add(review);

      await updateReviewDetails({"id" : result.id});

      return result.id;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return "";
    }
  }

  Future<void> updateReviewDetails(Map<String, dynamic> values) async{
    try {
      await reviewsCollection.doc(values["id"]).update(values);
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Stream<List<Review>> get reviews {
    return reviewsCollection
        .where('uID', isEqualTo: uID)
        .orderBy("timePosted", descending: true)
        .snapshots().map((querySnapshot) {
      List<Review> reviews = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        reviews.add(Review.fromDocumentSnapshot(documentSnapshot));
      }

      return reviews;
    });
  }

  Future<Review?> getReview(String reviewId) async {
    try {
      final result = await reviewsCollection.where("id", isEqualTo: reviewId).get();

      if (result.docs.isNotEmpty) {
        for (QueryDocumentSnapshot documentSnapshot in result.docs) {
          return Review.fromDocumentSnapshot(documentSnapshot);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return null;
    }
  }

  Future<bool> hasUserBeenReviewed({required String reviewerID, required String orderID}) async {
    try {
      final snapshot = await reviewsCollection
          .where("uID", isEqualTo: uID)
          .where("reviewerID", isEqualTo: reviewerID)
          .where("orderID", isEqualTo: orderID).get();

      return snapshot.docs.isNotEmpty;

    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return false;
    }
  }

  Stream<List<Review>> getReviewsByQuery(Query query) {
    return query.snapshots().map((querySnapshot) {
      List<Review> reviews = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        reviews.add(Review.fromDocumentSnapshot(documentSnapshot));
      }

      return reviews;
    });
  }

  Future<bool> deleteReview(String reviewId) async {
    try {
      await reviewsCollection.doc(reviewId).delete();
      return true;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return false;
    }
  }
}