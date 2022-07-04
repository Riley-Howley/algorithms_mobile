import 'package:algorithm_mobile/Http/requests.dart';
import 'package:algorithm_mobile/Widgets/all_data.dart';
import 'package:algorithm_mobile/Widgets/new_location.dart';
import 'package:flutter/material.dart';

/*
  Flutter Screen Title: DashBoardScreen.
  What it does:
  This method is the screen that is displayed after the user enters their name.
  However this screen works like a tabview but is different. Due to tabView needing
  to use a tabBarController this is bad due to the controlller not disposing correctly
  which causes issues with states I used a bool switch value that switches between two widges.
  NewLocation and AllData.
  */

class DashboardScreen extends StatefulWidget {
  String name;
  DashboardScreen(this.name);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  var tab = false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/dash.jpeg"),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                Text(
                  "Welcome\n${widget.name}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          list.clear();
                          userid.clear();
                          UserPolygons.clear();
                          listOfUserMarkers.clear();
                          setState(() {
                            tab = !tab;
                          });
                        },
                        child: Text(
                          "Home",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:
                                  tab == false ? Colors.orange : Colors.white),
                        )),
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            tab = !tab;
                          });
                        },
                        child: Text(
                          "View",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:
                                  tab == true ? Colors.orange : Colors.white),
                        ))
                  ],
                ),
                tab == false ? NewLocationWidget() : AllDataWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
