import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kinbech/seller/product%20input/productinfo.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({required this.latitude, required this.longitude});
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController mapController;
  LocationModel? currentLocation;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Location Service Disabled'),
          content: Text('Please enable location services.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Location Permission Denied'),
            content: Text('Please grant location permission.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentLocation = LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      mapController.move(
        LatLng(currentLocation!.latitude, currentLocation!.longitude),
        15.0,
      );
    });
  }

  void saveLocationAndNavigateToProductPage() {
    if (currentLocation == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('No Location Selected'),
          content: Text('Please select a location before proceeding.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    Navigator.pop(context, currentLocation); // Return selected location
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Map Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(
                  currentLocation?.latitude ?? 0.0,
                  currentLocation?.longitude ?? 0.0,
                ),
                zoom: 15.0,
                onTap: (tapPosition, latLng) => _handleTap(latLng, tapPosition),
              ),


              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    if (currentLocation != null)
                      Marker(
                        point: LatLng(
                          currentLocation!.latitude,
                          currentLocation!.longitude,
                        ),
                        child:  Icon(Icons.location_on),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getCurrentLocation();
                  },
                  child: Text('Get Location'),
                ),
                ElevatedButton(
                  onPressed: () {
                    saveLocationAndNavigateToProductPage();
                  },
                  child: Text('Save Location & Proceed'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _handleTap(LatLng latLng, TapPosition tapPosition) {
    setState(() {
      currentLocation = LocationModel(latitude: latLng.latitude, longitude: latLng.longitude);
      mapController.move(latLng, 15.0);
    });
  }


}