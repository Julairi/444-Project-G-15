// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
      textDirection: TextDirection.rtl,
      decoration: const InputDecoration(
        hintTextDirection: TextDirection.rtl,
        hintText: 'بحث..',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
