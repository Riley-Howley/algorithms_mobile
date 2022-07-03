import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Http/requests.dart';

Set<Polygon> polygons = Set<Polygon>();

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
    var idController = TextEditingController();
    return Container(
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
        // onTap: (point) {
        //   setState(() {
        //     polygoneLatLngs.add(point);
        //     _setPolygon();
        //   });
        // },
      ),
    );
  }
}
