import 'dart:async';
import 'dart:io';

import 'package:algorithm_mobile/Http/requests.dart';
import 'package:algorithm_mobile/Widgets/all_data.dart';
import 'package:algorithm_mobile/Widgets/new_location.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'main.dart';

/*
  Flutter Screen Title: DashBoardScreen.
  What it does:
  This method is the screen that is displayed after the user enters their name.
  However this screen works like a tabview but is different. Due to tabView needing
  to use a tabBarController this is bad due to the controlller not disposing correctly
  which causes issues with states I used a bool switch value that switches between two widges.
  NewLocation and AllData.
  Recently added was the connectivity tracker. This was added due to originally only checking
  on the home screen, now the app checks on the dashboard. To read more about the connection
  checker visit the main.dart file and read the comments for connectivity.
  */

class DashboardScreen extends StatefulWidget {
  String name;
  String id;
  DashboardScreen(this.name, this.id);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map _source = {ConnectivityResult.none: false};

  @override
  void initState() {
    super.initState();
    connectivity.initialise();
    connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  var tab = false;

  Widget build(BuildContext context) {
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        string = 'Mobile: Online';
        break;
      case ConnectivityResult.wifi:
        string = 'WiFi: Online';
        break;
      case ConnectivityResult.none:
      default:
        string = 'Offline';
    }
    return Scaffold(
      backgroundColor: string == "Offline" ? Colors.orange : Colors.transparent,
      body: string == "Offline"
          ? Center(
              child: Text(
                "Error! Application needs a valid network connection",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          : Container(
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
                                    color: tab == false
                                        ? Colors.orange
                                        : Colors.white),
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
                                    color: tab == true
                                        ? Colors.orange
                                        : Colors.white),
                              ))
                        ],
                      ),
                      tab == false
                          ? NewLocationWidget(widget.name, widget.id)
                          : AllDataWidget(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    connectivity.disposeStream();
    super.dispose();
  }
}

class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  /*
  Flutter Method Title: _checkStatus.
  What it does:
  This does what I explained in the above comment however doesnt it just look so nice.
  */

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
