import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {

  final Query query;
  final Widget Function (BuildContext, QueryDocumentSnapshot) itemBuilder;
  final Widget emptyListWidget;

  const CustomListView({required this.query, required this.itemBuilder, required this.emptyListWidget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return FirestoreListView(
        shrinkWrap: true,
        controller: controller,
        scrollDirection: Axis.vertical,
        query: query,
        pageSize: 10,
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
