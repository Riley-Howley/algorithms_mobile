import 'dart:async';
import 'dart:io';
import 'package:algorithm_mobile/Widgets/add_user.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard_screen.dart';
/*
  Flutter Title: main.
  What it does:
  This is one of the best parts of the app. This is the connectivity screen. If the user is not connected to
  a network then their is an error message displayed. The default way is using standard connectivity plus however
  this is an incorrect way of doing it because it does not check the network actual connection. Therefore I used
  this way to check the network connection of mobile and wifi
  */

late SharedPreferences prefs;
final MyConnectivity connectivity = MyConnectivity.instance;

String string = "";

List<String> mainUserID = [
  "202251",
  "202252",
  "202253",
  "2019000480",
  "42069420",
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  var name = prefs.getString('name');
  var id = prefs.getString('id');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: name == null ? HomePage() : DashboardScreen(name, id!),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map _source = {ConnectivityResult.none: false};

  @override
  void initState() {
    super.initState();
    connectivity.initialise();
    connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  var nameController = TextEditingController();
  @override
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
                  image: AssetImage("assets/home.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            "Location\nBased...",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: TextField(
                          controller: nameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Enter your name",
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Explore Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var name = prefs.getString('name');
                            var id = prefs.getString('id');
                            if (name != null || id != null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DashboardScreen(
                                    name.toString(), id.toString()),
                              ));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    DashboardScreen(nameController.text, ""),
                              ));
                            }
                          },
                          child: Icon(
                            Icons.explore,
                            color: Colors.blue,
                            size: 50,
                          ),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddUser(),
                            ));
                          },
                          child: Text("Add New User"),
                        ),
                      ),
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

/*
  Flutter Class Title: MyConnectivity.
  What it does:
  This is using a stream that listens for changes of the network. Initially the app is loaded and the check is run.
  it sends a request to example.com and the result of that is the network connection state. The rest is checking
  if the uses has disconnected or lost connection the error message will appear.
  */

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
