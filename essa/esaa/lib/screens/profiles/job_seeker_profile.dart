import 'dart:typed_data';

import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:esaa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/models.dart';
import '../companyProfileForJS.dart';
import '../company_home/widgets/full_job_list.dart';
import '../company_home/widgets/order_card.dart';
import '../review_page.dart';

class JobSeekerProfile extends StatefulWidget {
  JobSeekerProfile({Key? key}) : super(key: key) {
    Get.put(JobSeekerFormController());
  }
  @override
  _JobSeekerProfileState createState() => _JobSeekerProfileState();
}

class _JobSeekerProfileState extends State<JobSeekerProfile>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool en = false;
  Uint8List? _image;
  //String imgUrl = App.user.imgUrl;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();
  final sexController = TextEditingController();
  final bdateController = TextEditingController();
  final bioController = TextEditingController();
  final skillsController = TextEditingController();
  late TabController tabController;
  String stroredImg = '';

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    _setInitialValues(nameController, emailController, idController,
        sexController, bdateController, bioController, skillsController);

    super.initState();
  }

  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  saveNewValues() async {
    App.user.name = nameController.text;
    App.user.email = emailController.text;
    App.user.id = idController.text;
    App.user.sex = sexController.text;
    App.user.bio = bioController.text;
    App.user.Bdate = bdateController.text;
    App.user.skills = skillsController.text;

    String imgUrl = "";
    if (_image != null) {
      imgUrl = await Storage().uploadImageToString("jobseekerLogo ", _image!);
    }
    App.user.imgUrl = imgUrl;
    await UserDatabase(App.user.id).updateDetails(App.user.toMap());
  }

  void selectImage() async {
    final pickedFile = await pickImage(ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List image = await pickImage(ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }
  }

//=========== check here
  /* setStoredImg() {
    if (App.user.imgUrl == '' || App.user.imgUrl == null) {
      stroredImg = 'assets/image icon.png';
      print('image picker');
    } else
      stroredImg = App.user.imgUrl;
  }*/

  @override
  Widget build(BuildContext context) {
    // setStoredImg();
    return CustomAppbar(
        title: const Text("حسابك الشخصي",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis)),
        showLogout: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child:
                  //========== profile img======================================================================
                  Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundImage: MemoryImage(_image!))
                            : GestureDetector(
                                onTap: selectImage,
                                child: SizedBox(
                                  height: 200,
                                  width: 290,
                                  child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(stroredImg)),
                                ),
                              ),
                        /*Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(/*imgUrl*/)),
                            )
                            ),*/
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: kPrimaryColor,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => selectImage(),
                              ),
                            )),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () =>
                            Get.to(() => ReviewPage(userID: App.user.id)),
                        child: const Text(
                          "عرض التقييمات",
                          style: TextStyle(
                              fontSize: 18,
                              color: kPrimaryColor,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //====================form ============================================
                  Column(
                    children: [
                      //====================name ============================================
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: nameController,
                              onSaved: (newValue) =>
                                  nameController.text = newValue!.trim(),
                              validator: (val) => val!.trim().isEmpty
                                  ? 'يجب ان يكون الاسم اكثر من ثلاث أحرف'
                                  : null,
                              onChanged: (val) => setState(() {
                                en = true;
                                nameController.text = val.toString();
                              }),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                //overflow: TextOverflow.ellipsis
                              ),
                              decoration: InputDecoration(
                                labelText: "الاسم",
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 0.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //====================bio ============================================
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: bioController,
                              onSaved: (newValue) =>
                                  bioController.text = newValue!.trim(),
                              onChanged: (val) => setState(() {
                                en = true;
                                bioController.text = val.toString();
                              }),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                //overflow: TextOverflow.ellipsis
                              ),
                              decoration: InputDecoration(
                                labelText: "النبذة التعريفية",
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 0.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //====================skills ============================================
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: skillsController,
                              onSaved: (newValue) =>
                                  skillsController.text = newValue!.trim(),
                              onChanged: (val) => setState(() {
                                en = true;
                                skillsController.text = val.toString();
                              }),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                //overflow: TextOverflow.ellipsis
                              ),
                              decoration: InputDecoration(
                                labelText: "المهارات ",
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 0.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //====================id ============================================
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: idController,
                              onSaved: (newValue) =>
                                  idController.text = newValue!.trim(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return kNationalIdNullError;
                                } else if (value.length != 10) {
                                  return kInvalidNationalIdError;
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) => setState(() {
                                en = true;
                                idController.text = val.toString();
                              }),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                //overflow: TextOverflow.ellipsis
                              ),
                              decoration: InputDecoration(
                                labelText: "الهوية الوطنية",
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 0.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //====================b date ============================================
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: bdateController,
                              keyboardType: TextInputType.datetime,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                labelText: "تاريخ الميلاد",
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 0.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //====================sex ============================================
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: sexController,
                              onSaved: (newValue) =>
                                  sexController.text = newValue!.trim(),
                              onChanged: (val) => setState(() {
                                en = true;
                                sexController.text = val.toString();
                              }),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                //overflow: TextOverflow.ellipsis
                              ),
                              decoration: InputDecoration(
                                labelText: "الجنس",
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 0.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //====================email ============================================
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              enabled: false,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                labelText: "الإيميل",
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 0.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      //====================btn ============================================
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: en
                                  ? () async {
                                      saveNewValues();
                                      //en = false;
                                      Fluttertoast.showToast(
                                          msg: "تم التعديل بنجاح",
                                          backgroundColor: Colors.black54,
                                          toastLength: Toast.LENGTH_LONG,
                                          textColor: kFillColor);
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColor, elevation: 0),
                              child: const Text(
                                "حفظ التغييرات",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //====================priv jobs ============================================
                      SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height - 150,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20),
                              Container(
                                width: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                    color: kPrimaryLightColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: TabBar(
                                        unselectedLabelColor: kPrimaryColor,
                                        labelColor: const Color.fromARGB(
                                            255, 75, 73, 73),
                                        indicatorColor: Colors.white,
                                        indicatorWeight: 2,
                                        indicator: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        controller: tabController,
                                        tabs: const [
                                          Tab(
                                            text: 'العروض السابقة',
                                          ),
                                          Tab(
                                            text: 'العروض النشطة',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                    controller: tabController,
                                    children: const [ptab(), actab()]),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

void _setInitialValues(
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController idController,
    TextEditingController sexController,
    TextEditingController bdateController,
    TextEditingController bioController,
    TextEditingController skillsController) {
  nameController.text = App.user.name;
  emailController.text = App.user.email;
  idController.text = App.user.nationalID;
  sexController.text = App.user.sex;
  bdateController.text = App.user.Bdate;
  bioController.text = App.user.bio;
  skillsController.text = App.user.skills;
}

class JobSeekerFormController extends UserController {}

class ptab extends StatelessWidget {
  const ptab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListView(
            absoluteSize: 3,
            physics: const NeverScrollableScrollPhysics(),
            query: OrderDatabase.ordersCollection
                .where("userID", isEqualTo: App.user.id)
                .where("orderStatus", isEqualTo: "accepted")
                .where('hasBeenPaid', isEqualTo: true)
                .orderBy("timeApplied", descending: true),
            emptyListWidget: Container(
              margin: const EdgeInsets.only(top: 120, bottom: 100),
              child: const Center(
                child: Text(
                  "لم تنهي أي وظيفة بعد ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            itemBuilder: (context, querySnapshot) {
              Order order = Order.fromDocumentSnapshot(querySnapshot);
              return OrderCard(order: order, showPaymentStatus: false);
            }),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextButton(
            onPressed: () => Get.to(() => const FullJobList()),
            child: const Text(
              'لعرض الكل',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.fade),
            ),
          ),
        ),
      ],
    );
  }
}

class actab extends StatelessWidget {
  const actab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListView(
            absoluteSize: 3,
            physics: const NeverScrollableScrollPhysics(),
            query: OrderDatabase.ordersCollection
                .where("userID", isEqualTo: App.user.id)
                .where("orderStatus", isEqualTo: "accepted")
                .orderBy("timeApplied", descending: true),
            emptyListWidget: Container(
              margin: const EdgeInsets.only(top: 120, bottom: 100),
              child: const Center(
                child: Text(
                  "لا يوجد عروض نشطة",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            itemBuilder: (context, querySnapshot) {
              Order order = Order.fromDocumentSnapshot(querySnapshot);
              return OrderCard(order: order, showPaymentStatus: false);
            }),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextButton(
            onPressed: () => Get.to(() => const FullJobList()),
            child: const Text(
              'لعرض الكل',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.fade),
            ),
          ),
        ),
      ],
    );
  }
}
