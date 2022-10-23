import 'package:esaa/config/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  Widget textfield({@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textfield(
                          hintText: 'الاسم',
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        textfield(
                          hintText: 'رقم الهوية',
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        textfield(
                          hintText: 'الايميل',
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        textfield(
                          hintText: 'الجنس',
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        textfield(
                          hintText: 'تاريخ الميلاد',
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              autofocus: true,
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 7,
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
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
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                  const Color.fromARGB(
                                                          255, 105, 110, 112)
                                                      .withOpacity(0),
                                                  const Color.fromARGB(
                                                          255, 64, 69, 71)
                                                      .withOpacity(0.2)
                                                ],
                                                    stops: const [
                                                  0.6,
                                                  1
                                                ])),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                const Icon(
                                                  Icons.work_outline,
                                                  color: Color.fromARGB(
                                                      255, 83, 80, 80),
                                                  size: 35,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                Text(
                                                  "order.userName",
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 6, 6, 6),
                                                      fontSize: 18,
                                                      fontFamily: 'ElMessiri',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow:
                                                          TextOverflow.fade),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.insights_sharp,
                                                color: Color.fromARGB(
                                                    255, 237, 229, 109),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                                width: 10,
                                              ),
                                              const Icon(
                                                Icons.info,
                                                color: Color.fromARGB(
                                                    255, 3, 77, 138),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                                width: 10,
                                              ),
                                            ],
                                          ),

                                          const SizedBox(
                                            height: 20,
                                            width: 15,
                                          ),

                                          //if(order.orderStatus == "accepted")
                                          //  Text(
                                          //      order.hasBeenPaid ? "Paid" :"Unpaid" ,
                                          //    style: TextStyle(
                                          //      color: order.hasBeenPaid ? Colors.green : Colors.red,
                                          //     fontSize: defaultFontSize,
                                          //      fontWeight: FontWeight.bold,
                                          //      overflow: TextOverflow.ellipsis
                                          //       )
                                          //   ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                          width: 10,
                        ),
                        Container(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor, elevation: 0),
                            child: Text(
                              "تعديل",
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 70, left: 184),
          )
        ],
      ),
    );
  }
}
