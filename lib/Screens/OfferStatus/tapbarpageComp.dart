import 'package:esaa/constants.dart';
import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import 'WaitCompList.dart';
import 'assignedCompList.dart';
//import 'Tab3Comp.dart';

class TabBarPageComp extends StatefulWidget {
  const TabBarPageComp({Key? key}) : super(key: key);

  @override
  _TabBarPageCompState createState() => _TabBarPageCompState();
}

class _TabBarPageCompState extends State<TabBarPageComp>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  // height: 50,
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TabBar(
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.black,
                          indicatorColor: Colors.white,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          controller: tabController,
                          tabs: [
                            Tab(
                              text: 'عروض قيد الانتظار',
                            ),
                            Tab(
                              text: 'العروض تم اسنادها',
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [WaitCompList(), assignedCompList()],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
