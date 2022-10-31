import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/order.dart';
import '../company_home/widgets/full_job_list.dart';
import '../company_home/widgets/order_card.dart';

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
  //String imgUrl = App.user.imgUrl;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    _setInitialValues(
      nameController,
      emailController,
      idController,
    );

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
    //App.user.rates.sex;

    await UserDatabase(App.user.id).updateDetails(App.user.toMap());
  }

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: 10),
                  //====================form ============================================
                  Column(
                    children: [
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
                                labelText: "اسم الشركة",
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
                                labelText: "ايميل الشركة",
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
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: en
                                  ? () async {
                                      saveNewValues();
                                      //en = false;
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
                                    children: const [
                                      ptab(),
                                    ]),
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

void _setInitialValues(TextEditingController nameController,
    TextEditingController emailController, TextEditingController idController) {
  nameController.text = App.user.name;
  emailController.text = App.user.email;
  idController.text = App.user.id;
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
