import 'package:cloud_firestore/cloud_firestore.dart';

class Post {

  late String id, city, Sdate,Edate, description, time, title, nHours,
      offerStatus, companyName, companyID, maxNoOfApplicants, acceptedApplicants;
  late int payPerHour;
  late DateTime timePosted;

  Post({
    required this.id,
    required this.city,
    required this.Sdate,
    required this.Edate,
    required this.description,
    required this.payPerHour,
    required this.time,
    required this.title,
    required this.nHours,
    required this.offerStatus,
    required this.companyName,
    required this.companyID,
    required this.maxNoOfApplicants,
    required this.acceptedApplicants,
    required this.timePosted,
  });

  Post.empty(){
    id = "";
    title = "";
    description = "";
    city = "";
    Sdate = "";
    Edate = "";
    nHours = "";
    time = "";
    payPerHour = 0;
    acceptedApplicants = "";
    maxNoOfApplicants = "";
    offerStatus = "";
    companyName = "";
    companyID = "";
    timePosted = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'city': city,
      'Startdate': Sdate,
      'EndDate': Edate,
      'description': description,
      'payPerHour': payPerHour,
      'acceptedApplicants': acceptedApplicants,
      'maxNoOfApplicants': maxNoOfApplicants,
      'time': time,
      'title': title,
      'nHours': nHours,
      'offerStatus': offerStatus,
      'companyName': companyName,
      'companyID': companyID,
      "timePosted": Timestamp.fromDate(timePosted),
    };
  }

  factory Post.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Timestamp timestamp = snapshot.get("timePosted") ?? Timestamp.now();
    return Post(
      id: snapshot.get('id') ?? "",
      city: snapshot.get('city') ?? "",
      Sdate: snapshot.get('Startdate') ?? "",
      Edate: snapshot.get('EndDate') ?? "",
      description: snapshot.get('description') ?? "",
      payPerHour: snapshot.get('payPerHour') ?? 0,
      acceptedApplicants: snapshot.get('acceptedApplicants') ?? "",
      maxNoOfApplicants: snapshot.get('maxNoOfApplicants') ?? "",
      time: snapshot.get('time') ?? "",
      title: snapshot.get('title') ?? "",
      nHours: snapshot.get('nHours') ?? "",
      offerStatus: snapshot.get('offerStatus') ?? "",
      companyName: snapshot.get('companyName') ?? "",
      companyID: snapshot.get('companyID') ?? "",
      timePosted: timestamp.toDate(),
    );
  }
}