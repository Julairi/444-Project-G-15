class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  //String? gender;
  //String? DOB;
  String? nationalId;
  String? role;
  // String? phone;
  //String? experience;
  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
    //this.gender,
    //this.DOB,
    //this.experience,
    this.nationalId,
    this.role,
    //this.phone
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      //gender: map['gender'],
      nationalId: map['nationalId'],
      role: map['role'],
      //phone: map['phone_number'],
      // experience: map['experience'],
      //DOB: map['DOB'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      //'gender': gender,
      'nationalId': nationalId,
      'role':'jobseeker',
      //'phone': phone,
      //'experience': experience,
      //DOB': DOB,
    };
  }
}
