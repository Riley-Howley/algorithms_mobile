import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Http/requests.dart';
import '../main.dart';

/*
  Flutter Widget Title: AllData.
  What it does:
  This method checks that if there are no userids selected then the map is not displayed.
  The user is prompted with a list of already defined userids to view, or they can add there own.
  Then once they have decided what they wanna see they can click View Map and this will display the points
  and the convex hull on a google map.
  */

Set<Polygon> polygons = Set<Polygon>();
List<String> userid = [];

class AllDataWidget extends StatefulWidget {
  @override
  State<AllDataWidget> createState() => _AllDataWidgetState();
}

class _AllDataWidgetState extends State<AllDataWidget> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-46.4179, 168.3615),
    zoom: 14.4746,
  );

  Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polygoneLatLngs = <LatLng>[];

  @override
  Widget build(BuildContext context) {
    void _showMessage(BuildContext context, String id) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text("${id} added to Map"),
          action: SnackBarAction(
              label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
        ),
      );
    }

    var idController = TextEditingController();
    return userid.isEmpty
        ? Container(
            color: Colors.white,
            child: Column(
              children: [
                Column(
                  children: [
                    for (var i in mainUserID)
                      GestureDetector(
                        onTap: () {
                          userid.add(i);
                          _showMessage(context, i);
                        },
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.add),
                                  Container(
                                    width: 180,
                                    child: Text(
                                      "${i}",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                        ]),
                      ),
                  ],
                ),
                Container(
                  width: 240,
                  child: TextField(
                    controller: idController,
                    decoration: InputDecoration(
                      hintText: "Add Your Own...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    userid.add(idController.text);
                  },
                  child: Text("Add Own ID"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () async {
                    await getAllData();
                    setState(() {});
                  },
                  child: Text("View Maps"),
                ),
              ],
            ),
          )
        : Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                child: GoogleMap(
                  mapType: MapType.satellite,
                  markers: listOfUserMarkers,
                  polygons: UserPolygons,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              Text(
                "Area of Polygon is: ${totalArea}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          );
  }
}
