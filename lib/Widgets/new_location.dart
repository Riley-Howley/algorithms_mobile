import 'package:algorithm_mobile/Http/requests.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../Functions/helpers.dart';

class NewLocationWidget extends StatelessWidget {
  var userid = TextEditingController();
  var description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future success() => showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Text(
                  "Success! Your location has been sent to the web server",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ));
    Future fail() => showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Container(
                color: Colors.amber,
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Text(
                  "Whoops! Your location was not sent to the web server",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ));
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
              keyboardType: TextInputType.number,
              controller: userid,
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
              controller: description,
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
                await getLocation();
                await postAllData(userid.text, description.text);
                if (code == "201") {
                  success();
                } else {
                  fail();
                }
              },
              child: Text("Send"),
            ),
          ),
        ],
      ),
    );
  }
}
