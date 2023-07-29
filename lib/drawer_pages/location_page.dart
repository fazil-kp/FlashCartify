import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../reusable_widget/constants.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late Position position;
  String placeName = '';
  String pinCode = '';

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<bool> getPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
      return false;
    }

    return true;
  }

  Future<void> getAddressFromPosition(Position position) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemark[0];
      setState(() {
        placeName = place.locality ?? '';
        pinCode = place.postalCode ?? '';
      });
    } catch (e) {
      print("Error while fetching address: $e");
    }
  }

  Future<void> getLocation() async {
    bool result = await getPermission();
    if (result) {
      print("Permission Granted");
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        getAddressFromPosition(position);
      } catch (e) {
        print("Error while fetching location: $e");
      }
    } else {
      print("Permission not granted or location services disabled.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Location",
          style: TextStyle(
            fontFamily: Bold,
            fontSize: 16,
            color: blackColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                getLocation();
              },
              child: Text("Search Location"),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Place = $placeName"),
            SizedBox(
              height: 10,
            ),
            Text("Pin Code = $pinCode"),
          ],
        ),
      ),
    );
  }
}
