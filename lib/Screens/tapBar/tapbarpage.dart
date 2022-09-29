import 'package:esaa/Screens/tapBar/Tab1.dart';
import 'package:esaa/Screens/tapBar/Tab2.dart';
import 'package:esaa/Screens/tapBar/Tab3.dart';

import 'package:esaa/constants.dart';
import 'package:flutter/material.dart';

import '../../components/appbar.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return appbar(
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
                          unselectedLabelColor: kPrimaryColor,
                          labelColor: Color.fromARGB(255, 75, 73, 73),
                          indicatorColor: Colors.white,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          controller: tabController,
                          tabs: [
                            Tab(
                              text: 'Tab 1',
                            ),
                            Tab(
                              text: 'Tab 2',
                            ),
                            Tab(
                              text: 'Tab 3',
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
                      children: [Tab1(), Tab2(), Tab3()]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
