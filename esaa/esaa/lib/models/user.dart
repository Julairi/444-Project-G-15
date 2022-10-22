import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late String name,
      address,
      id,
      nationalID,
      contact,
      email,
      imgUrl,
      sex,
      userType,
      description,
      notificationToken;
  late List rates;

  User({
    required this.name,
    required this.address,
    required this.id,
    required this.nationalID,
    required this.contact,
    required this.email,
    required this.imgUrl,
    required this.sex,
    required this.userType,
    required this.description,
    required this.notificationToken,
    required this.rates,
  });

  User.empty() {
    id = "";
    name = "";
    email = "";
    imgUrl = "";
    nationalID = "";
    sex = "";
    userType = "";
    contact = "";
    address = "";
    description = "";
    notificationToken = "";
    rates = [];
  }

  String get firstName {
    if (userType.toUpperCase() == 'jobSeeker') {
      return name.split(" ")[0];
    }
    return name;
  }

  String get secondName {
    if (userType.toUpperCase() == 'jobSeeker') {
      return name.split(" ")[1];
    }
    return name;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imgUrl': imgUrl,
      'nationalID': nationalID,
      'sex': sex,
      'userType': userType,
      'contact': contact,
      'address': address,
      'description': description,
      'notificationToken': notificationToken,
      'rates': rates,
    };
  }

  factory User.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return User(
      id: snapshot.get('id') ?? "",
      name: snapshot.get('name') ?? "",
      email: snapshot.get('email') ?? "",
      imgUrl: snapshot.get('imgUrl') ?? "",
      sex: snapshot.get('sex') ?? "",
      userType: snapshot.get('userType') ?? "",
      nationalID: snapshot.get('nationalID') ?? "",
      contact: snapshot.get('contact') ?? "",
      address: snapshot.get('address') ?? "",
      description: snapshot.get('description') ?? "",
      notificationToken: snapshot.get('notificationToken') ?? "",
      rates: snapshot.get('rates') ?? [],
    );
  }
}
