import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  late String name, address, id, nationalID, contact, email, imgUrl, sex, userType, description;


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
  });

  User.empty(){
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
  }

  String get firstName {
    if(userType.toUpperCase() == 'jobSeeker'){
      return name.split(" ")[0];
    }
    return name;
  }

  String get secondName {
    if(userType.toUpperCase() == 'jobSeeker'){
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
    );
  }

}