import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled/pages/mapPage.dart';
import 'package:untitled/widgets/gps.dart';

import '../widgets/themebutton.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GPS _gps = GPS();
  Position? _userPosition;
  Exception? _exception;
  double? currentLat;
  double? currentLng;

  void _handlePositionStream(Position position) {
    setState(() {
      _userPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MapPage(
                      currentLat: _userPosition!.latitude,
                      currentLng: _userPosition!.longitude);
                }));
              },
              child: Text('GetYour Current Location'))),
    );
  }

  @override
  void initState() {
    super.initState();
    _gps.startPositionStream(_handlePositionStream);
  }

  @override
  void dispose() {
    super.dispose();
    _gps.stopPositionStream();
  }
}
