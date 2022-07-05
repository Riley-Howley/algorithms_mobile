import 'package:algorithm_mobile/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../main.dart';

/*
  Flutter Title: EditUser.
  What it does:
  This screen is for when the user edits their name to auto store their credentials. Using
  shared preferences the user edit name and user id via two textfields and stores them.
  Once this is done the shared preferences changes them and then pushes the replacement screen
  Dashboard with the updated credentials.
 */

class EditUser extends StatelessWidget {
  String name;
  String id;
  EditUser(
    this.name,
    this.id,
  );

  var nameController = TextEditingController();
  var idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    nameController.text = name;
    idController.text = id;
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
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Enter Username",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Text("UserID"),
            Container(
              child: TextField(
                controller: idController,
                decoration: InputDecoration(
                  hintText: "Enter UserID",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                prefs.setString('name', nameController.text);
                prefs.setString('id', idController.text);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      DashboardScreen(nameController.text, idController.text),
                ));
              },
              child: Text("Edit"),
            ),
          ],
        ),
      ),
    );
  }
}
