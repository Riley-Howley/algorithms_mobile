import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AddUser extends StatelessWidget {
  var usernameController = TextEditingController();
  var usernidController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add New User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Text("Username"),
            Container(
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Enter Username",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Text("UserID"),
            Container(
              child: TextField(
                controller: usernidController,
                decoration: InputDecoration(
                  hintText: "Enter UserID",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                prefs.setString('name', usernameController.text);
                prefs.setString('id', usernidController.text);
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
