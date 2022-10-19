import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/available_posts_controller.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class AvailablePostsScreen extends StatelessWidget {
  AvailablePostsScreen({Key? key}) : super(key: key) {
    Get.put(AvailablePostsController());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    final controller = Get.find<AvailablePostsController>();

    return CustomAppbar(
      child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    controller.searchField = value;
                  },
                  textDirection: TextDirection.rtl,
                  decoration: const InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'بحث..',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 44,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: kFillColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      )),
                  margin: const EdgeInsets.only(top: 8, right: 20),
                  child: PopupMenuButton<String>(
                    tooltip: "Select Filter",
                    constraints: BoxConstraints(
                      minHeight: 24,
                      maxHeight: MediaQuery.of(context).size.height / 1.35,
                      minWidth: 180,
                      maxWidth: 180,
                    ),
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) =>
                        controller.filters.map<PopupMenuItem<String>>((String filter) {
                          return PopupMenuItem<String>(
                            value: filter,
                            child: SizedBox(
                              height: 18,
                              child: Text(
                                'Filter by $filter',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          );
                        }).toList(),
                    onSelected: (String filter) {
                      controller.filterBy = filter;
                    },
                    child: SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),

                              SizedBox(
                                height: 18,
                                child: GetX<AvailablePostsController>(
                                    builder: (controller) {
                                      return Text(
                                        'Filter by ${controller.filterBy}',
                                        style: const TextStyle(color: Colors.black, fontSize: 16),
                                        textAlign: TextAlign.start,
                                      );
                                    }
                                ),
                              ),

                              const Expanded(child: SizedBox()),

                              const Icon(
                                Icons.filter_alt,
                                color: Colors.black,
                              ),

                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(child: GetX<AvailablePostsController>(
                builder: (controller) {
                  if (controller.filterBy == "date") {
                    return PostCount(query: _getQuery(controller.filterBy));
                  } else {
                    return PostCount(query: _getQuery(controller.filterBy));
                  }
                },
              )),
              const SizedBox(height: 10),
              GetX<AvailablePostsController>(
                builder: (controller) {
                  if (controller.filterBy == "date") {
                    return AvailablePostList(
                        query: _getQuery(controller.filterBy));
                  } else {
                    return AvailablePostList(
                        query: _getQuery(controller.filterBy));
                  }
                },
              )
            ],
          )),
    );
  }

  Query _getQuery(String filterBy) {
    Query query = PostDatabase.postsCollection
        .where("offerStatus", whereIn: ["pending", "assigned"]);

    if (filterBy == "date") {
      query = query.orderBy("timePosted", descending: true);
    } else {
      query = query.orderBy("payPerHour", descending: true);
    }

    return query;
  }
}

class AvailablePostList extends StatelessWidget {
  final Query query;
  const AvailablePostList({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return FirestoreQueryBuilder(
      query: query,
      pageSize: 10,
      builder: (context, snapshot, _) {
        return GetX<AvailablePostsController>(builder: (controller) {
          return _builder(
              context, snapshot, _, controller.searchField, scrollController);
        });
      },
    );
  }

  Widget _builder(context, snapshot, _, searchField, scrollController) {
    if (snapshot.isFetching) {
      return const Center(
        child: SizedBox(
            height: 50,
            width: 50,
            child: SpinKitRing(
              color: kPrimaryColor,
              size: 50.0,
            )),
      );
    }

    if (snapshot.hasError) return _errorBuilder();

    if (snapshot.docs.isEmpty) return _emptyListBuilder();

    if (!_filterItems(context, snapshot, searchField)) {
      return _emptyListBuilder();
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: scrollController,
      shrinkWrap: true,
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index) =>
          _itemBuilder(context, index, snapshot, searchField),
    );
  }

  Widget _itemBuilder(BuildContext context, int index,
      FirestoreQueryBuilderSnapshot<Object?> snapshot, String searchField) {
    final isLastItem = index + 1 == snapshot.docs.length;
    if (isLastItem && snapshot.hasMore) snapshot.fetchMore();

    final doc = snapshot.docs[index];
    Post post = Post.fromDocumentSnapshot(doc);

    if (searchField.trim().isEmpty ||
        post.title.contains(searchField.trim()) ||
        post.description.contains(searchField.trim())) {
      return PostCardJobSeeker(post: post);
    } else {
      return const SizedBox();
    }
  }

  Widget _errorBuilder() {
    return const SizedBox(
      child: Text(
        'ليس هناك أي منشورات في الوقت الحالي',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget _emptyListBuilder() {
    return const SizedBox(
      height: 200,
      //check the error message
      child: Text(
        ' لايوجد منشورات تطابق بحثك',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  bool _filterItems(BuildContext context,
      FirestoreQueryBuilderSnapshot<Object?> snapshot, String searchField) {
    int matches = 0;

    for (QueryDocumentSnapshot querySnapshot in snapshot.docs) {
      Post post = Post.fromDocumentSnapshot(querySnapshot);

      if (searchField.trim().isEmpty ||
          post.title.contains(searchField.trim()) ||
          post.description.contains(searchField.trim())) {
        matches++;
      }
    }

    return matches != 0;
  }
}

class PostCount extends StatelessWidget {
  final Query query;
  const PostCount({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder(
      query: query,
      builder: (context, snapshot, _) {
        return GetX<AvailablePostsController>(builder: (controller) {
          return _builder(context, snapshot, _, controller.searchField);
        });
      },
    );
  }

  Widget _builder(context, snapshot, _, searchField) {
    if (snapshot.isFetching) {
      return const Center(
        child: SizedBox(
            height: 24,
            width: 24,
            child: SpinKitRing(
              color: Colors.black,
              size: 24.0,
            )),
      );
    }

    final matches = _filterItems(context, snapshot, searchField);

    return Text(
      '$matches المنشورات المتاحة${matches > 1 ? "" : ""}',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  int _filterItems(BuildContext context,
      FirestoreQueryBuilderSnapshot<Object?> snapshot, String searchField) {
    int matches = 0;

    for (QueryDocumentSnapshot querySnapshot in snapshot.docs) {
      Post post = Post.fromDocumentSnapshot(querySnapshot);

      if (searchField.trim().isEmpty ||
          post.title.contains(searchField.trim()) ||
          post.description.contains(searchField.trim())) {
        matches++;
      }
    }
    return matches;
  }
}
