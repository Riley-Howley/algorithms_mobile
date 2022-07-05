import 'dart:convert';
import 'dart:io';
// import 'dart:math' as math;
import 'dart:math';
import 'package:algorithm_mobile/Functions/helpers.dart';
import 'package:algorithm_mobile/Widgets/all_data.dart';
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

/*
  Method Title: PostAllData.
  What it does:
  This method takes a userid and description of a users location and sends a post request to kens server.
  Using the inbuilt Flutter HttpClient this ensures that there will be no issues with the requests.
  Using a Map the request of the URI is encode to utf8 and added to the request.
  The other request headers are for minimizing errors and are very handy
 */

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

/*
  Method Title: GetAllData.
  What it does:
  This method sends a get request to Kens server and returns every json object of users locations.
  The object is then decoded to a HttpClientResult and checks that the results status code is 200. Accepted
  Then the result is decoded and transformed.
  Once this is done the list that will be storing these objects is checked and if its empty then it adds the
  object else it clears the list and then adds it. this will stop duplicaiton of data in the list.
 */

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
      for (var user in userid) {
        if (i['userid'] == user) {
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
  }
  /*
  Method Title: NA.
  What it does:
  Due to this method being so long I thought it would be fitting to have a comment here.
  What this does is gets rid of all duplicate userid and adds all the users uniqueid locations
  to a list. Therefore all latlngs are accessed via a userid. Once this is done there is a loop
  that goes through the list of all user coords and assigns a random color. using a random variable.
  Then foreach userid and takes latlng and adds them to a point object used to convex hull algorithm.
  First each of the users locations are given a marker with a random color assigned earlier.
  Then this method calls ConvexHull
 */

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
    //If the coords length is less that four Polygon is not created.
    if (coords.length < 4) {
      continue;
    } else {
      convexHull(coords, i);
    }
  }

  print("The Length of Polygon list is ${UserPolygons.length}");
}

/*
  Method Title: getRandomColor.
  What it does:
  This method takes the random unique int from the previous method and sends back the 
  color of the BitMapDescriptor since the markers use a BitMapDescriptor type for the markers
 */

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

/*
  Method Title: getRandomColors.
  What it does:
  This method takes the random unique int from the previous method and sends back the 
  color of the result used for the coloring of the Convex hull (Polygon) and the Polylines (Lines)
  connecting the markers together
 */

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

/*
  Method Title: ConvexHull.
  What it does:
  This method takes a list of Points used for the convex hull algorithm and a colorIndex.
  First for all the points add it to the points list. Then the extract the first element in points
  and assign it the Pivot. Then loops from the first index all points and checks for the lowest x and y
  this is to get the pivot. Then points remove the pivot. The points is then sorted using a radial sort
  and then a new list of points is assigned to hull. This will store the final hull latlng.
  Then the hull algorithm is performed and foreach element in hull it creates a LatLng type and
  creates a new polygon and adds it to a list userPolgons.
 */

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

  UserPolygons.add(new Polygon(
    polygonId: PolygonId('ConvexHull'),
    points: pointCoords,
    fillColor: getRandomColors(random.nextInt(9)),
    strokeColor: getRandomColors(random.nextInt(9)),
  ));

  print("Unavailable Area of Polygone");
}

/*
  Method Title: isValid.
  What it does:
  This method takes the hull list developed in the previous method and checks if it is valid or not.
 */

bool isValid(List<Points> hull) {
  if (hull.length < 3) return true;
  return -sa(
          hull[hull.length - 3], hull[hull.length - 2], hull[hull.length - 1]) >
      0;
  //SignedArea
}

String totalArea = "";

/*
  Method Title: CalcArea.
  What it does:
  This method takes the hull list developed in the ConvexHull algorithm above and returns the total area of the hull.
  At this present point the hull has LatLng coords therefore need to be transformed into double.
  Watch this space
 */

// CalcArea(List<Points> hull) {
//   double area = 0;
//   for (int i = 0; i < hull.length; i++) {
//     Points p1 = hull[i];
//     Points p2 = hull[i];
//     area += convertToRadians(p2.y - p1.y) *
//         (2 +
//             math.sin(convertToRadians(p1.x)) +
//             math.sin(convertToRadians(p2.x)));
//   }
// }

// double convertToRadians(double input) {
//   return input * math.pi / 180;
// }
