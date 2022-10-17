import 'package:esaa/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/company_home/company_home.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];
/*
    if (_searchController.text != "") {
      for (var tripSnapshot in _allResults) {
        var title = Trip.fromSnapshot(tripSnapshot).title.toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(tripSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
     // _resultsList = showResults;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
        showLeading: true,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
              ),
            ),
            StreamBuilder<List<Post>>(
                stream: PostDatabase().getAvailablePosts(),
                builder: (context, snapshot) {
                  int postCount = 0;

                  if (snapshot.hasData) {
                    postCount = snapshot.data?.length ?? 0;
                  }

                  return SizedBox(
                    child: Text(
                      '$postCount المنشورات المتاحة${postCount > 1 ? "" : ""}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  );
                }),
            CustomListView(
                query: PostDatabase.postsCollection.where("offerStatus",
                    whereIn: [
                      "pending",
                      "assigned"
                    ]).orderBy("timePosted", descending: true),
                emptyListWidget: const SizedBox(
                  child: Text(
                    'ليس هناك أي منشورات في الوقت الحالي',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                itemBuilder: (context, querySnapshot) {
                  Post post = Post.fromDocumentSnapshot(querySnapshot);
                  return PostCardJobSeeker(post: post);
                }),
          ],
        )));
  }
}
