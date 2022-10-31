import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  late double rating;
  late String id, uID, comment, orderID, reviewerID;
  late DateTime timePosted;

  Review({
    required this.rating,
    this.id = "",
    required this.uID,
    required this.comment,
    required this.orderID,
    required this.timePosted,
    required this.reviewerID,
  });

  Review.empty(){
    rating = 0.0;
    id = "";
    uID = "";
    comment = "";
    orderID = "";
    reviewerID = "";
    timePosted = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'id': id,
      'uID': uID,
      'comment': comment,
      'orderID': orderID,
      'reviewerID': reviewerID,
      'timePosted': Timestamp.fromDate(timePosted),
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    final Timestamp timestamp = map["timePosted"] ?? Timestamp.now();
    return Review(
      rating: map['rating'] as double,
      id: map['id'] as String,
      uID: map['uID'] as String,
      comment: map['comment'] as String,
      orderID: map['orderID'] as String,
      reviewerID: map['reviewerID'] as String,
      timePosted: timestamp.toDate(),
    );
  }
  factory Review.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Timestamp timestamp = snapshot.get("timePosted") ?? Timestamp.now();
    return Review(
      rating: snapshot.get('rating') as double,
      id: snapshot.get('id') as String,
      uID: snapshot.get('uID') as String,
      comment: snapshot.get('comment') as String,
      orderID: snapshot.get('orderID') as String,
      reviewerID: snapshot.get('reviewerID') as String,
      timePosted: timestamp.toDate(),
    );
  }
}