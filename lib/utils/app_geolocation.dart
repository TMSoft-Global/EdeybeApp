import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AppGeoLocation {
  BuildContext context;
  AppGeoLocation._instantiate();
  double _proximity = 30.00;
  static final AppGeoLocation instance = AppGeoLocation._instantiate();
  StreamSubscription<Position> positionStream;

  Future<LocationPermission> checkLocationStatus() async {
    LocationPermission geolocationStatus = await Geolocator.checkPermission();
    return geolocationStatus;
  }

  Future<Position> getDeviceLocation() async {
    Position position;

    await requestPermission().then((value) async {
      if (value == LocationPermission.always ||
          value == LocationPermission.whileInUse) {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      }
    });

    return position;
  }

  Future<Position> getLastKnownLocation() async {
    Position position = await Geolocator.getLastKnownPosition();
    return position;
  }

  Future<StreamSubscription<Position>> listenToLocationChange(
      Function callback) async {
    var hasPermission = await checkLocationStatus();
    if (hasPermission == LocationPermission.whileInUse ||
        hasPermission == LocationPermission.always) {
      if (await Geolocator.isLocationServiceEnabled()) {
        positionStream = Geolocator.getPositionStream(
                desiredAccuracy: LocationAccuracy.best, distanceFilter: 0)
            .listen((Position position) async {
          // double distance = await calculateDistance(fromStartLat: position.latitude, fromEendLong: position.longitude, toStartLat: 5.6311574, toEendLong: -0.1571649);
          double distance = await calculateDistance(
              fromStartLat: position.latitude,
              fromEendLong: position.longitude,
              toStartLat: 5.6311574,
              toEendLong: -0.1571649);
          if (distance <= _proximity) {
            callback();
            // alert('Automated Checking',position == null ? 'Unknown' : 'You are at the event premises '+position.latitude.toString() + ', ' + position.longitude.toString()+'\nDistance from Location is ${distance}M');
            dispose();
          }
        });
      } else {
        // bool _serviceEnabled = await otherLocation.Location().requestService();
        // if (!_serviceEnabled) {
        //   return null;
        // }
      }
    }

    return positionStream;
  }

  Future<bool> getDeviceLocationMatch(String lat, String long) async {
    bool isAtLocation = false;
    var hasPermission = await checkLocationStatus();
    if (hasPermission == LocationPermission.whileInUse ||
        hasPermission == LocationPermission.always) {
      if (await Geolocator.isLocationServiceEnabled()) {
        await getDeviceLocation().then((Position position) async {
          double distance = await calculateDistance(
              fromStartLat: position.latitude,
              fromEendLong: position.longitude,
              toStartLat: double.parse(lat),
              toEendLong: double.parse(long));
          if (distance <= _proximity) {
            isAtLocation = true;
          }
        });
      }
    }

    return isAtLocation;
  }

  Future<List<Location>> placeMarkFromAddress(String place) async {
    List<Location> placemark = await locationFromAddress(place);
    return placemark;
  }

  Future<List<Placemark>> placeMarkFromCordinates(
      {@required double startLat, @required double endLong}) async {
    List<Placemark> placemark = [];

    placemark = await placemarkFromCoordinates(startLat, endLong);
    return placemark;
  }

  Future<double> calculateDistance(
      {@required double fromStartLat,
      @required double fromEendLong,
      @required double toStartLat,
      @required double toEendLong}) async {
    double distanceInMeters = Geolocator.distanceBetween(
        fromStartLat, fromEendLong, toStartLat, toEendLong);
    return distanceInMeters;
  }

  Future<LocationPermission> requestPermission() async {
    // LocationPermission _location = await Geolocator.requestPermission();
    bool _serviceEnabled;
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission _permissionGranted = await checkLocationStatus();
    if (!_serviceEnabled) {
      _serviceEnabled = await Geolocator.openAppSettings();
    }
    if (_permissionGranted == LocationPermission.denied) {
      _permissionGranted = await Geolocator.requestPermission();
    }
    if (_permissionGranted == LocationPermission.denied) {
      _permissionGranted = await Geolocator.requestPermission();
    }
    return _permissionGranted;
  }

  void dispose() {
    positionStream.cancel();
  }
}
