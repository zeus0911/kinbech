import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class UserLocation extends StatefulWidget {
  const UserLocation({Key? key}) : super(key: key);

  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  LocationData? _currentLocation;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    try {
      var locationData = await location.getLocation();
      setState(() {
        _currentLocation = locationData;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(_currentLocation?.latitude ?? 0.0,
            _currentLocation?.longitude ?? 0.0),
        zoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(
                _currentLocation?.latitude ?? 0.0,
                _currentLocation?.longitude ?? 0.0,
              ),
              child: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 50,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
