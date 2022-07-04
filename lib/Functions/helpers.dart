import 'package:geolocator/geolocator.dart';

/*
  Method Title: GetLocation.
  What it does:
  This method is called when the user sends their location to the sever. For the user
  to able to get their location they have to use this method. It uses a PubSpec Package of GeoLocator
  aswell as permissions in the android manifest then returns the LAT and LONG of the users current position
  and assigns them to global variables latitude and log
 */

String latitude = "";
String log = "";
getLocation() async {
  var message = "";
  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  latitude = position.latitude.toString();
  log = position.longitude.toString();
}
