import 'package:geolocator/geolocator.dart';

String latitude = "";
String log = "";
getLocation() async {
  var message = "";
  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  latitude = position.latitude.toString();
  log = position.longitude.toString();
}
