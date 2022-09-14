class CompanyModel {
  String? cid;
  String? email;
  String? Name;
<<<<<<< HEAD

  String? description;
  String? contact;
  String? address;
  String? role;
  //bool? company;
  // bool? jobseeker;
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
    // this.company,
    //this.jobseeker
  });
=======
  String? imgUrl;
  String? description;
  String? contact;
  String? address;
  bool? company;
  bool? jobseeker;
  // String? phone;
  //String? experience;
  CompanyModel(
      {this.cid,
      this.email,
      this.imgUrl,
      this.Name,
      this.contact,
      this.description,
      this.address,
      this.company,
      this.jobseeker});
>>>>>>> 2ab1a8cea3bb7cf9ecd7b2c4e1a58514cb4490f4

  // receiving data from server
  factory CompanyModel.fromMap(map) {
    return CompanyModel(
      cid: map['cid'],
      email: map['email'],
      imgUrl: map['imgUrl'], //+
      Name: map['Name'],
      description: map['description'],

      contact: map['contact'],
      address: map['address'],
      role: map['role'],
      // company: map['company'],
      // jobseeker: map['jobsekker'],
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
<<<<<<< HEAD
=======
      'imgUrl': imgUrl, //++
>>>>>>> 2ab1a8cea3bb7cf9ecd7b2c4e1a58514cb4490f4
      'description': description,
      'contact': contact,
      //'gender': gender,
      'adress': address,
<<<<<<< HEAD
      'role': 'company'
      //'company': 'true',
      //'jobseeker': 'false',
=======
      'company': 'true',
      'jobseeker': 'false',
>>>>>>> 2ab1a8cea3bb7cf9ecd7b2c4e1a58514cb4490f4

      //'phone': phone,
      //'experience': experience,
      //DOB': DOB,
    };
  }
}
