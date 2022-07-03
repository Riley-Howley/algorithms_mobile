import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:algorithm_mobile/Functions/helpers.dart';
import 'package:algorithm_mobile/Model/Coord.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Model/point.dart';
import '../Model/sorted.dart';
import '../Model/usercoord.dart';

HttpClient client = new HttpClient();

//String local = "https://10.0.2.2:7234/api";

String code = "";
Set<Marker> listOfUserMarkers = <Marker>{};
Random random = new Random();
List<UserCoord> list = [];
List<SortedUser> sortedListByUserid = [];
Set<Polygon> UserPolygons = Set<Polygon>();
var ip = "http://developer.kensnz.com/getlocdata";

List<UserCoord> listCoord = [];

Future postAllData(String userid, String description) async {
  Map map = {
    "userid": "$userid",
    "latitude": "$latitude",
    "longitude": "$log",
    "description": "$description",
  };
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  HttpClientRequest request = await client
      .postUrl(Uri.parse("http://developer.kensnz.com/api/addlocdata"));
  request.headers.add("Content-Type", "application/json");
  request.headers.add("Accept", "*/*");
  request.add(utf8.encode(jsonEncode(map)));
  HttpClientResponse result = await request.close();
  print(result.statusCode);
  code = result.statusCode.toString();
  print(code);
}

Future getAllData() async {
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  HttpClientRequest request = await client.getUrl(Uri.parse("$ip"));
  request.headers.add("Content-Type", "application/json");
  request.headers.add("Accept", "*/*");
  HttpClientResponse result = await request.close();

  if (result.statusCode == 200) {
    List<dynamic> jsonData =
        jsonDecode(await result.transform(utf8.decoder).join());

    if (list.isNotEmpty) {
      list.clear();
    }
    for (var i in jsonData) {
      if (i['userid'] == "2016012187" ||
          i['userid'] == "30" ||
          i['userid'] == "2019000480" ||
          i['userid'] == "42") {
        list.add(
          new UserCoord(
            i["userid"],
            i["latitude"],
            i["longitude"],
            i["description"],
            i["created_at"],
          ),
        );
      } else {
        continue;
      }
    }
  }

  List<List<UserCoord>> listUserCoords = [];

  for (var i in list) {
    var inList = false;

    for (var l in listUserCoords) {
      if (l[0].userid == i.userid) {
        l.add(i);
        inList = true;
        break;
      }
    }

    if (!inList) {
      List<UserCoord> newList = [];
      newList.add(i);
      listUserCoords.add(newList);
    }
  }

  for (int i = 0; i < listUserCoords.length; i++) {
    var color = getRandomColor(random.nextInt(10));
    List<Points> coords = [];
    for (var e in listUserCoords[i]) {
      coords
          .add(new Points(double.parse(e.latitude), double.parse(e.longitude)));
      listOfUserMarkers.add(
        new Marker(
          markerId: MarkerId('${e.userid}'),
          infoWindow: InfoWindow(
              title: "${e.userid} ${e.created_at}",
              snippet: "${e.description}"),
          icon: BitmapDescriptor.defaultMarkerWithHue(color),
          position: LatLng(double.parse(e.latitude), double.parse(e.longitude)),
        ),
      );
    }
    if (coords.length < 4) {
      continue;
    } else {
      convexHull(coords, i);
    }
  }

  print("The Length of Polygon list is ${UserPolygons.length}");
}

getRandomColor(int num) {
  switch (num) {
    case 0:
      return BitmapDescriptor.hueAzure;
    case 1:
      return BitmapDescriptor.hueBlue;
    case 2:
      return BitmapDescriptor.hueCyan;
    case 3:
      return BitmapDescriptor.hueGreen;
    case 4:
      return BitmapDescriptor.hueMagenta;
    case 5:
      return BitmapDescriptor.hueOrange;
    case 6:
      return BitmapDescriptor.hueRed;
    case 7:
      return BitmapDescriptor.hueRose;
    case 8:
      return BitmapDescriptor.hueViolet;
    case 9:
      return BitmapDescriptor.hueYellow;
    default:
      break;
  }
}

getRandomColors(int num) {
  switch (num) {
    case 0:
      return Colors.blue.withOpacity(0.2);
    case 1:
      return Colors.green.withOpacity(0.2);
    case 2:
      return Colors.orange.withOpacity(0.2);
    case 3:
      return Colors.red.withOpacity(0.2);
    case 4:
      return Colors.yellow.withOpacity(0.2);
    case 5:
      return Colors.indigo.withOpacity(0.2);
    case 6:
      return Colors.teal.withOpacity(0.2);
    case 7:
      return Colors.pink.withOpacity(0.2);
    case 8:
      return Colors.purple.withOpacity(0.2);
    case 9:
      return Colors.lime.withOpacity(0.2);
    default:
      return Colors.blueGrey.withOpacity(0.2);
  }
}

convexHull(List<Points> coords, int colorIndex) {
  print(coords.length);
  List<Points> points = [];

  for (var i in coords) points.add(i);

  Points Pivot = points[0];

  for (int i = 1; i < points.length; i++) {
    if (points[i].x < Pivot.x ||
        (points[i].x == Pivot.x && points[i].y < Pivot.y)) {
      Pivot = points[i];
    }
  }
  points.remove(Pivot);

  //this needs to be the radial sort
  points.sort((a, b) => sa(Pivot, a, b));

  List<Points> hull = [];
  hull.add(Pivot);
  hull.add(points[0]);
  points.removeAt(0);

  while (points.length > 0) {
    hull.add(points[0]);
    points.removeAt(0);
    while (!isValid(hull)) {
      hull.removeAt(hull.length - 2);
    }
  }

  List<LatLng> pointCoords = [];

  for (var i in hull) {
    pointCoords.add(new LatLng(i.x, i.y));
  }

  UserPolygons.add(
    new Polygon(
      polygonId: PolygonId('ConvexHull'),
      points: pointCoords,
      fillColor: getRandomColors(colorIndex),
      strokeColor: getRandomColors(colorIndex),
    ),
  );

  print("${CalcArea(hull)} Area of Polygone");
}

bool isValid(List<Points> hull) {
  if (hull.length < 3) return true;
  return -sa(
          hull[hull.length - 3], hull[hull.length - 2], hull[hull.length - 1]) >
      0;
  //SignedArea
}

double CalcArea(List<Points> hull) {
  double area = 0;
  for (int i = 0; i < hull.length; i++) {
    int j = (i + 1) % hull.length;
    area += hull[i].x * hull[j].y - hull[i].y * hull[j].x;
  }
  return area / 2;
}
