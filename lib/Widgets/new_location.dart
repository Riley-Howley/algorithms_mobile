import 'package:algorithm_mobile/Http/requests.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../Functions/helpers.dart';

class NewLocationWidget extends StatelessWidget {
  @override
  var userid = TextEditingController();
  var description = TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.8,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              "Add new Location",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            child: TextField(
              decoration: InputDecoration(
                hintText: "User ID",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width / 1.5,
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 48,
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () async {
                postAllData(userid.text, description.text);
              },
              child: Text("Send"),
            ),
          ),
        ],
      ),
    );
  }
}
