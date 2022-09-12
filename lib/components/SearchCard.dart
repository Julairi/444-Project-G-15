import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
      margin: EdgeInsets.all(25),
      height: 300,
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              image: AssetImage('asset/download(1).jpg'), fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search About Your Job',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("You Can here Found the job that fits you",
              style: TextStyle(
                height: 1.8,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                Image.asset('assets/OIP.jpg', width: 20),
                SizedBox(width: 10),
                Text('Search',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
