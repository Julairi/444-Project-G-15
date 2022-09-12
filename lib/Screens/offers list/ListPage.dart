import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import '../../../../../constants.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future data;
  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot Qn = await firestore.collection("posts").get();
    return Qn.docs;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(post: post),
        ));
  }

  @override
  void initState() {
    super.initState();
    data = getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kPrimaryLightColor,
      ),
      child: FutureBuilder(
          future: data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading.."),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].data['Title :']),
                      subtitle: Text(snapshot.data[index].data['Company :']),
                      onTap: () => navigateToDetail(snapshot.data[index]),
                    );
                  });
            }
          }),
    );
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  const DetailPage({required this.post});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
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
      body: Container(
        //decoration: BoxDecoration(),
        child: Card(
          child: ListTile(
            title: Text((widget.post.data as dynamic)["Title :"]),
            subtitle: Text((widget.post.data as dynamic)["content"]),
          ),
        ),
      ),
    );
  }
}
