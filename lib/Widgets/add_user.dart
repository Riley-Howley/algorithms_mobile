import 'package:flutter/material.dart';

import '../main.dart';

/*
  Flutter Title: AddUser.
  What it does:
  This screen is for when the user adds their name to auto store their credentials. Using
  shared preferences the user add name and user id via two textfields and stores them.
  Once this is done the shared preferences adds them and then pops the screen to the previous state.
 */

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
