import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/Screens/CompanyPage/userCompanyOffers.dart';
import 'package:esaa/components/background.dart';
import 'package:esaa/constants.dart';
import 'package:flutter/material.dart';

class detailsPage extends StatelessWidget {
  final String CompanyName;
  final String CompanyPath;
  final String offertitle;
  final String offerCity;
  final String offerDate;
  final String offerDes;
  final String offerFee;
  final String offerTime;
  final String offerHours;
  const detailsPage(
      {required this.CompanyPath,
      required this.CompanyName,
      required this.offertitle,
      required this.offerCity,
      required this.offerDate,
      required this.offerDes,
      required this.offerFee,
      required this.offerTime,
      required this.offerHours});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 220,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.work_outline_outlined,
                            color: Color.fromARGB(255, 22, 126, 210),
                            size: 40,
                          ),
                          SizedBox(
                            height: 20,
                            width: 12,
                          ),
                          Text(
                            offertitle,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.fade),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            '  : وصف العمل \n ' + offerDes,
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.business_outlined,
                                color: Color.fromARGB(255, 5, 53, 93),
                              ),
                              SizedBox(
                                height: 20,
                                width: 10,
                              ),
                              Text(
                                CompanyName,
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.fade),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                            width: 15,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined,
                                  color: Color.fromARGB(255, 237, 229, 109),
                                  size: 35),
                              SizedBox(
                                height: 20,
                                width: 10,
                              ),
                              Text(offerCity,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: defaultFontSize,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                        width: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_month_outlined,
                                  color: Color.fromARGB(255, 3, 77, 138),
                                  size: 35),
                              SizedBox(
                                height: 20,
                                width: 10,
                              ),
                              Text(offerDate,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: defaultFontSize,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.fade))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                            width: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: Color.fromARGB(255, 3, 77, 138),
                                size: 35,
                              ),
                              SizedBox(
                                height: 20,
                                width: 10,
                              ),
                              Text(offerTime,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: defaultFontSize,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.payments,
                                color: Color.fromARGB(255, 7, 154, 68),
                                size: 35,
                              ),
                              SizedBox(
                                height: 20,
                                width: 10,
                              ),
                              Text(
                                offerFee + ' لكل ساعة عمل',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                            width: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.hourglass_bottom_outlined,
                                color: Color.fromARGB(255, 143, 13, 13),
                                size: 35,
                              ),
                              SizedBox(
                                height: 20,
                                width: 10,
                              ),
                              Text(
                                offerHours + '  ساعات  ',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
