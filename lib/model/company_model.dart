class CompanyModel {
  String? cid;
  String? email;
  String? Name;
  String? imgUrl; //++++++++++++++++++++++++++++++++++
  String? description;
  String? contact;
  String? address;
  String? role;
  //bool? company;
  //bool? jobseeker;
  // String? phone;
  //String? experience;
  CompanyModel({
    this.cid,
    this.email,
    this.Name,
    this.imgUrl, //+++
    this.contact,
    this.description,
    this.address,
    this.role,
    // this.company,
    // this.jobseeker
  });

  // receiving data from server
  factory CompanyModel.fromMap(map) {
    return CompanyModel(
      cid: map['cid'],
      email: map['email'],
      imgUrl: map['imgUrl'], //++
      Name: map['Name'],
      description: map['description'],

      contact: map['contact'],
      address: map['address'],
      role: map['role'],
      //company: map['company'],
      //jobseeker: map['jobsekker'],
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
      'imgUrl': imgUrl,
      'description': description,
      'contact': contact,
      //'gender': gender,
      'adress': address,
      'role': 'company',
      //'company': 'true',
      //'jobseeker': 'false',

      //'phone': phone,
      //'experience': experience,
      //DOB': DOB,
    };
  }
}
