import 'dart:convert';
import 'dart:io';

import 'package:algorithm_mobile/Functions/helpers.dart';
import 'package:algorithm_mobile/Model/Coord.dart';

HttpClient client = new HttpClient();

//String local = "https://10.0.2.2:7234/api";
var ip = "http://developer.kensnz.com/getlocdata";

List<CoordModel> list = [];

Future getAllData(String id) async {
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
      if (i["userid"] == id) {
        list.add(
          new CoordModel(
            i["userid"],
            i["latitude"],
            i["longitude"],
            i["description"],
          ),
        );
      } else {
        continue;
      }
    }
  }

  print(list);
}

Future postAllData(String id, String descriotion) async {
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  HttpClientRequest request = await client.postUrl(Uri.parse(
      "http://developer.kensnz.com/api/addlocdata?userid=$id&latitude=$latitude&longitide=$log&description=$descriotion"));
  request.headers.add("Content-Type", "application/json");
  request.headers.add("Accept", "*/*");
  HttpClientResponse result = await request.close();
  print(result.statusCode);
}
