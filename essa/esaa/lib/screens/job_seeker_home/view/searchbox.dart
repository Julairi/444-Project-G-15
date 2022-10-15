import 'package:flutter/material.dart';

class searchbox extends StatefulWidget {
  @override
  _searchboxState createState() => _searchboxState();
}

class _searchboxState extends State<searchbox> {
  TextEditingController _searchController = TextEditingController();
  String searchText = '';
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintTextDirection: TextDirection.rtl,
        hintText: 'بحث..',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
