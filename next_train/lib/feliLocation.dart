import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'dart:math' as maths;

class FeliLocation {
  Future<List<double>> location() async {
    List<double> defaultValue = [360, 360];
    if (kIsWeb) {
      try {
        var geolocation = await html.window.navigator.geolocation
            .getCurrentPosition(
                maximumAge: new Duration(seconds: 600),
                timeout: new Duration(seconds: 5),
                enableHighAccuracy: false);

        var coords = geolocation.coords;

        return [coords.latitude.toDouble(), coords.longitude.toDouble()];
      } catch (e) {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  }

  static double distanceBetweenTwoPoints(List<double> a, List<double> b) {
    num deg2rad(num deg) {
      return deg * (maths.pi / 180);
    }

    var lat1 = a[0];
    var lat2 = b[0];
    var lon1 = a[1];
    var lon2 = b[1];
    num r = 6371;
    num dLat = deg2rad(lat2 - lat1);
    num dLon = deg2rad(lon2 - lon1);

    num aa = maths.sin(dLat / 2) * maths.sin(dLat / 2) +
        maths.cos(deg2rad(lat1)) *
            maths.cos(deg2rad(lat2)) *
            maths.sin(dLon / 2) *
            maths.sin(dLon / 2);
    num c = 2 * maths.atan2(maths.sqrt(aa), maths.sqrt(1 - aa));

    num d = r * c; // Distance in km

    return d.toDouble();
  }
}
