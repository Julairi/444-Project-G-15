import 'package:flutter/material.dart';

import '../constants.dart';

class orders2 extends StatelessWidget {
  final String CompanyName;
  final String offertitle;

  final String skil;
  final String summary;
  const orders2(
      {super.key,
      required this.CompanyName,
      required this.offertitle,
      required this.skil,
      required this.summary});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
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
                            offertitle,
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
                        SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(skil,
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
                    Text(skil,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: defaultFontSize,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.fade)),
                    Row(
                      children: [
                        Icon(
                          Icons.business,
                          color: Color.fromARGB(255, 3, 77, 138),
                        ),
                        SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Text(CompanyName,
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
