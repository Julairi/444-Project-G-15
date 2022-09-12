import 'package:esaa/Screens/offers%20list/Square.dart';
import 'package:esaa/Screens/offers%20list/appbar.dart';
import 'package:esaa/constants.dart';
import 'package:flutter/material.dart';
import 'package:esaa/models/job.dart';

class Offers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List _posts = ['first Offer', 'second Offer'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text('اسع'),
        leading: IconButton(
          onPressed: () {
            //do something
          },
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          )
        ],
      ),
      body: Column(
        children: [
//offers
          Expanded(
            child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return Mysq(
                    child: _posts[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
