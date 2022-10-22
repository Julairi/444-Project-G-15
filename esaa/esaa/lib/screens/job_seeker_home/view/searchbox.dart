import 'package:flutter/material.dart';

class searchbox extends StatefulWidget {
  const searchbox({Key? key}) : super(key: key);

  @override
  _searchboxState createState() => _searchboxState();
}

class _searchboxState extends State<searchbox> {
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
