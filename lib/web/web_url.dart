import 'package:google_maps_flutter/google_maps_flutter.dart';

class WebUrl {
  static String urlBase(LatLng position) =>
      'https://nominatim.openstreetmap.org/reverse?lat=${position.latitude}&lon=${position.longitude}&format=json';
  static String urlImg(LatLng position) =>
      'https://maps.googleapis.com/maps/api/staticmap'
      '?size=200x200'
      '&zoom=14'
      '&center=${position.latitude},${position.longitude}'
      '&key=AIzaSyAgT9pV0ONamMF8ByF008OT7lf4-1oAFd0';
}
