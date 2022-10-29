import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {

  final Query query;
  final ScrollController? controller;
  final Widget Function (BuildContext, QueryDocumentSnapshot) itemBuilder;
  final Widget emptyListWidget;
  final int? absoluteSize;
  final ScrollPhysics? physics;

  const CustomListView({this.controller, required this.query, required this.itemBuilder,
    required this.emptyListWidget, this.absoluteSize, this.physics, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreListView(
        shrinkWrap: true,
        controller: controller ?? ScrollController(),
        scrollDirection: Axis.vertical,
        query: query,
        pageSize: 10,
        absoluteSize: absoluteSize,
        physics: physics,
        emptyListBuilder: (context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                emptyListWidget,
              ],
            ),
          );
        },
        itemBuilder: itemBuilder
    );
  }
}
