import 'package:esaa/Screens/OfferStatus/DetailsPageForC.dart';
import 'package:esaa/Screens/OfferStatus/InterstedJs.dart';
//import 'package:esaa/Screens/offers%20list/offerDetailsforC.dart';
import 'package:esaa/constants.dart';
import 'package:flutter/material.dart';

class InterstedCardComp extends StatelessWidget {
  final String UID;
  final String userPath;
  final String skills;
  final String summary;

  const InterstedCardComp({
    super.key,
    required this.UID,
    required this.userPath,
    required this.skills,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

        //    onTap: () {
        //  Navigator.push(
        //   context,
        //    MaterialPageRoute(
        ///      builder: (
        //         context,
        //  ) =>
        //DetailsPageForC(
        //  uid: UID,
        //    CompanyPath: CompanyPath,
        //      CompanyName: CompanyName,
        //offertitle: offertitle,
        ///  offerCity: offerCity,
        //    offerDate: offerDate,
        //      offerDes: offerDes,
        //        offerFee: offerFee,
        //          offerTime: offerTime,
        //            offerHours: offerHours),
        //    ));
        //   },
        child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 7,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  "https://i.pinimg.com/474x/6a/d3/66/6ad3663d79ccc962377d7a6cbe4d9bfe.jpg",
                  height: 50,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                child: Container(
                  height: 50,
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color.fromARGB(255, 105, 110, 112).withOpacity(0),
                        Color.fromARGB(255, 64, 69, 71).withOpacity(0.2)
                      ],
                          stops: [
                        0.6,
                        1
                      ])),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Icon(
                        Icons.work_outline,
                        color: Color.fromARGB(255, 83, 80, 80),
                        size: 35,
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        "عنوان الطلب ", //name of the applicant
                        style: TextStyle(
                            color: Color.fromARGB(255, 6, 6, 6),
                            fontSize: 18,
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.fade),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.insights_sharp,
                      color: Color.fromARGB(255, 237, 229, 109),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                    ),
                    Icon(
                      Icons.info,
                      color: Color.fromARGB(255, 3, 77, 138),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                    ),
                    GestureDetector(
                        child: Text(
                            "تفاصيل الطلب", //click to view order detailes: applicant name,email,sex,his/her skills & summary $ 2 buttons Accept or reject
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                overflow: TextOverflow.ellipsis)),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new IntrestedJs(
                                        postid: UID,
                                      )));
                        })
                  ],
                ),
                SizedBox(
                  height: 20,
                  width: 15,
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
