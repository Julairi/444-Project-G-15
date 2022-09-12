class CompanyModel {
  String? cid;
  String? email;
  String?Name;

  String? description;
  String? contact;
  String? address;
  String? role;
  // String? phone;
  //String? experience;
  CompanyModel({
    this.cid,
    this.email,
    this.Name,

    this.contact,
    this.description,
    this.address,
    this.role,
  });

  // receiving data from server
  factory CompanyModel.fromMap(map) {
    return CompanyModel(
      cid: map['cid'],
      email: map['email'],
      Name: map['Name'],
      description: map['description'],

      contact: map['contact'],
      address: map['address'],
      role: map['role'],
      //phone: map['phone_number'],
      // experience: map['experience'],
      //DOB: map['DOB'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'cid': cid,
      'email': email,
      'Name': Name,
      'description':description,
     'contact':contact,
      //'gender': gender,
      'adress': address,
      'role':'company',
      //'phone': phone,
      //'experience': experience,
      //DOB': DOB,
    };
  }
}